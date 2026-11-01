create or replace package pkg_nfo_chap_dml is
-- Generiert von pkg_nfo_tapi_gen (Muster: SQL Workshop > Methods on Tables)
--------------------------------------------------------------
-- merge procedure for table t_nfo_video_chapters
   procedure mrg (
      p_rec in out v_nfo_ui_video_chapters%rowtype,
      p_md5 in out varchar2);
--------------------------------------------------------------
-- delete procedure for table t_nfo_video_chapters
   procedure del (
      p_rec in     v_nfo_ui_video_chapters%rowtype);
--------------------------------------------------------------
-- get procedure for table t_nfo_video_chapters
   procedure get (
      p_rec in out v_nfo_ui_video_chapters%rowtype,
      p_md5 out    varchar2);
--------------------------------------------------------------
-- build MD5 function for table t_nfo_video_chapters
   function build_md5 (
      p_row in t_nfo_video_chapters%rowtype) return varchar2;
--------------------------------------------------------------
end pkg_nfo_chap_dml;
/

create or replace package body pkg_nfo_chap_dml is

--------------------------------------------------------------
-- merge procedure for table t_nfo_video_chapters
   procedure mrg (
      p_rec in out v_nfo_ui_video_chapters%rowtype,
      p_md5 in out varchar2)
   is
      l_row t_nfo_video_chapters%rowtype;
      l_md5 varchar2(32767);
   begin
      if p_rec.chap_id is null then
         -- leerer Primärschlüssel: INSERT (Anf. 1030)
         p_rec.chap_id := s_nfo_video_chapters_chap_id.nextval;
      else
         -- vorhandene Zeile sperren und Prüfsumme vergleichen
         begin
            select *
              into l_row
              from t_nfo_video_chapters
             where chap_id = p_rec.chap_id
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

      merge into t_nfo_video_chapters tgt
      using (select p_rec.chap_id as chap_id from dual) src
         on (tgt.chap_id = src.chap_id)
      when matched then
         update set
            chap_vid_id        = p_rec.chap_vid_id,
            chap_start_seconds = p_rec.chap_start_seconds,
            chap_title         = p_rec.chap_title,
            chap_link_url      = p_rec.chap_link_url,
            chap_upd_date      = sysdate,
            chap_upd_user      = coalesce(sys_context('APEX$SESSION', 'APP_USER'), sys_context('USERENV', 'SESSION_USER'))
      when not matched then
         insert (
            chap_id,
            chap_vid_id,
            chap_start_seconds,
            chap_title,
            chap_link_url,
            chap_ins_date,
            chap_ins_user
         ) values (
            src.chap_id,
            p_rec.chap_vid_id,
            p_rec.chap_start_seconds,
            p_rec.chap_title,
            p_rec.chap_link_url,
            sysdate,
            coalesce(sys_context('APEX$SESSION', 'APP_USER'), sys_context('USERENV', 'SESSION_USER'))
         );

      select *
        into l_row
        from t_nfo_video_chapters
       where chap_id = p_rec.chap_id;
      p_md5 := build_md5(l_row);
   end mrg;

--------------------------------------------------------------
-- delete procedure for table t_nfo_video_chapters
   procedure del (
      p_rec in     v_nfo_ui_video_chapters%rowtype)
   is
   begin
      delete from t_nfo_video_chapters
       where chap_id = p_rec.chap_id;
   end del;

--------------------------------------------------------------
-- get procedure for table t_nfo_video_chapters
   procedure get (
      p_rec in out v_nfo_ui_video_chapters%rowtype,
      p_md5 out    varchar2)
   is
      l_id  v_nfo_ui_video_chapters.chap_id%type := p_rec.chap_id;
      l_row t_nfo_video_chapters%rowtype;
   begin
      select *
        into p_rec
        from v_nfo_ui_video_chapters
       where chap_id = l_id;

      select *
        into l_row
        from t_nfo_video_chapters
       where chap_id = l_id;
      p_md5 := build_md5(l_row);
   exception
      when no_data_found then
         p_md5 := null;
   end get;

--------------------------------------------------------------
-- build MD5 function for table t_nfo_video_chapters
   function build_md5 (
      p_row in t_nfo_video_chapters%rowtype) return varchar2
   is
   begin
      return apex_util.get_hash(
         p_values => apex_t_varchar2(
            to_char(p_row.chap_id, 'TM9', 'nls_numeric_characters=.,'),
            to_char(p_row.chap_vid_id, 'TM9', 'nls_numeric_characters=.,'),
            to_char(p_row.chap_start_seconds, 'TM9', 'nls_numeric_characters=.,'),
            p_row.chap_title,
            p_row.chap_link_url,
            to_char(p_row.chap_ins_date, 'yyyymmddhh24miss'),
            p_row.chap_ins_user,
            to_char(p_row.chap_upd_date, 'yyyymmddhh24miss'),
            p_row.chap_upd_user),
         p_salted => true);
   end build_md5;

end pkg_nfo_chap_dml;
/
