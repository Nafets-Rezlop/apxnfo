--------------------------------------------------------------------------------
-- Upgrade: Icon je Kategorie (t_nfo_categories.catg_icon)
--
-- Für eine bereits installierte Datenbank. Eine Neuinstallation bringt die
-- Spalte über ddl/nfo_tables.sql und die Werte über pkg_nfo_migration mit.
--
-- Aufruf als NFO_SYS aus dem Ordner db:
--   sql -name "Autonomous (Spielwiese) (NFO_SYS)" @upgrade/upgrade_catg_icon.sql
--------------------------------------------------------------------------------

set serveroutput on size unlimited
set define off
whenever sqlerror exit failure

alter session disable parallel dml;

-- 1. Spalte und Kommentar (wie in ddl/nfo_tables.sql)
alter table t_nfo_categories add (
   catg_icon varchar2(100 char) default on null 'fa-tag' not null
);

comment on column t_nfo_categories.catg_icon is 'Font APEX icon class shown for the category, for example fa-database. Defaults to fa-tag.';

-- 2. Views neu anlegen (v_nfo_ui_categories, v_nfo_ui_features)
@ddl/nfo_views.sql

-- 3. Annotations aus den Kommentaren nachziehen
@ddl/nfo_annotations.sql

-- 4. DML-Package der Kategorien neu erzeugen und als Skript ablegen
whenever sqlerror exit failure
exec pkg_nfo_tapi_gen.compile_api('T_NFO_CATEGORIES');

set long 1000000 longchunksize 32767 pagesize 0 linesize 32767 trimspool on feedback off heading off termout off
spool tapi/pkg_nfo_catg_dml.sql
select pkg_nfo_tapi_gen.get_script('T_NFO_CATEGORIES') from dual;
spool off
set pagesize 100 linesize 200 feedback on heading on termout on

-- 5. Migration mit dem neuen Parameter p_icon übersetzen
@migration/pkg_nfo_migration.sql
show errors package body pkg_nfo_migration

-- 6. Icons der vorhandenen Kategorien setzen (DML über das Package, Anf. 900)
declare
   procedure set_icon (p_name_en in varchar2, p_icon in varchar2) is
      l_rec v_nfo_ui_categories%rowtype;
      l_md5 varchar2(32767);
   begin
      select catg_id into l_rec.catg_id from t_nfo_categories where catg_name_en = p_name_en;
      pkg_nfo_catg_dml.get(l_rec, l_md5);
      l_rec.catg_icon := p_icon;
      pkg_nfo_catg_dml.mrg(l_rec, l_md5);
   exception
      when no_data_found then
         dbms_output.put_line('Kategorie fehlt: ' || p_name_en);
   end set_icon;
begin
   set_icon('Administration and Operations',       'fa-server');
   set_icon('APIs and JavaScript Libraries',       'fa-code');
   set_icon('Charts, Maps and Calendars',          'fa-bar-chart');
   set_icon('Development and Lifecycle',           'fa-code-fork');
   set_icon('Items, Forms and Dynamic Actions',    'fa-forms');
   set_icon('AI and Generative AI',                'fa-sparkles');
   set_icon('Reports, Grids and Search',           'fa-table');
   set_icon('REST, Data Sources and Data Loading', 'fa-database');
   set_icon('Security and Authentication',         'fa-shield');
   set_icon('Universal Theme, UI and PWA',         'fa-paint-brush');
   set_icon('Workflow, Tasks and Automations',     'fa-workflow');
   commit;
end;
/

select catg_name_en, catg_icon from v_nfo_ui_categories order by catg_sort_order;

select object_name, object_type, status from user_objects where status != 'VALID';

exec pkg_nfo_tapi_test.run;
