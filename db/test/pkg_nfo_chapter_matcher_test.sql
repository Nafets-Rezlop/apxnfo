--------------------------------------------------------------------------------
-- pkg_nfo_chapter_matcher_test
--
-- Unit-Tests für pkg_nfo_chapter_matcher (Anf. 200, Issue #10). Gleiches Gerüst
-- wie pkg_nfo_chapter_extractor_test: jeder Test in eigener Transaktion mit
-- Rollback, am Ende ORA-20999, falls ein Test fehlschlägt.
--
-- Aufruf:
--   set serveroutput on
--   exec pkg_nfo_chapter_matcher_test.run;
--------------------------------------------------------------------------------

create or replace package pkg_nfo_chapter_matcher_test is

   procedure run;

   -- einzelne Tests, public damit run sie per Namen aufrufen kann
   procedure score_exact_without_speaker;
   procedure score_plural_and_stop_words;
   procedure score_keeps_title_after_dash;
   procedure score_topic_block;
   procedure score_partial;
   procedure score_no_overlap;
   procedure score_only_generic_words;
   procedure score_null;
   procedure preview_has_no_side_effects;
   procedure match_assigns_and_suggests;
   procedure match_chapter_to_many_features;
   procedure match_picks_best_chapter;
   procedure match_only_same_release;
   procedure match_keeps_manual;
   procedure match_is_repeatable;
   procedure match_clears_stale_auto;

end pkg_nfo_chapter_matcher_test;
/

create or replace package body pkg_nfo_chapter_matcher_test is

   g_passed pls_integer;
   g_failed pls_integer;

   ---------------------------------------------------------------------------
   -- Asserts
   ---------------------------------------------------------------------------

   procedure fail (p_msg in varchar2) is
   begin
      raise_application_error(-20990, p_msg);
   end fail;

   procedure assert_eq (p_act in varchar2, p_exp in varchar2, p_msg in varchar2) is
   begin
      if not (p_act = p_exp or (p_act is null and p_exp is null)) then
         fail(p_msg || ': erwartet "' || p_exp || '", erhalten "' || p_act || '"');
      end if;
   end assert_eq;

   ---------------------------------------------------------------------------
   -- Testdaten
   ---------------------------------------------------------------------------

   function new_release (p_key in varchar2) return number is
      l_rec v_nfo_ui_releases%rowtype;
      l_md5 varchar2(32767);
   begin
      l_rec.rel_version := 'T' || p_key;
      pkg_nfo_rel_dml.mrg(l_rec, l_md5);
      return l_rec.rel_id;
   end new_release;

   function new_category return number is
      l_rec v_nfo_ui_categories%rowtype;
      l_md5 varchar2(32767);
   begin
      l_rec.catg_name_de := 'Test Matcher DE';
      l_rec.catg_name_en := 'Test Matcher EN';
      pkg_nfo_catg_dml.mrg(l_rec, l_md5);
      return l_rec.catg_id;
   end new_category;

   function new_video (p_rel_id in number, p_key in varchar2) return number is
      l_rec v_nfo_ui_release_videos%rowtype;
      l_md5 varchar2(32767);
   begin
      l_rec.vid_rel_id      := p_rel_id;
      l_rec.vid_youtube_key := p_key;
      l_rec.vid_youtube_url := 'https://www.youtube.com/watch?v=' || p_key;
      pkg_nfo_vid_dml.mrg(l_rec, l_md5);
      return l_rec.vid_id;
   end new_video;

   function new_chapter (p_vid_id in number, p_key in varchar2, p_seconds in number, p_title in varchar2) return number is
      l_rec v_nfo_ui_video_chapters%rowtype;
      l_md5 varchar2(32767);
   begin
      l_rec.chap_vid_id        := p_vid_id;
      l_rec.chap_start_seconds := p_seconds;
      l_rec.chap_title         := p_title;
      l_rec.chap_link_url      := 'https://youtu.be/' || p_key || '?t=' || p_seconds;
      pkg_nfo_chap_dml.mrg(l_rec, l_md5);
      return l_rec.chap_id;
   end new_chapter;

   function new_feature (p_rel_id in number, p_catg_id in number, p_title in varchar2) return number is
      l_rec v_nfo_ui_features%rowtype;
      l_md5 varchar2(32767);
   begin
      l_rec.feat_rel_id  := p_rel_id;
      l_rec.feat_catg_id := p_catg_id;
      l_rec.feat_title   := p_title;
      pkg_nfo_feat_dml.mrg(l_rec, l_md5);
      return l_rec.feat_id;
   end new_feature;

   function feature_row (p_feat_id in number) return t_nfo_features%rowtype is
      l_row t_nfo_features%rowtype;
   begin
      select * into l_row from t_nfo_features where feat_id = p_feat_id;
      return l_row;
   end feature_row;

   function score (p_feature in varchar2, p_chapter in varchar2) return number is
   begin
      return pkg_nfo_chapter_matcher.score(p_feature, p_chapter);
   end score;

   ---------------------------------------------------------------------------
   -- Tests score, Titel aus 26.1
   ---------------------------------------------------------------------------

   procedure score_exact_without_speaker is
   begin
      assert_eq(score('Data Reporter', 'Data Reporter - Christina Cho'), 1, 'Sprecher zählt nicht');
      assert_eq(score('Data Reporter', 'Data Reporter'), 1, 'ohne Sprecher');
      assert_eq(score('Data Reporter', 'Data Reporter ' || unistr('\2013') || ' Christina Cho'), 1, 'Gedankenstrich');
   end score_exact_without_speaker;

   procedure score_plural_and_stop_words is
   begin
      assert_eq(score('AI Agent Tools', 'AI Agents and Tools - Stefan Dobre'), 1, 'Plural und "and"');
   end score_plural_and_stop_words;

   -- nur der Sprecher am Ende fällt weg, nicht der Teil davor
   procedure score_keeps_title_after_dash is
   begin
      assert_eq(score('Getting Started', 'Oracle APEX 26.1 - Getting Started - Marc Sewtz'), 1, 'mittlerer Teil bleibt');
      assert_eq(score('Agents', 'AI Agents - advanced topics'), 0.82, 'kleingeschriebener Teil ist kein Sprecher');
   end score_keeps_title_after_dash;

   procedure score_topic_block is
   begin
      assert_eq(score('Interactive Report Enhancements', 'Natural Language Reporting with AI Interactive Reporting - Zed Ali'), 0.87, 'Reporting = Report');
      assert_eq(score('APEXlang Features', 'Open Application Specification Language (APEXlang) - Marc Sewtz'), 0.8, 'ein Wort im Themenblock');
   end score_topic_block;

   procedure score_partial is
   begin
      assert_eq(score('AI Tool Guardrails', 'AI Agents and Tools - Stefan Dobre'), 0.67, 'zwei von drei Wörtern');
      assert_eq(score('New Application Types', 'Open Application Specification Language (APEXlang) - Marc Sewtz'), 0.44, 'ein allgemeines Wort');
   end score_partial;

   procedure score_no_overlap is
   begin
      assert_eq(score('Blueprints', 'Data Reporter - Christina Cho'), 0, 'kein Wort gemeinsam');
   end score_no_overlap;

   -- allgemeine Wörter und Versionen allein ergeben keinen Treffer
   procedure score_only_generic_words is
   begin
      assert_eq(score('New Features', 'More on APEX 26.1 - Shakeeb Rahman'), 0, 'nur allgemeine Wörter');
      assert_eq(score('Oracle APEX 26.1', 'Announcing Oracle APEX 26.1 - Marc Sewtz'), 0, 'Feature ohne Wörter');
   end score_only_generic_words;

   procedure score_null is
   begin
      assert_eq(score(null, 'Data Reporter'), 0, 'Feature null');
      assert_eq(score('Data Reporter', null), 0, 'Sprungmarke null');
   end score_null;

   ---------------------------------------------------------------------------
   -- Tests preview und match_release
   ---------------------------------------------------------------------------

   procedure preview_has_no_side_effects is
      l_rel_id  number := new_release('tstmatch001');
      l_vid_id  number := new_video(l_rel_id, 'tstmatch001');
      l_chap_id number := new_chapter(l_vid_id, 'tstmatch001', 10, 'Data Reporter - Christina Cho');
      l_feat_id number := new_feature(l_rel_id, new_category, 'Data Reporter');
      l_action  varchar2(10);
      l_chap    number;
   begin
      select action, chap_id into l_action, l_chap
        from table(pkg_nfo_chapter_matcher.preview(l_rel_id))
       where feat_id = l_feat_id;
      assert_eq(l_action, pkg_nfo_chapter_matcher.c_action_assign, 'Aktion');
      assert_eq(l_chap, l_chap_id, 'Sprungmarke');
      assert_eq(feature_row(l_feat_id).feat_chap_id, null, 'nichts gespeichert');
   end preview_has_no_side_effects;

   -- ab 0,6 zuordnen, ab 0,4 nur vorschlagen, darunter nichts
   procedure match_assigns_and_suggests is
      l_rel_id   number := new_release('tstmatch002');
      l_vid_id   number := new_video(l_rel_id, 'tstmatch002');
      l_chap_id  number := new_chapter(l_vid_id, 'tstmatch002', 10, 'Open Application Specification Language (APEXlang) - Marc Sewtz');
      l_catg_id  number := new_category;
      l_auto     number := new_feature(l_rel_id, l_catg_id, 'APEXlang Features');
      l_suggest  number := new_feature(l_rel_id, l_catg_id, 'New Application Types');
      l_none     number := new_feature(l_rel_id, l_catg_id, 'Blueprints');
      l_assigned pls_integer;
      l_message  varchar2(4000);
   begin
      pkg_nfo_chapter_matcher.match_release(l_rel_id, l_assigned, l_message);
      assert_eq(l_assigned, 1, 'Anzahl');
      assert_eq(l_message, '1 Features zugeordnet, 0 Zuordnungen entfernt, 1 Vorschläge', 'Meldung');
      assert_eq(feature_row(l_auto).feat_chap_id, l_chap_id, 'Treffer zugeordnet');
      assert_eq(feature_row(l_auto).feat_chapter_match_score, 0.8, 'Score gespeichert');
      assert_eq(feature_row(l_auto).feat_upd_user, user, 'upd_user über TAPI');
      assert_eq(feature_row(l_suggest).feat_chap_id, null, 'Vorschlag nicht gespeichert');
      assert_eq(feature_row(l_suggest).feat_chapter_match_score, null, 'Vorschlag ohne Score');
      assert_eq(feature_row(l_none).feat_chap_id, null, 'kein Treffer');
   end match_assigns_and_suggests;

   procedure match_chapter_to_many_features is
      l_rel_id   number := new_release('tstmatch003');
      l_vid_id   number := new_video(l_rel_id, 'tstmatch003');
      l_chap_id  number := new_chapter(l_vid_id, 'tstmatch003', 10, 'AI Agents and Tools - Stefan Dobre');
      l_catg_id  number := new_category;
      l_a        number := new_feature(l_rel_id, l_catg_id, 'AI Agent Tools');
      l_b        number := new_feature(l_rel_id, l_catg_id, 'AI Tool Guardrails');
      l_assigned pls_integer;
      l_message  varchar2(4000);
   begin
      pkg_nfo_chapter_matcher.match_release(l_rel_id, l_assigned, l_message);
      assert_eq(l_assigned, 2, 'Anzahl');
      assert_eq(feature_row(l_a).feat_chap_id, l_chap_id, 'Feature A');
      assert_eq(feature_row(l_b).feat_chap_id, l_chap_id, 'Feature B');
   end match_chapter_to_many_features;

   -- höchster Score gewinnt, bei Gleichstand die frühere Sprungmarke
   procedure match_picks_best_chapter is
      l_rel_id   number := new_release('tstmatch004');
      l_vid_id   number := new_video(l_rel_id, 'tstmatch004');
      l_block    number := new_chapter(l_vid_id, 'tstmatch004', 10, 'Data Reporter and Dashboards');
      l_exact    number := new_chapter(l_vid_id, 'tstmatch004', 20, 'Data Reporter');
      l_first    number := new_chapter(l_vid_id, 'tstmatch004', 30, 'Workflow');
      l_second   number := new_chapter(l_vid_id, 'tstmatch004', 40, 'Workflows');
      l_catg_id  number := new_category;
      l_best     number := new_feature(l_rel_id, l_catg_id, 'Data Reporter');
      l_tie      number := new_feature(l_rel_id, l_catg_id, 'Workflow');
      l_assigned pls_integer;
      l_message  varchar2(4000);
   begin
      pkg_nfo_chapter_matcher.match_release(l_rel_id, l_assigned, l_message);
      assert_eq(feature_row(l_best).feat_chap_id, l_exact, 'exakter Treffer vor Themenblock');
      assert_eq(feature_row(l_best).feat_chapter_match_score, 1, 'Score');
      assert_eq(feature_row(l_tie).feat_chap_id, l_first, 'Gleichstand: frühere Sprungmarke');
   end match_picks_best_chapter;

   procedure match_only_same_release is
      l_rel_a    number := new_release('tstmatch005');
      l_rel_b    number := new_release('tstmatch006');
      l_vid_id   number := new_video(l_rel_b, 'tstmatch006');
      l_chap_id  number := new_chapter(l_vid_id, 'tstmatch006', 10, 'Data Reporter');
      l_feat_id  number := new_feature(l_rel_a, new_category, 'Data Reporter');
      l_assigned pls_integer;
      l_message  varchar2(4000);
   begin
      pkg_nfo_chapter_matcher.match_release(l_rel_a, l_assigned, l_message);
      assert_eq(l_assigned, 0, 'Anzahl');
      assert_eq(feature_row(l_feat_id).feat_chap_id, null, 'Sprungmarke eines anderen Releases');
   end match_only_same_release;

   -- Sprungmarke ohne Score ist manuell zugeordnet und bleibt
   procedure match_keeps_manual is
      l_rel_id   number := new_release('tstmatch007');
      l_vid_id   number := new_video(l_rel_id, 'tstmatch007');
      l_manual   number := new_chapter(l_vid_id, 'tstmatch007', 10, 'Keynote');
      l_exact    number := new_chapter(l_vid_id, 'tstmatch007', 20, 'Data Reporter');
      l_feat_id  number := new_feature(l_rel_id, new_category, 'Data Reporter');
      l_rec      v_nfo_ui_features%rowtype;
      l_md5      varchar2(32767);
      l_assigned pls_integer;
      l_message  varchar2(4000);
   begin
      l_rec.feat_id := l_feat_id;
      pkg_nfo_feat_dml.get(l_rec, l_md5);
      l_rec.feat_chap_id := l_manual;
      pkg_nfo_feat_dml.mrg(l_rec, l_md5);

      pkg_nfo_chapter_matcher.match_release(l_rel_id, l_assigned, l_message);
      assert_eq(l_assigned, 0, 'Anzahl');
      assert_eq(feature_row(l_feat_id).feat_chap_id, l_manual, 'manuelle Zuordnung bleibt');
      assert_eq(feature_row(l_feat_id).feat_chapter_match_score, null, 'Score bleibt leer');
   end match_keeps_manual;

   -- zweiter Lauf ändert nichts
   procedure match_is_repeatable is
      l_rel_id   number := new_release('tstmatch008');
      l_vid_id   number := new_video(l_rel_id, 'tstmatch008');
      l_chap_id  number := new_chapter(l_vid_id, 'tstmatch008', 10, 'Data Reporter');
      l_feat_id  number := new_feature(l_rel_id, new_category, 'Data Reporter');
      l_assigned pls_integer;
      l_message  varchar2(4000);
      l_action   varchar2(10);
   begin
      pkg_nfo_chapter_matcher.match_release(l_rel_id, l_assigned, l_message);
      assert_eq(l_assigned, 1, 'erster Lauf');
      pkg_nfo_chapter_matcher.match_release(l_rel_id, l_assigned, l_message);
      assert_eq(l_assigned, 0, 'zweiter Lauf');
      select action into l_action from table(pkg_nfo_chapter_matcher.preview(l_rel_id)) where feat_id = l_feat_id;
      assert_eq(l_action, pkg_nfo_chapter_matcher.c_action_keep, 'Aktion');
      assert_eq(feature_row(l_feat_id).feat_chap_id, l_chap_id, 'Zuordnung bleibt');
   end match_is_repeatable;

   -- automatische Zuordnung entfällt, wenn der Score nicht mehr reicht
   procedure match_clears_stale_auto is
      l_rel_id   number := new_release('tstmatch009');
      l_vid_id   number := new_video(l_rel_id, 'tstmatch009');
      l_chap_id  number := new_chapter(l_vid_id, 'tstmatch009', 10, 'Data Reporter');
      l_feat_id  number := new_feature(l_rel_id, new_category, 'Data Reporter');
      l_chap     v_nfo_ui_video_chapters%rowtype;
      l_md5      varchar2(32767);
      l_assigned pls_integer;
      l_message  varchar2(4000);
   begin
      pkg_nfo_chapter_matcher.match_release(l_rel_id, l_assigned, l_message);
      assert_eq(feature_row(l_feat_id).feat_chap_id, l_chap_id, 'zugeordnet');

      l_chap.chap_id := l_chap_id;
      pkg_nfo_chap_dml.get(l_chap, l_md5);
      l_chap.chap_title := 'Keynote';
      pkg_nfo_chap_dml.mrg(l_chap, l_md5);

      pkg_nfo_chapter_matcher.match_release(l_rel_id, l_assigned, l_message);
      assert_eq(l_message, '0 Features zugeordnet, 1 Zuordnungen entfernt, 0 Vorschläge', 'Meldung');
      assert_eq(feature_row(l_feat_id).feat_chap_id, null, 'Zuordnung entfernt');
      assert_eq(feature_row(l_feat_id).feat_chapter_match_score, null, 'Score entfernt');
   end match_clears_stale_auto;

   ---------------------------------------------------------------------------
   -- Runner
   ---------------------------------------------------------------------------

   procedure exec_test (p_name in varchar2) is
   begin
      execute immediate 'begin pkg_nfo_chapter_matcher_test.' || p_name || '; end;';
      rollback;
      g_passed := g_passed + 1;
      dbms_output.put_line('PASS  ' || p_name);
   exception
      when others then
         rollback;
         g_failed := g_failed + 1;
         dbms_output.put_line('FAIL  ' || p_name || ': ' || sqlerrm);
   end exec_test;

   procedure run is
   begin
      -- ADB (Service HIGH) arbeitet sonst mit Parallel DML: ORA-12839 und ORA-12860.
      -- Umschalten geht nur ohne offene Transaktion (ORA-12841), daher der Rollback.
      rollback;
      execute immediate 'alter session disable parallel dml';
      g_passed := 0;
      g_failed := 0;
      exec_test('score_exact_without_speaker');
      exec_test('score_plural_and_stop_words');
      exec_test('score_keeps_title_after_dash');
      exec_test('score_topic_block');
      exec_test('score_partial');
      exec_test('score_no_overlap');
      exec_test('score_only_generic_words');
      exec_test('score_null');
      exec_test('preview_has_no_side_effects');
      exec_test('match_assigns_and_suggests');
      exec_test('match_chapter_to_many_features');
      exec_test('match_picks_best_chapter');
      exec_test('match_only_same_release');
      exec_test('match_keeps_manual');
      exec_test('match_is_repeatable');
      exec_test('match_clears_stale_auto');
      dbms_output.put_line('----');
      dbms_output.put_line(g_passed || ' bestanden, ' || g_failed || ' fehlgeschlagen');
      if g_failed > 0 then
         raise_application_error(-20999, g_failed || ' Test(s) fehlgeschlagen');
      end if;
   end run;

end pkg_nfo_chapter_matcher_test;
/
