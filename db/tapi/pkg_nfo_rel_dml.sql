create or replace package pkg_nfo_rel_dml is
-- Generiert von pkg_nfo_tapi_gen (Muster: SQL Workshop > Methods on Tables)
--------------------------------------------------------------
-- merge procedure for table t_nfo_releases
   procedure mrg (
      p_rec in out v_nfo_ui_releases%rowtype,
      p_md5 in out varchar2);
--------------------------------------------------------------
-- delete procedure for table t_nfo_releases
   procedure del (
      p_rec in     v_nfo_ui_releases%rowtype);
--------------------------------------------------------------
-- get procedure for table t_nfo_releases
   procedure get (
      p_rec in out v_nfo_ui_releases%rowtype,
      p_md5 out    varchar2);
--------------------------------------------------------------
-- build MD5 function for table t_nfo_releases
   function build_md5 (
      p_row in t_nfo_releases%rowtype) return varchar2;
--------------------------------------------------------------
end pkg_nfo_rel_dml;
/

create or replace package body pkg_nfo_rel_dml is

--------------------------------------------------------------
-- merge procedure for table t_nfo_releases
   procedure mrg (
      p_rec in out v_nfo_ui_releases%rowtype,
      p_md5 in out varchar2)
   is
      l_row t_nfo_releases%rowtype;
      l_md5 varchar2(32767);
   begin
      if p_rec.rel_id is null then
         -- leerer Primärschlüssel: INSERT (Anf. 1030)
         p_rec.rel_id := s_nfo_releases_rel_id.nextval;
      else
         -- vorhandene Zeile sperren und Prüfsumme vergleichen
         begin
            select *
              into l_row
              from t_nfo_releases
             where rel_id = p_rec.rel_id
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

      merge into t_nfo_releases tgt
      using (select p_rec.rel_id as rel_id from dual) src
         on (tgt.rel_id = src.rel_id)
      when matched then
         update set
            rel_version          = p_rec.rel_version,
            rel_new_features_url = p_rec.rel_new_features_url,
            rel_pdf_url          = p_rec.rel_pdf_url,
            rel_upd_date         = sysdate,
            rel_upd_user         = coalesce(sys_context('APEX$SESSION', 'APP_USER'), sys_context('USERENV', 'SESSION_USER'))
      when not matched then
         insert (
            rel_id,
            rel_version,
            rel_new_features_url,
            rel_pdf_url,
            rel_ins_date,
            rel_ins_user
         ) values (
            src.rel_id,
            p_rec.rel_version,
            p_rec.rel_new_features_url,
            p_rec.rel_pdf_url,
            sysdate,
            coalesce(sys_context('APEX$SESSION', 'APP_USER'), sys_context('USERENV', 'SESSION_USER'))
         );

      select *
        into l_row
        from t_nfo_releases
       where rel_id = p_rec.rel_id;
      p_md5 := build_md5(l_row);
   end mrg;

--------------------------------------------------------------
-- delete procedure for table t_nfo_releases
   procedure del (
      p_rec in     v_nfo_ui_releases%rowtype)
   is
   begin
      delete from t_nfo_releases
       where rel_id = p_rec.rel_id;
   end del;

--------------------------------------------------------------
-- get procedure for table t_nfo_releases
   procedure get (
      p_rec in out v_nfo_ui_releases%rowtype,
      p_md5 out    varchar2)
   is
      l_id  v_nfo_ui_releases.rel_id%type := p_rec.rel_id;
      l_row t_nfo_releases%rowtype;
   begin
      select *
        into p_rec
        from v_nfo_ui_releases
       where rel_id = l_id;

      select *
        into l_row
        from t_nfo_releases
       where rel_id = l_id;
      p_md5 := build_md5(l_row);
   exception
      when no_data_found then
         p_md5 := null;
   end get;

--------------------------------------------------------------
-- build MD5 function for table t_nfo_releases
   function build_md5 (
      p_row in t_nfo_releases%rowtype) return varchar2
   is
   begin
      return apex_util.get_hash(
         p_values => apex_t_varchar2(
            to_char(p_row.rel_id, 'TM9', 'nls_numeric_characters=.,'),
            p_row.rel_version,
            p_row.rel_new_features_url,
            p_row.rel_pdf_url,
            to_char(p_row.rel_ins_date, 'yyyymmddhh24miss'),
            p_row.rel_ins_user,
            to_char(p_row.rel_upd_date, 'yyyymmddhh24miss'),
            p_row.rel_upd_user),
         p_salted => true);
   end build_md5;

end pkg_nfo_rel_dml;
/
