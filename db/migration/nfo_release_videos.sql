--------------------------------------------------------------------------------
-- Release-Videos von YouTube (Anf. 200, 210, 240)
--
-- Quelle: Kanäle "Oracle Developers" (@oracledevs) und "Oracle APEX"
-- (@OracleAPEX), Titel und Kanal je Video über YouTube oEmbed geprüft
-- (Stand 01.11.2026). Hauptvideo (Anf. 210) ist jeweils Teil 1 der
-- "What's new"-Reihe eines Releases.
--
-- Nicht gefunden: 18.1, 18.2, 19.1, 19.2 sowie 23.2 Teil 3.
--
-- Beschreibungen (vid_description) lädt YouTube nur im Browser, sie werden
-- manuell kopiert. Vorhanden: 26.1 Teil 1 und Teil 2.
--
-- Wiederholbar: vorhandene Videos (YouTube-ID) werden aktualisiert.
-- Voraussetzung: Releases sind migriert (run_migration.sql).
--------------------------------------------------------------------------------

whenever sqlerror exit failure
set define off
set serveroutput on size unlimited

declare
   -- p_description: YouTube-Beschreibung (Quelle der Sprungmarken, Anf. 220).
   -- Leer = gespeicherte Beschreibung bleibt erhalten.
   procedure mrg_video (p_version in varchar2, p_key in varchar2, p_title in varchar2, p_is_main in varchar2,
                        p_description in clob default null) is
      l_rec v_nfo_ui_release_videos%rowtype;
      l_md5 varchar2(32767);
   begin
      begin
         select vid_id into l_rec.vid_id from t_nfo_release_videos where vid_youtube_key = p_key;
         pkg_nfo_vid_dml.get(l_rec, l_md5);
      exception
         when no_data_found then
            null;
      end;
      select rel_id into l_rec.vid_rel_id from t_nfo_releases where rel_version = p_version;
      l_rec.vid_title       := p_title;
      l_rec.vid_youtube_key := p_key;
      l_rec.vid_youtube_url := 'https://www.youtube.com/watch?v=' || p_key;
      l_rec.vid_is_main     := p_is_main;
      if p_description is not null then
         l_rec.vid_description := p_description;
         l_rec.vid_fetched_at  := sysdate;
      end if;
      pkg_nfo_vid_dml.mrg(l_rec, l_md5);
   exception
      when no_data_found then
         raise_application_error(-20100, 'Release ' || p_version || ' fehlt für Video ' || p_key);
   end mrg_video;
