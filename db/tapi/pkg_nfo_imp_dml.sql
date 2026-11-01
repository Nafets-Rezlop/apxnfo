create or replace package pkg_nfo_imp_dml is
-- Generiert von pkg_nfo_tapi_gen (Muster: SQL Workshop > Methods on Tables)
--------------------------------------------------------------
-- merge procedure for table t_nfo_import_logs
   procedure mrg (
      p_rec in out v_nfo_ui_import_logs%rowtype,
      p_md5 in out varchar2);
--------------------------------------------------------------
-- delete procedure for table t_nfo_import_logs
   procedure del (
      p_rec in     v_nfo_ui_import_logs%rowtype);
--------------------------------------------------------------
-- get procedure for table t_nfo_import_logs
   procedure get (
      p_rec in out v_nfo_ui_import_logs%rowtype,
      p_md5 out    varchar2);
--------------------------------------------------------------
-- build MD5 function for table t_nfo_import_logs
   function build_md5 (
      p_row in t_nfo_import_logs%rowtype) return varchar2;
--------------------------------------------------------------
end pkg_nfo_imp_dml;
/

create or replace package body pkg_nfo_imp_dml is

--------------------------------------------------------------
-- merge procedure for table t_nfo_import_logs
   procedure mrg (
      p_rec in out v_nfo_ui_import_logs%rowtype,
      p_md5 in out varchar2)
   is
      l_row t_nfo_import_logs%rowtype;
      l_md5 varchar2(32767);
   begin
      if p_rec.imp_id is null then
         -- leerer Primärschlüssel: INSERT (Anf. 1030)
         p_rec.imp_id := s_nfo_import_logs_imp_id.nextval;
      else
         -- vorhandene Zeile sperren und Prüfsumme vergleichen
         begin
            select *
              into l_row
              from t_nfo_import_logs
             where imp_id = p_rec.imp_id
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

      merge into t_nfo_import_logs tgt
      using (select p_rec.imp_id as imp_id from dual) src
         on (tgt.imp_id = src.imp_id)
      when matched then
         update set
            imp_rel_id      = p_rec.imp_rel_id,
            imp_started_by  = p_rec.imp_started_by,
            imp_import_type = p_rec.imp_import_type,
            imp_status      = p_rec.imp_status,
            imp_message     = p_rec.imp_message,
            imp_started_at  = p_rec.imp_started_at,
            imp_finished_at = p_rec.imp_finished_at,
            imp_upd_date    = sysdate,
            imp_upd_user    = coalesce(sys_context('APEX$SESSION', 'APP_USER'), sys_context('USERENV', 'SESSION_USER'))
      when not matched then
         insert (
            imp_id,
            imp_rel_id,
            imp_started_by,
            imp_import_type,
            imp_status,
            imp_message,
            imp_started_at,
            imp_finished_at,
            imp_ins_date,
            imp_ins_user
         ) values (
            src.imp_id,
            p_rec.imp_rel_id,
            p_rec.imp_started_by,
            p_rec.imp_import_type,
            p_rec.imp_status,
            p_rec.imp_message,
            p_rec.imp_started_at,
            p_rec.imp_finished_at,
            sysdate,
            coalesce(sys_context('APEX$SESSION', 'APP_USER'), sys_context('USERENV', 'SESSION_USER'))
         );

      select *
        into l_row
        from t_nfo_import_logs
       where imp_id = p_rec.imp_id;
      p_md5 := build_md5(l_row);
   end mrg;

--------------------------------------------------------------
-- delete procedure for table t_nfo_import_logs
   procedure del (
      p_rec in     v_nfo_ui_import_logs%rowtype)
   is
   begin
      delete from t_nfo_import_logs
       where imp_id = p_rec.imp_id;
   end del;

--------------------------------------------------------------
-- get procedure for table t_nfo_import_logs
   procedure get (
      p_rec in out v_nfo_ui_import_logs%rowtype,
      p_md5 out    varchar2)
   is
      l_id  v_nfo_ui_import_logs.imp_id%type := p_rec.imp_id;
      l_row t_nfo_import_logs%rowtype;
   begin
      select *
        into p_rec
        from v_nfo_ui_import_logs
       where imp_id = l_id;

      select *
        into l_row
        from t_nfo_import_logs
       where imp_id = l_id;
      p_md5 := build_md5(l_row);
   exception
      when no_data_found then
         p_md5 := null;
   end get;

--------------------------------------------------------------
-- build MD5 function for table t_nfo_import_logs
   function build_md5 (
      p_row in t_nfo_import_logs%rowtype) return varchar2
   is
   begin
      return apex_util.get_hash(
         p_values => apex_t_varchar2(
            to_char(p_row.imp_id, 'TM9', 'nls_numeric_characters=.,'),
            to_char(p_row.imp_rel_id, 'TM9', 'nls_numeric_characters=.,'),
            p_row.imp_started_by,
            p_row.imp_import_type,
            p_row.imp_status,
            p_row.imp_message,
            to_char(p_row.imp_started_at, 'yyyymmddhh24miss'),
            to_char(p_row.imp_finished_at, 'yyyymmddhh24miss'),
            to_char(p_row.imp_ins_date, 'yyyymmddhh24miss'),
            p_row.imp_ins_user,
            to_char(p_row.imp_upd_date, 'yyyymmddhh24miss'),
            p_row.imp_upd_user),
         p_salted => true);
   end build_md5;

end pkg_nfo_imp_dml;
/
