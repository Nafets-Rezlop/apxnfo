--------------------------------------------------------------------------------
-- pkg_nfo_chapter_matcher
--
-- Ordnet Features die passende Sprungmarke desselben Releases zu (Anf. 200,
-- Issue #10), indem es Featuretitel und Titel der Sprungmarke vergleicht. Setzt
-- feat_chap_id und feat_chapter_match_score über pkg_nfo_feat_dml. Ein Feature
-- hat höchstens eine Sprungmarke, eine Sprungmarke kann zu mehreren Features
-- passen (Themenblöcke wie "AI Agents and Tools").
--
-- Vergleich:
--   - Sprungmarke: angehängter Sprecher entfällt (" - Marc Sewtz"). Heuristik:
--     zwei bis drei großgeschriebene Wörter nach dem letzten Bindestrich.
--   - beide Titel: Kleinschrift, nur Buchstaben und Ziffern, ohne Zahlen,
--     einzelne Zeichen und allgemeine Wörter (c_stop_words). Einfaches Stemming:
--     "Agents" = "Agent", "Reporting" = "Report".
--   - Score = 0,7 * Anteil der Feature-Wörter, die in der Sprungmarke vorkommen,
--           + 0,3 * Dice-Koeffizient beider Wortmengen, auf 2 Stellen gerundet.
--     Der Anteil überwiegt, weil Sprungmarken Themenblöcke sind und mehr Wörter
--     enthalten als ein einzelnes Feature.
--
-- Entscheidung je Feature (Spalte action der Vorschau):
--   MANUAL   feat_chap_id gesetzt, Score leer: manuelle Zuordnung, bleibt erhalten
--   ASSIGN   Score >= p_min_auto: zuordnen oder Score aktualisieren
--   KEEP     Score >= p_min_auto: Zuordnung und Score sind schon aktuell
--   CLEAR    frühere automatische Zuordnung, Score jetzt zu niedrig: entfernen
--   SUGGEST  Score >= p_min_suggest: nur Vorschlag, wird nicht gespeichert
--   NONE     keine passende Sprungmarke
--
-- Kein commit, das macht der Aufrufer (wie pkg_nfo_chapter_extractor).
--
-- Aufruf:
--   select * from pkg_nfo_chapter_matcher.preview(:rel_id);
--   exec pkg_nfo_chapter_matcher.match_all;
--------------------------------------------------------------------------------

create or replace package pkg_nfo_chapter_matcher is

   c_min_auto    constant number := 0.6;
   c_min_suggest constant number := 0.4;

   c_action_manual  constant varchar2(10) := 'MANUAL';
   c_action_assign  constant varchar2(10) := 'ASSIGN';
   c_action_keep    constant varchar2(10) := 'KEEP';
   c_action_clear   constant varchar2(10) := 'CLEAR';
   c_action_suggest constant varchar2(10) := 'SUGGEST';
   c_action_none    constant varchar2(10) := 'NONE';

   type t_match is record (
      feat_id       t_nfo_features.feat_id%type,
      feat_title    t_nfo_features.feat_title%type,
      cur_chap_id   t_nfo_features.feat_chap_id%type,
      chap_id       t_nfo_video_chapters.chap_id%type,   -- beste Sprungmarke
      chap_title    t_nfo_video_chapters.chap_title%type,
      score         number,
      action        varchar2(10)
   );
   type t_matches is table of t_match;

   -- Ähnlichkeit 0-1 von Featuretitel und Titel der Sprungmarke
   function score (p_feature_title in varchar2, p_chapter_title in varchar2) return number;

   -- Entscheidung je Feature eines Releases, ohne DML
   function preview (
      p_rel_id      in number,
      p_min_auto    in number default c_min_auto,
      p_min_suggest in number default c_min_suggest) return t_matches pipelined;

   -- Entscheidungen eines Releases speichern.
   -- p_message: "<n> Features zugeordnet, <m> Zuordnungen entfernt, <k> Vorschläge"
   procedure match_release (
      p_rel_id   in  number,
      p_assigned out pls_integer,
      p_message  out varchar2,
      p_min_auto in  number default c_min_auto);

   -- alle Releases mit Sprungmarken, Ausgabe per dbms_output
   procedure match_all;

end pkg_nfo_chapter_matcher;
/

create or replace package body pkg_nfo_chapter_matcher is

   c_weight_contained constant number := 0.7;
   c_weight_dice      constant number := 0.3;

   c_stop_words constant varchar2(500) :=
      ' a an and at by for from in into is of on or the to with using via'
      || ' new oracle apex support feature enhancement improvement update other additional more added ';

   c_speaker_pattern constant varchar2(200) :=
      '[[:space:]]+[-' || unistr('\2013') || '][[:space:]]+[[:upper:]][[:lower:]]+([[:space:]][[:upper:]][[:lower:]]+){1,2}[[:space:]]*$';

   type t_tokens is table of boolean index by varchar2(100);

   function stem (p_token in varchar2) return varchar2 is
   begin
      if length(p_token) >= 7 and p_token like '%ing' then
         return substr(p_token, 1, length(p_token) - 3);
      elsif length(p_token) >= 4 and p_token like '%s' and not regexp_like(p_token, '(ss|us|is)$') then
         return substr(p_token, 1, length(p_token) - 1);
      end if;
      return p_token;
   end stem;

   function tokens (p_text in varchar2) return t_tokens is
      l_tokens t_tokens;
      l_text   varchar2(32767) := regexp_replace(lower(p_text), '[^a-z0-9]+', ' ');
      l_token  varchar2(100);
      l_pos    pls_integer := 1;
   begin
      loop
         l_token := substr(regexp_substr(l_text, '[^ ]+', 1, l_pos), 1, 100);
         exit when l_token is null;
         l_token := stem(l_token);
         if length(l_token) > 1
            and not regexp_like(l_token, '^[0-9]+$')
            and instr(c_stop_words, ' ' || l_token || ' ') = 0
         then
            l_tokens(l_token) := true;
         end if;
         l_pos := l_pos + 1;
      end loop;
      return l_tokens;
   end tokens;

   function score (p_feature_title in varchar2, p_chapter_title in varchar2) return number is
      l_feature t_tokens := tokens(p_feature_title);
      l_chapter t_tokens := tokens(regexp_replace(p_chapter_title, c_speaker_pattern, null, 1, 1, 'c'));
      l_common  pls_integer := 0;
      l_token   varchar2(100);
   begin
      if l_feature.count = 0 or l_chapter.count = 0 then
         return 0;
      end if;

      l_token := l_feature.first;
      while l_token is not null loop
         if l_chapter.exists(l_token) then
            l_common := l_common + 1;
         end if;
         l_token := l_feature.next(l_token);
      end loop;

      return round(c_weight_contained * l_common / l_feature.count
                 + c_weight_dice * 2 * l_common / (l_feature.count + l_chapter.count), 2);
   end score;

   function preview (
      p_rel_id      in number,
      p_min_auto    in number default c_min_auto,
      p_min_suggest in number default c_min_suggest) return t_matches pipelined
   is
      l_match t_match;
   begin
      for r in (
         select feat_id, feat_title, feat_chap_id, feat_chapter_match_score, chap_id, chap_title, match_score
           from (select s.*,
                        row_number() over (partition by s.feat_id order by s.match_score desc, s.chap_start_seconds, s.chap_id) as rn
                   from (select f.feat_id, f.feat_title, f.feat_chap_id, f.feat_chapter_match_score,
                                c.chap_id, c.chap_title, c.chap_start_seconds,
                                nvl(pkg_nfo_chapter_matcher.score(f.feat_title, c.chap_title), 0) as match_score
                           from t_nfo_features f
                           left join (select ch.chap_id, ch.chap_title, ch.chap_start_seconds, v.vid_rel_id
                                        from t_nfo_video_chapters ch
                                        join t_nfo_release_videos v on v.vid_id = ch.chap_vid_id) c
                             on c.vid_rel_id = f.feat_rel_id
                          where f.feat_rel_id = p_rel_id) s)
          where rn = 1
          order by match_score desc, feat_id
      ) loop
         l_match.feat_id     := r.feat_id;
         l_match.feat_title  := r.feat_title;
         l_match.cur_chap_id := r.feat_chap_id;
         l_match.chap_id     := r.chap_id;
         l_match.chap_title  := r.chap_title;
         l_match.score       := r.match_score;
         l_match.action      :=
            case
               when r.feat_chap_id is not null and r.feat_chapter_match_score is null then c_action_manual
               when r.match_score >= p_min_auto
                    and r.feat_chap_id = r.chap_id
                    and r.feat_chapter_match_score = r.match_score                    then c_action_keep
               when r.match_score >= p_min_auto                                       then c_action_assign
               when r.feat_chap_id is not null                                        then c_action_clear
               when r.match_score >= p_min_suggest                                    then c_action_suggest
               else c_action_none
            end;
         pipe row (l_match);
      end loop;
      return;
   end preview;

   procedure match_release (
      p_rel_id   in  number,
      p_assigned out pls_integer,
      p_message  out varchar2,
      p_min_auto in  number default c_min_auto)
   is
      l_rec     v_nfo_ui_features%rowtype;
      l_empty   v_nfo_ui_features%rowtype;
      l_md5     varchar2(32767);
      l_cleared pls_integer := 0;
      l_suggest pls_integer := 0;
   begin
      p_assigned := 0;

      for r in (select * from table(preview(p_rel_id, p_min_auto))) loop
         if r.action in (c_action_assign, c_action_clear) then
            l_rec         := l_empty;
            l_rec.feat_id := r.feat_id;
            pkg_nfo_feat_dml.get(l_rec, l_md5);
            if r.action = c_action_assign then
               l_rec.feat_chap_id             := r.chap_id;
               l_rec.feat_chapter_match_score := r.score;
               p_assigned := p_assigned + 1;
            else
               l_rec.feat_chap_id             := null;
               l_rec.feat_chapter_match_score := null;
               l_cleared := l_cleared + 1;
            end if;
            pkg_nfo_feat_dml.mrg(l_rec, l_md5);
         elsif r.action = c_action_suggest then
            l_suggest := l_suggest + 1;
         end if;
      end loop;

      p_message := p_assigned || ' Features zugeordnet, ' || l_cleared || ' Zuordnungen entfernt, ' || l_suggest || ' Vorschläge';
   end match_release;

   procedure match_all is
      l_assigned pls_integer;
      l_message  varchar2(4000);
   begin
      for r in (
         select rel_id, rel_version
           from t_nfo_releases rel
          where exists (select null
                          from t_nfo_release_videos v
                          join t_nfo_video_chapters c on c.chap_vid_id = v.vid_id
                         where v.vid_rel_id = rel.rel_id)
          order by rel_id
      ) loop
         match_release(r.rel_id, l_assigned, l_message);
         dbms_output.put_line(r.rel_version || '  ' || l_message);
      end loop;
   end match_all;

end pkg_nfo_chapter_matcher;
/