begin
   -- 26.2 (Oracle APEX)
   mrg_video('26.2', 'gM-1GlVpqxI', 'What’s New in Oracle APEX 26.2', 'Y');
   mrg_video('26.2', 'ZbwxbnOhvG0', 'What’s New in Oracle APEX 26.2: APEXlang, Interactive Reports, Charts, and Accessibility', 'N',
q'[What’s new in Oracle APEX 26.2, and which enhancements should APEX developers evaluate first?

This webinar demonstrates selected APEX 26.2 features, including APEXlang enhancements and chart performance and accessibility improvements, so you can see what has changed and where these capabilities may fit in your applications.

You’ll learn how to:
- Review selected changes in Oracle APEX 26.2
- Explore APEXlang enhancements for application development workflows
- Understand chart performance and accessibility enhancements

00:00 Welcome and Oracle APEX 26.2 overview
07:00 APEXlang enhancements
21:30 Interactive Reports Modernization
37:15 Chart performance and accessibility enhancements
60:00 Closing remarks]');
   -- 26.1 (Oracle Developers)
   -- Beschreibung manuell von YouTube kopiert (01.11.2026)
   mrg_video('26.1', 'w31Et4XFq7g', 'APEX 26.1 Part 1: APEXlang, AI Reporting, Data Reporter, AI Agents & Redesigned Builder', 'Y',
q'[In this session, we presented and demonstrated the marquee features of APEX 26.1.

00:11 - Announcing Oracle APEX 26.1 - Marc Sewtz
06:15 - Open Application Specification Language (APEXlang) - Marc Sewtz
18:01 - Natural Language Reporting with AI Interactive Reporting - Zed Ali
26:41 - Data Reporter - Christina Cho
33:59 - AI Agents and Tools - Stefan Dobre
43:01 - Redesigned Builder Interface and Universal Theme 26.1 - Paige Hanssen
47:55 - More on APEX 26.1 - Shakeeb Rahman

 53:33 - Oracle APEX 26.1 - Getting Started - Marc Sewtz Find the Q&A from the live session here: oracleapex.com/officehours/]');
   mrg_video('26.1', 'NNmUMd6c1-s', 'APEX 26.1 - Part 2: Getting Started with APEXlang', 'N',
q'[In this session, we presented and demonstrated the marquee features of APEX 26.1.

03:48 - Introduction, Announcements and Updates - Jayson Hanes
06:15 - Getting Started with APEXlang - Scott Spendolini
36:33 - Conclusion. Explore APEX Ideas and More Features in APEX 26.1 - Jayson Hanes Find the Q&A from the live session here: oracleapex.com/officehours/]');
   mrg_video('26.1', 'Di3XLa9fjuA', 'APEX 26.1 Part 3: Build Intelligent AI Agents & Tools with Advanced Features and Live Demos', 'N');
   -- 24.2
   mrg_video('24.2', 'P0kTt9agzG4', 'What''s New in APEX 24.2 - Part 1', 'Y');
   mrg_video('24.2', 'Ue2YwUGoJIQ', 'What''s New in APEX 24.2 - Part 2', 'N');
   mrg_video('24.2', '_mJ3rvAelPc', 'What''s New in APEX 24.2 - Part 3', 'N');
   mrg_video('24.2', 'MbD8-ZBoCdE', 'What''s New in APEX 24.2 - Part 4', 'N');
   -- 24.1
   mrg_video('24.1', '0F5Tu7xQuXE', 'What''s new in Oracle APEX 24.1 - Part 1', 'Y');
   mrg_video('24.1', 'i4y0BzPOfrs', 'What''s new in Oracle APEX 24.1 - Part 2', 'N');
   mrg_video('24.1', '1vlp3DN1WlU', 'What''s new in Oracle APEX 24.1 - Part 3', 'N');
   mrg_video('24.1', 'MCc3Z0FJado', 'What''s new in Oracle APEX 24.1 - Part 4', 'N');
   -- 23.2
   mrg_video('23.2', 'JyY3p1R_ThQ', 'Part 1: What''s new in Oracle APEX 23.2 - Preview', 'Y');
   mrg_video('23.2', 'eGfyj6zPkCM', 'Part 2: What''s new in Oracle APEX 23.2 - Preview', 'N');
   mrg_video('23.2', '5cmT8dFJkz0', 'Part 4: What''s new in Oracle APEX 23.2 - Preview', 'N');
   mrg_video('23.2', 'uATRJzB3VPc', 'Part 5: What''s new in Oracle APEX 23.2 - Preview', 'N');
   -- 23.1
   mrg_video('23.1', 'mBhGBjFa1V8', 'Part 1: What''s new in Oracle APEX 23.1', 'Y');
   mrg_video('23.1', '4ZRzLK4I6aY', 'Part 2: What''s new in Oracle APEX 23.1', 'N');
   mrg_video('23.1', 'EsLoU7Jj-AU', 'Part 3: What''s new in Oracle APEX 23.1', 'N');
   mrg_video('23.1', 'nWcSnj7eisU', 'Part 4: What''s new in Oracle APEX 23.1', 'N');
   -- 22.2 (Oracle Learning)
   mrg_video('22.2', 'aRC6YuIqrUs', 'What''s New in APEX 22.2?', 'Y');
   -- 22.1
   mrg_video('22.1', 'wEByBTc_dp0', 'New in APEX 22.1 (Part 1): Sneak Preview', 'Y');
   mrg_video('22.1', 'TbBs_ZXro-g', 'New in APEX 22.1 (Part 2): Approvals, Data Generator, and Search Enhancements', 'N');
   mrg_video('22.1', 'pbMfCECO3AU', 'New in APEX 22.1 (Part 3): Ed. Improvements, REST Enabled SQL Queries, and easy App Gallery Installs', 'N');
   mrg_video('22.1', '7qklHBqKE3s', 'New in APEX 22.1 (Part 4): Developer Experience Updates', 'N');
   mrg_video('22.1', 'ZU2i9lSgOyk', 'New in APEX 22.1 (Part 5): UI, PWA and Mobile', 'N');
   -- 21.2 (Oracle Developers)
   mrg_video('21.2', 'qcg6GZw68mA', 'Oracle APEX 21.2 New Features', 'Y');
   mrg_video('21.2', '9Wt2QtM6SDk', 'Oracle APEX 21.2 New Features (Part 2)', 'N');
   -- 21.1, 20.2, 20.1
   mrg_video('21.1', 'QVPGnb0UsZY', 'What''s new in APEX 21.1', 'Y');
   mrg_video('20.2', 'fYq-6Jd_4No', 'What''s new in APEX 20.2', 'Y');
   mrg_video('20.1', 'b9MEa5Idd1s', 'The Top 12 New Features in APEX 20.1 that Everyone Should Know!', 'Y');
end;
/

commit;

select v.rel_version, v.vid_is_main, v.vid_youtube_key, v.vid_title
  from v_nfo_ui_release_videos v
 order by to_number(regexp_substr(v.rel_version, '^\d+')) desc,
          to_number(regexp_substr(v.rel_version, '\d+$')) desc,
          v.vid_is_main desc, v.vid_title;
