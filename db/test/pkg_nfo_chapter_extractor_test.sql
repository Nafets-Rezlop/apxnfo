--------------------------------------------------------------------------------
-- pkg_nfo_chapter_extractor_test
--
-- Unit-Tests für pkg_nfo_chapter_extractor (Anf. 220-240). Gleiches Gerüst wie
-- pkg_nfo_tapi_test: jeder Test in eigener Transaktion mit Rollback, am Ende
-- ORA-20999, falls ein Test fehlschlägt.
--
-- Aufruf:
--   set serveroutput on
--   exec pkg_nfo_chapter_extractor_test.run;
--------------------------------------------------------------------------------

create or replace package pkg_nfo_chapter_extractor_test is

   procedure run;

   -- einzelne Tests, public damit run sie per Namen aufrufen kann
   procedure parse_release_description;
   procedure parse_formats;
   procedure parse_ignores_other_lines;
   procedure parse_empty;
   procedure extract_video_writes_chapters;
   procedure extract_video_repeatable;
   procedure extract_video_none;

end pkg_nfo_chapter_extractor_test;
/

create or replace package body pkg_nfo_chapter_extractor_test is

   g_passed pls_integer;
   g_failed pls_integer;

   -- Beschreibung von "APEX 26.1 Part 1" (w31Et4XFq7g), wie auf YouTube
   c_desc_261 constant varchar2(4000) := q'[In this session, we presented and demonstrated the marquee features of APEX 26.1.

