--------------------------------------------------------------------------------
-- Migration ausführen (Anf. 900), aus dem Ordner db/migration starten:
--
--   powershell -File md_to_csv.ps1            (erzeugt nfo_features_migration.csv)
--   sql ... @run_migration.sql
--
-- Ablauf: CSV -> t_nfo_features_stg -> pkg_nfo_migration -> Produktivtabellen
--------------------------------------------------------------------------------

whenever sqlerror exit failure
set serveroutput on size unlimited
set pagesize 100 linesize 200 feedback on

-- ADB (Service HIGH) arbeitet sonst mit Parallel DML: ORA-12839 bei
-- delete + insert auf dieselbe Tabelle in einer Transaktion
alter session disable parallel dml;

-- CSV in die Ladetabelle (Spaltennamen nach Anf. 440 -> ldf-Spalten)
delete from t_nfo_load_features;

set encoding UTF-8
set loadformat csv
set load mapnames (FEATURE=LDF_FEATURE, RELEASE=LDF_RELEASE, FEATURE_SUMMARY_DE=LDF_SUMMARY_DE, FEATURE_SUMMARY_EN=LDF_SUMMARY_EN, CATEGORY=LDF_CATEGORY, LINK_FEATURE_ORACLE_DOC=LDF_LINK_ORACLE_DOC, LINK_FEATURE_YOUTUBE=LDF_LINK_YOUTUBE)
load t_nfo_load_features nfo_features_migration.csv

-- Staging neu befüllen, stg_id und Auditspalten über Defaults
delete from t_nfo_features_stg;
insert into t_nfo_features_stg (
   stg_feature, stg_release, stg_summary_de, stg_summary_en, stg_category, stg_link_oracle_doc, stg_link_youtube)
select ldf_feature, ldf_release, ldf_summary_de, ldf_summary_en, ldf_category, ldf_link_oracle_doc, ldf_link_youtube
  from t_nfo_load_features;
commit;

select count(*) as staging_rows from t_nfo_features_stg;

-- Übertragen in die Produktivtabellen
exec pkg_nfo_migration.run;
commit;

-- Ergebnis
select (select count(*) from t_nfo_releases)    as releases,
       (select count(*) from t_nfo_categories)  as categories,
       (select count(*) from t_nfo_features)    as features,
       (select count(*) from t_nfo_import_logs) as import_logs,
       (select count(*) from t_nfo_features_stg where stg_message is not null) as errors
  from dual;

select stg_release, stg_feature, stg_message
  from t_nfo_features_stg
 where stg_message is not null
 order by stg_id;
