--------------------------------------------------------------------------------
-- pkg_nfo_chapter_extractor
--
-- Liest die Sprungmarken aus der YouTube-Beschreibung eines Release-Videos
-- (t_nfo_release_videos.vid_description) und schreibt sie über
-- pkg_nfo_chap_dml nach t_nfo_video_chapters (Anf. 220, 230, 240).
--
-- Erkennung, je Zeile der Beschreibung:
--   - Zeile beginnt (nach trim) mit einer Zeitmarke [h:]mm:ss
--   - danach mindestens ein Trenner: Leerzeichen, "-", "–" oder ":"
--   - der Rest ist der Titel
--   Beispiele: "06:15 - APEXlang", "1:02:30 Deep Dive", "0:00 Intro"
--   Keine Sprungmarke: "In this session ...", "10:30am"
--
-- Titel bereinigen (Heuristik): angehängte Hinweise ab "Find the ..." und ab
-- einer URL (http(s)://, www., domain.tld/) werden abgeschnitten.
--
-- Link (Anf. 240): https://youtu.be/<vid_youtube_key>?t=<Sekunden>. Er ist der
-- fachliche Schlüssel: erneutes Extrahieren aktualisiert vorhandene
-- Sprungmarken. Sprungmarken, die nicht mehr in der Beschreibung stehen,
-- bleiben erhalten, weil Features auf sie verweisen können.
--
-- Die Zuordnung Feature -> Sprungmarke (feat_chap_id) ist nicht Teil dieses
-- Packages.
--
-- Aufruf:
--   exec pkg_nfo_chapter_extractor.extract_all;
--------------------------------------------------------------------------------

create or replace package pkg_nfo_chapter_extractor is

   c_msg_none constant varchar2(100) := 'Keine Sprungmarken gefunden';

   type t_chapter is record (
      start_seconds t_nfo_video_chapters.chap_start_seconds%type,
      title         t_nfo_video_chapters.chap_title%type,
      link_url      t_nfo_video_chapters.chap_link_url%type
   );
   type t_chapters is table of t_chapter index by pls_integer;

   -- Sprungmarken aus einem Beschreibungstext, ohne DML
   function parse (p_description in clob, p_youtube_key in varchar2) return t_chapters;

   -- Sprungmarken eines Videos extrahieren und speichern.
   -- p_message: "<n> Sprungmarken gefunden" oder c_msg_none (Anf. 230)
   procedure extract_video (p_vid_id in number, p_count out pls_integer, p_message out varchar2);

   -- alle Videos mit Beschreibung, Ausgabe per dbms_output
   procedure extract_all;

end pkg_nfo_chapter_extractor;
/

create or replace package body pkg_nfo_chapter_extractor is

   -- [h:]mm:ss, Trenner, Titel
   c_line_pattern constant varchar2(200) :=
      '^(([0-9]{1,2}):)?([0-9]{1,3}):([0-5][0-9])[[:space:]:' || unistr('\2013') || '-]+(.+)$';

   c_url_pattern  constant varchar2(200) :=
      '[[:space:]]*(https?://|www\.|[a-z0-9-]+\.[a-z]{2,}/).*$';

   function clean_title (p_title in varchar2) return varchar2 is
      l_title varchar2(32767) := p_title;
   begin
      l_title := regexp_replace(l_title, '[[:space:]]+Find the .*$', null, 1, 1, 'i');
      l_title := regexp_replace(l_title, c_url_pattern, null, 1, 1, 'i');
      return substr(rtrim(trim(l_title), ' -:' || unistr('\2013')), 1, 500);
   end clean_title;

   function parse_line (p_line in varchar2, p_youtube_key in varchar2, p_chapter out t_chapter) return boolean is
      l_line varchar2(32767) := trim(p_line);
   begin
      if not regexp_like(l_line, c_line_pattern) then
         return false;
      end if;
      p_chapter.start_seconds := nvl(to_number(regexp_substr(l_line, c_line_pattern, 1, 1, null, 2)), 0) * 3600
                               + to_number(regexp_substr(l_line, c_line_pattern, 1, 1, null, 3)) * 60
                               + to_number(regexp_substr(l_line, c_line_pattern, 1, 1, null, 4));
      p_chapter.title         := clean_title(regexp_substr(l_line, c_line_pattern, 1, 1, null, 5));
      p_chapter.link_url      := 'https://youtu.be/' || p_youtube_key || '?t=' || p_chapter.start_seconds;
      return true;
   end parse_line;

   function parse (p_description in clob, p_youtube_key in varchar2) return t_chapters is
      l_chapters t_chapters;
      l_chapter  t_chapter;
      l_text     clob := replace(p_description, chr(13));
      l_len      pls_integer := nvl(dbms_lob.getlength(l_text), 0);
      l_pos      pls_integer := 1;
      l_end      pls_integer;
   begin
      while l_pos <= l_len loop
         l_end := dbms_lob.instr(l_text, chr(10), l_pos);
         if l_end = 0 then
            l_end := l_len + 1;
         end if;
         if l_end > l_pos
            and parse_line(dbms_lob.substr(l_text, least(l_end - l_pos, 32767), l_pos), p_youtube_key, l_chapter)
         then
            l_chapters(l_chapters.count + 1) := l_chapter;
         end if;
         l_pos := l_end + 1;
      end loop;
      return l_chapters;
   end parse;

   procedure extract_video (p_vid_id in number, p_count out pls_integer, p_message out varchar2) is
      l_video    t_nfo_release_videos%rowtype;
      l_chapters t_chapters;
      l_rec      v_nfo_ui_video_chapters%rowtype;
      l_empty    v_nfo_ui_video_chapters%rowtype;
      l_md5      varchar2(32767);
   begin
      select * into l_video from t_nfo_release_videos where vid_id = p_vid_id;
      l_chapters := parse(l_video.vid_description, l_video.vid_youtube_key);

      for i in 1 .. l_chapters.count loop
         l_rec := l_empty;
         l_md5 := null;
         begin
            select chap_id into l_rec.chap_id from t_nfo_video_chapters where chap_link_url = l_chapters(i).link_url;
            pkg_nfo_chap_dml.get(l_rec, l_md5);
         exception
            when no_data_found then
               null;
         end;
         l_rec.chap_vid_id        := p_vid_id;
         l_rec.chap_start_seconds := l_chapters(i).start_seconds;
         l_rec.chap_title         := l_chapters(i).title;
         l_rec.chap_link_url      := l_chapters(i).link_url;
         pkg_nfo_chap_dml.mrg(l_rec, l_md5);
      end loop;

      p_count   := l_chapters.count;
      p_message := case when p_count = 0 then c_msg_none else p_count || ' Sprungmarken gefunden' end;
   end extract_video;

   procedure extract_all is
      l_count   pls_integer;
      l_message varchar2(4000);
   begin
      for r in (
         select vid_id, vid_youtube_key, vid_title
           from t_nfo_release_videos
          where vid_description is not null
          order by vid_id
      ) loop
         extract_video(r.vid_id, l_count, l_message);
         dbms_output.put_line(r.vid_youtube_key || '  ' || l_message || '  (' || r.vid_title || ')');
      end loop;
   end extract_all;

end pkg_nfo_chapter_extractor;
/