00:11 - Announcing Oracle APEX 26.1 - Marc Sewtz
06:15 - Open Application Specification Language (APEXlang) - Marc Sewtz
18:01 - Natural Language Reporting with AI Interactive Reporting - Zed Ali
26:41 - Data Reporter - Christina Cho
33:59 - AI Agents and Tools - Stefan Dobre
43:01 - Redesigned Builder Interface and Universal Theme 26.1 - Paige Hanssen
47:55 - More on APEX 26.1 - Shakeeb Rahman

 53:33 - Oracle APEX 26.1 - Getting Started - Marc Sewtz Find the Q&A from the live session here: oracleapex.com/officehours/]';

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

   -- Video an einem Test-Release, Beschreibung direkt gesetzt
   function new_video (p_key in varchar2, p_description in clob) return number is
      l_rel v_nfo_ui_releases%rowtype;
      l_vid v_nfo_ui_release_videos%rowtype;
      l_md5 varchar2(32767);
   begin
      l_rel.rel_version := 'T' || p_key;
      pkg_nfo_rel_dml.mrg(l_rel, l_md5);
      l_vid.vid_rel_id      := l_rel.rel_id;
      l_vid.vid_youtube_key := p_key;
      l_vid.vid_youtube_url := 'https://www.youtube.com/watch?v=' || p_key;
      l_vid.vid_description := p_description;
      pkg_nfo_vid_dml.mrg(l_vid, l_md5);
      return l_vid.vid_id;
   end new_video;

   function chapter_count (p_vid_id in number) return number is
      l_cnt number;
   begin
      select count(*) into l_cnt from t_nfo_video_chapters where chap_vid_id = p_vid_id;
      return l_cnt;
   end chapter_count;

   ---------------------------------------------------------------------------
   -- Tests parse
   ---------------------------------------------------------------------------

   -- echte Beschreibung: 8 Sprungmarken, Einleitung ignoriert, Anhang abgeschnitten
   procedure parse_release_description is
      l_ch pkg_nfo_chapter_extractor.t_chapters;
   begin
      l_ch := pkg_nfo_chapter_extractor.parse(c_desc_261, 'w31Et4XFq7g');
      assert_eq(l_ch.count, 8, 'Anzahl');
      assert_eq(l_ch(1).start_seconds, 11, 'Start 1');
      assert_eq(l_ch(1).title, 'Announcing Oracle APEX 26.1 - Marc Sewtz', 'Titel 1');
      assert_eq(l_ch(1).link_url, 'https://youtu.be/w31Et4XFq7g?t=11', 'Link 1');
      assert_eq(l_ch(2).start_seconds, 375, 'Start 2');
      assert_eq(l_ch(6).title, 'Redesigned Builder Interface and Universal Theme 26.1 - Paige Hanssen', 'Titel 6');
      -- führendes Leerzeichen, angehängter Q&A-Hinweis mit URL
      assert_eq(l_ch(8).start_seconds, 3213, 'Start 8');
      assert_eq(l_ch(8).title, 'Oracle APEX 26.1 - Getting Started - Marc Sewtz', 'Titel 8');
   end parse_release_description;

   -- Stunden, ohne Bindestrich, Gedankenstrich, Doppelpunkt, Windows-Zeilenende, URL im Titel
   procedure parse_formats is
      l_ch pkg_nfo_chapter_extractor.t_chapters;
   begin
      l_ch := pkg_nfo_chapter_extractor.parse(
                 '0:00 Intro' || chr(13) || chr(10)
              || '1:02:30 Deep Dive' || chr(10)
              || '12:05 ' || unistr('\2013') || ' En Dash' || chr(10)
              || '75:10: Long Video' || chr(10)
              || '2:00 - Demo https://apex.oracle.com/demo',
                 'abcdefghijk');
      assert_eq(l_ch.count, 5, 'Anzahl');
      assert_eq(l_ch(1).start_seconds, 0, 'Start 0:00');
      assert_eq(l_ch(1).title, 'Intro', 'Titel ohne CR');
      assert_eq(l_ch(2).start_seconds, 3750, 'Start 1:02:30');
      assert_eq(l_ch(2).title, 'Deep Dive', 'Titel ohne Trenner');
      assert_eq(l_ch(3).start_seconds, 725, 'Start 12:05');
      assert_eq(l_ch(3).title, 'En Dash', 'Titel nach Gedankenstrich');
      assert_eq(l_ch(4).start_seconds, 4510, 'Start 75:10');
      assert_eq(l_ch(4).title, 'Long Video', 'Titel nach Doppelpunkt');
      assert_eq(l_ch(5).title, 'Demo', 'URL abgeschnitten');
   end parse_formats;

   -- Text, Uhrzeiten und ungültige Zeitmarken sind keine Sprungmarken
   procedure parse_ignores_other_lines is
      l_ch pkg_nfo_chapter_extractor.t_chapters;
   begin
      l_ch := pkg_nfo_chapter_extractor.parse(
                 'Join us at 10:30am for Office Hours' || chr(10)
              || '10:30am meeting' || chr(10)
              || '12:75 invalid seconds' || chr(10)
              || '12:30' || chr(10)
              || 'Version 26.1',
                 'abcdefghijk');
      assert_eq(l_ch.count, 0, 'Anzahl');
   end parse_ignores_other_lines;

   procedure parse_empty is
   begin
      assert_eq(pkg_nfo_chapter_extractor.parse(null, 'abcdefghijk').count, 0, 'null');
      assert_eq(pkg_nfo_chapter_extractor.parse(empty_clob(), 'abcdefghijk').count, 0, 'empty_clob');
   end parse_empty;

   ---------------------------------------------------------------------------
   -- Tests extract_video
   ---------------------------------------------------------------------------

   procedure extract_video_writes_chapters is
      l_vid_id  number := new_video('tstchap0001', c_desc_261);
      l_count   pls_integer;
      l_message varchar2(4000);
      l_row     t_nfo_video_chapters%rowtype;
   begin
      pkg_nfo_chapter_extractor.extract_video(l_vid_id, l_count, l_message);
      assert_eq(l_count, 8, 'Anzahl');
      assert_eq(l_message, '8 Sprungmarken gefunden', 'Meldung');
      assert_eq(chapter_count(l_vid_id), 8, 'Zeilen in t_nfo_video_chapters');

      select * into l_row from t_nfo_video_chapters where chap_link_url = 'https://youtu.be/tstchap0001?t=1601';
      assert_eq(l_row.chap_vid_id, l_vid_id, 'vid_id');
      assert_eq(l_row.chap_title, 'Data Reporter - Christina Cho', 'Titel 26:41');
      assert_eq(l_row.chap_ins_user, user, 'ins_user über TAPI');
   end extract_video_writes_chapters;

   -- zweiter Lauf legt nichts doppelt an
   procedure extract_video_repeatable is
      l_vid_id  number := new_video('tstchap0002', c_desc_261);
      l_count   pls_integer;
      l_message varchar2(4000);
   begin
      pkg_nfo_chapter_extractor.extract_video(l_vid_id, l_count, l_message);
      pkg_nfo_chapter_extractor.extract_video(l_vid_id, l_count, l_message);
      assert_eq(chapter_count(l_vid_id), 8, 'Zeilen nach zweitem Lauf');
   end extract_video_repeatable;

   -- ohne Sprungmarken: Meldung nach Anf. 230
   procedure extract_video_none is
      l_vid_id  number := new_video('tstchap0003', 'Nur Text, keine Zeitmarken.');
      l_count   pls_integer;
      l_message varchar2(4000);
   begin
      pkg_nfo_chapter_extractor.extract_video(l_vid_id, l_count, l_message);
      assert_eq(l_count, 0, 'Anzahl');
      assert_eq(l_message, 'Keine Sprungmarken gefunden', 'Meldung');
   end extract_video_none;

   ---------------------------------------------------------------------------
   -- Runner
   ---------------------------------------------------------------------------

   procedure exec_test (p_name in varchar2) is
   begin
      execute immediate 'begin pkg_nfo_chapter_extractor_test.' || p_name || '; end;';
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
      exec_test('parse_release_description');
      exec_test('parse_formats');
      exec_test('parse_ignores_other_lines');
      exec_test('parse_empty');
      exec_test('extract_video_writes_chapters');
      exec_test('extract_video_repeatable');
      exec_test('extract_video_none');
      dbms_output.put_line('----');
      dbms_output.put_line(g_passed || ' bestanden, ' || g_failed || ' fehlgeschlagen');
      if g_failed > 0 then
         raise_application_error(-20999, g_failed || ' Test(s) fehlgeschlagen');
      end if;
   end run;

end pkg_nfo_chapter_extractor_test;
/
