create or replace package pkg_nfo_catg_dml is
-- Generiert von pkg_nfo_tapi_gen (Muster: SQL Workshop > Methods on Tables)
--------------------------------------------------------------
-- merge procedure for table t_nfo_categories
   procedure mrg (
      p_rec in out v_nfo_ui_categories%rowtype,
      p_md5 in out varchar2);
--------------------------------------------------------------
-- delete procedure for table t_nfo_categories
   procedure del (
      p_rec in     v_nfo_ui_categories%rowtype);
--------------------------------------------------------------
-- get procedure for table t_nfo_categories
   procedure get (
      p_rec in out v_nfo_ui_categories%rowtype,
      p_md5 out    varchar2);
--------------------------------------------------------------
-- build MD5 function for table t_nfo_categories
   function build_md5 (
      p_row in t_nfo_categories%rowtype) return varchar2;
--------------------------------------------------------------
end pkg_nfo_catg_dml;
/

create or replace package body pkg_nfo_catg_dml is

--------------------------------------------------------------
-- merge procedure for table t_nfo_categories
   procedure mrg (
      p_rec in out v_nfo_ui_categories%rowtype,
      p_md5 in out varchar2)
   is
      l_row t_nfo_categories%rowtype;
      l_md5 varchar2(32767);
   begin
      if p_rec.catg_id is null then
         -- leerer Primärschlüssel: INSERT (Anf. 1030)
         p_rec.catg_id := s_nfo_categories_catg_id.nextval;
      else
         -- vorhandene Zeile sperren und Prüfsumme vergleichen
         begin
            select *
              into l_row
              from t_nfo_categories
             where catg_id = p_rec.catg_id
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

      merge into t_nfo_categories tgt
      using (select p_rec.catg_id as catg_id from dual) src
         on (tgt.catg_id = src.catg_id)
      when matched then
         update set
            catg_name_de    = p_rec.catg_name_de,
            catg_name_en    = p_rec.catg_name_en,
            catg_sort_order = p_rec.catg_sort_order,
            catg_upd_date   = sysdate,
            catg_upd_user   = coalesce(sys_context('APEX$SESSION', 'APP_USER'), sys_context('USERENV', 'SESSION_USER')),
            catg_icon       = p_rec.catg_icon
      when not matched then
         insert (
            catg_id,
            catg_name_de,
            catg_name_en,
            catg_sort_order,
            catg_ins_date,
            catg_ins_user,
            catg_icon
         ) values (
            src.catg_id,
            p_rec.catg_name_de,
            p_rec.catg_name_en,
            p_rec.catg_sort_order,
            sysdate,
            coalesce(sys_context('APEX$SESSION', 'APP_USER'), sys_context('USERENV', 'SESSION_USER')),
            p_rec.catg_icon
         );

      select *
        into l_row
        from t_nfo_categories
       where catg_id = p_rec.catg_id;
      p_md5 := build_md5(l_row);
   end mrg;

--------------------------------------------------------------
-- delete procedure for table t_nfo_categories
   procedure del (
      p_rec in     v_nfo_ui_categories%rowtype)
   is
   begin
      delete from t_nfo_categories
       where catg_id = p_rec.catg_id;
   end del;

--------------------------------------------------------------
-- get procedure for table t_nfo_categories
   procedure get (
      p_rec in out v_nfo_ui_categories%rowtype,
      p_md5 out    varchar2)
   is
      l_id  v_nfo_ui_categories.catg_id%type := p_rec.catg_id;
      l_row t_nfo_categories%rowtype;
   begin
      select *
        into p_rec
        from v_nfo_ui_categories
       where catg_id = l_id;

      select *
        into l_row
        from t_nfo_categories
       where catg_id = l_id;
      p_md5 := build_md5(l_row);
   exception
      when no_data_found then
         p_md5 := null;
   end get;

--------------------------------------------------------------
-- build MD5 function for table t_nfo_categories
   function build_md5 (
      p_row in t_nfo_categories%rowtype) return varchar2
   is
   begin
      return apex_util.get_hash(
         p_values => apex_t_varchar2(
            to_char(p_row.catg_id, 'TM9', 'nls_numeric_characters=.,'),
            p_row.catg_name_de,
            p_row.catg_name_en,
            to_char(p_row.catg_sort_order, 'TM9', 'nls_numeric_characters=.,'),
            to_char(p_row.catg_ins_date, 'yyyymmddhh24miss'),
            p_row.catg_ins_user,
            to_char(p_row.catg_upd_date, 'yyyymmddhh24miss'),
            p_row.catg_upd_user,
            p_row.catg_icon),
         p_salted => true);
   end build_md5;

end pkg_nfo_catg_dml;
/
