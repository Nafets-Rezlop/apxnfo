--------------------------------------------------------------------------------
-- Installation im Schema NFO_SYS (aus dem Ordner db ausführen)
--
--   sql -name "Cloud Autonomous (NFO_SYS)" @install_nfo_sys.sql
--
-- Die Migration der Daten läuft danach separat: migration/run_migration.sql
--------------------------------------------------------------------------------

set serveroutput on size unlimited
set define off

-- ADB (Service HIGH) arbeitet sonst mit Parallel DML: ORA-12839 und ORA-12860
-- bei mehreren Schreibvorgängen in einer Transaktion
alter session disable parallel dml;

@ddl/nfo_tables.sql
@ddl/nfo_stage_tables.sql
@ddl/nfo_views.sql
@ddl/nfo_annotations.sql

whenever sqlerror exit failure
@pkg_nfo_tapi_gen.sql
show errors package body pkg_nfo_tapi_gen

-- DML-Packages erzeugen
exec pkg_nfo_tapi_gen.compile_api('T_NFO_RELEASES');
exec pkg_nfo_tapi_gen.compile_api('T_NFO_CATEGORIES');
exec pkg_nfo_tapi_gen.compile_api('T_NFO_FEATURES');
exec pkg_nfo_tapi_gen.compile_api('T_NFO_IMPORT_LOGS');
exec pkg_nfo_tapi_gen.compile_api('T_NFO_RELEASE_VIDEOS');
exec pkg_nfo_tapi_gen.compile_api('T_NFO_VIDEO_CHAPTERS');

-- generierten Code zusätzlich als Skript ablegen
set long 1000000 longchunksize 32767 pagesize 0 linesize 32767 trimspool on feedback off heading off termout off
spool tapi/pkg_nfo_rel_dml.sql
select pkg_nfo_tapi_gen.get_script('T_NFO_RELEASES') from dual;
spool tapi/pkg_nfo_catg_dml.sql
select pkg_nfo_tapi_gen.get_script('T_NFO_CATEGORIES') from dual;
spool tapi/pkg_nfo_feat_dml.sql
select pkg_nfo_tapi_gen.get_script('T_NFO_FEATURES') from dual;
spool tapi/pkg_nfo_imp_dml.sql
select pkg_nfo_tapi_gen.get_script('T_NFO_IMPORT_LOGS') from dual;
spool tapi/pkg_nfo_vid_dml.sql
select pkg_nfo_tapi_gen.get_script('T_NFO_RELEASE_VIDEOS') from dual;
spool tapi/pkg_nfo_chap_dml.sql
select pkg_nfo_tapi_gen.get_script('T_NFO_VIDEO_CHAPTERS') from dual;
spool off
set pagesize 100 linesize 200 feedback on heading on termout on

@pkg_nfo_chapter_extractor.sql
show errors package body pkg_nfo_chapter_extractor

@pkg_nfo_chapter_matcher.sql
show errors package body pkg_nfo_chapter_matcher

@migration/pkg_nfo_migration.sql
show errors package body pkg_nfo_migration

@test/pkg_nfo_tapi_test.sql
show errors package body pkg_nfo_tapi_test
@test/pkg_nfo_chapter_extractor_test.sql
show errors package body pkg_nfo_chapter_extractor_test
@test/pkg_nfo_chapter_matcher_test.sql
show errors package body pkg_nfo_chapter_matcher_test

select object_name, object_type, status from user_objects where status != 'VALID';

exec pkg_nfo_tapi_test.run;
exec pkg_nfo_chapter_extractor_test.run;
exec pkg_nfo_chapter_matcher_test.run;

-- Rechte für das Verbindungsschema (Anf. 1110-1140). Voraussetzung:
-- admin/create_schema_nfo_sys_conn.sql. Danach als NFO_SYS_CONN
-- synonyms_nfo_sys_conn.sql ausführen (Anf. 1150, 1160).
@grants_nfo_sys_conn.sql
