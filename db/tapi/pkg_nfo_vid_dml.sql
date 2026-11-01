create or replace package pkg_nfo_vid_dml is
-- Generiert von pkg_nfo_tapi_gen (Muster: SQL Workshop > Methods on Tables)
--------------------------------------------------------------
-- merge procedure for table t_nfo_release_videos
   procedure mrg (
      p_rec in out v_nfo_ui_release_videos%rowtype,
      p_md5 in out varchar2);
--------------------------------------------------------------
-- delete procedure for table t_nfo_release_videos
   procedure del (
      p_rec in     v_nfo_ui_release_videos%rowtype);
--------------------------------------------------------------
-- get procedure for table t_nfo_release_videos
   procedure get (
      p_rec in out v_nfo_ui_release_videos%rowtype,
      p_md5 out    varchar2);
--------------------------------------------------------------
-- build MD5 function for table t_nfo_release_videos
   function build_md5 (
      p_row in t_nfo_release_videos%rowtype) return varchar2;
--------------------------------------------------------------
end pkg_nfo_vid_dml;
/

create or replace package body pkg_nfo_vid_dml is

--------------------------------------------------------------
-- merge procedure for table t_nfo_release_videos
   procedure mrg (
      p_rec in out v_nfo_ui_release_videos%rowtype,
      p_md5 in out varchar2)
   is
      l_row t_nfo_release_videos%rowtype;
      l_md5 varchar2(32767);
   begin
      if p_rec.vid_id is null then
         -- leerer Primärschlüssel: INSERT (Anf. 1030)
         p_rec.vid_id := s_nfo_release_videos_vid_id.nextval;
      else
         -- vorhandene Zeile sperren und Prüfsumme vergleichen
         begin
            select *
              into l_row
              from t_nfo_release_videos
             where vid_id = p_rec.vid_id
               for update;

            l_md5 := build_md5(l_row);
            if p_md5 is not null and l_md5 != p_md5 then
               raise_application_error(-20001, 'Current version of data in database has changed since user initiated update process. current checksum = "'
                  || l_md5 || '", item checksum = "' || p_md5 || '".');
            end if;
         exception
            when no_data_found then
               null; -- Zeile gibt es noch nicht: MERGE fügt sie ein
         end;
      end if;

      merge into t_nfo_release_videos tgt
      using (select p_rec.vid_id as vid_id from dual) src
         on (tgt.vid_id = src.vid_id)
      when matched then
         update set
            vid_rel_id      = p_rec.vid_rel_id,
            vid_youtube_url = p_rec.vid_youtube_url,
            vid_youtube_key = p_rec.vid_youtube_key,
            vid_is_main     = p_rec.vid_is_main,
            vid_description = p_rec.vid_description,
            vid_fetched_at  = p_rec.vid_fetched_at,
            vid_upd_date    = sysdate,
            vid_upd_user    = coalesce(sys_context('APEX$SESSION', 'APP_USER'), sys_context('USERENV', 'SESSION_USER')),
            vid_title       = p_rec.vid_title
      when not matched then
         insert (
            vid_id,
            vid_rel_id,
            vid_youtube_url,
            vid_youtube_key,
            vid_is_main,
            vid_description,
            vid_fetched_at,
            vid_ins_date,
            vid_ins_user,
            vid_title
         ) values (
            src.vid_id,
            p_rec.vid_rel_id,
            p_rec.vid_youtube_url,
            p_rec.vid_youtube_key,
            p_rec.vid_is_main,
            p_rec.vid_description,
            p_rec.vid_fetched_at,
            sysdate,
            coalesce(sys_context('APEX$SESSION', 'APP_USER'), sys_context('USERENV', 'SESSION_USER')),
            p_rec.vid_title
         );

      select *
        into l_row
        from t_nfo_release_videos
       where vid_id = p_rec.vid_id;
      p_md5 := build_md5(l_row);
   end mrg;

--------------------------------------------------------------
-- delete procedure for table t_nfo_release_videos
   procedure del (
      p_rec in     v_nfo_ui_release_videos%rowtype)
   is
   begin
      delete from t_nfo_release_videos
       where vid_id = p_rec.vid_id;
   end del;

--------------------------------------------------------------
-- get procedure for table t_nfo_release_videos
   procedure get (
      p_rec in out v_nfo_ui_release_videos%rowtype,
      p_md5 out    varchar2)
   is
      l_id  v_nfo_ui_release_videos.vid_id%type := p_rec.vid_id;
      l_row t_nfo_release_videos%rowtype;
   begin
      select *
        into p_rec
        from v_nfo_ui_release_videos
       where vid_id = l_id;

      select *
        into l_row
        from t_nfo_release_videos
       where vid_id = l_id;
      p_md5 := build_md5(l_row);
   exception
      when no_data_found then
         p_md5 := null;
   end get;

--------------------------------------------------------------
-- build MD5 function for table t_nfo_release_videos
   function build_md5 (
      p_row in t_nfo_release_videos%rowtype) return varchar2
   is
   begin
      return apex_util.get_hash(
         p_values => apex_t_varchar2(
            to_char(p_row.vid_id, 'TM9', 'nls_numeric_characters=.,'),
            to_char(p_row.vid_rel_id, 'TM9', 'nls_numeric_characters=.,'),
            p_row.vid_youtube_url,
            p_row.vid_youtube_key,
            p_row.vid_is_main,
            dbms_lob.getlength(p_row.vid_description) || ':' || dbms_lob.substr(p_row.vid_description, 8000, 1),
            to_char(p_row.vid_fetched_at, 'yyyymmddhh24miss'),
            to_char(p_row.vid_ins_date, 'yyyymmddhh24miss'),
            p_row.vid_ins_user,
            to_char(p_row.vid_upd_date, 'yyyymmddhh24miss'),
            p_row.vid_upd_user,
            p_row.vid_title),
         p_salted => true);
   end build_md5;

end pkg_nfo_vid_dml;
/
