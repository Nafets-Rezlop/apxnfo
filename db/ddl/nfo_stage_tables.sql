--------------------------------------------------------------------------------
-- Staging-Tabelle für den CSV-Import (Anf. 900, 420-440)
--
-- Nimmt die CSV-Datei unverändert auf. pkg_nfo_migration überträgt die Zeilen
-- danach über die DML-Packages in die produktiven Tabellen.
--
-- Tabellenkürzel: stg
--------------------------------------------------------------------------------

whenever sqlerror exit failure

create sequence s_nfo_features_stg_stg_id;

create table t_nfo_features_stg (
   stg_id              number default on null s_nfo_features_stg_stg_id.nextval not null,
   stg_feature         varchar2(500 char),
   stg_release         varchar2(20 char),
   stg_summary_de      varchar2(4000 byte),
   stg_summary_en      varchar2(4000 byte),
   stg_category        varchar2(200 char),
   stg_link_oracle_doc varchar2(1000 char),
   stg_link_youtube    varchar2(500 char),
   stg_feat_id         number,
   stg_message         varchar2(4000 char),
   stg_ins_date        date default on null sysdate not null,
   stg_ins_user        varchar2(128 byte) default on null sys_context('USERENV', 'SESSION_USER') not null,
   stg_upd_date        date,
   stg_upd_user        varchar2(128 byte),
   constraint cp_nfo_stg primary key (stg_id)
);

comment on table  t_nfo_features_stg                       is 'Staging table for the CSV import of features. Holds the CSV rows unchanged before they are transferred to T_NFO_FEATURES. Technical table, use T_NFO_FEATURES for questions about features.';
comment on column t_nfo_features_stg.stg_id                is 'Surrogate key of the staging row.';
comment on column t_nfo_features_stg.stg_feature           is 'CSV column Feature: title of the feature.';
comment on column t_nfo_features_stg.stg_release           is 'CSV column release: APEX version number, for example 26.1.';
comment on column t_nfo_features_stg.stg_summary_de        is 'CSV column feature_summary_de: feature summary in German.';
comment on column t_nfo_features_stg.stg_summary_en        is 'CSV column feature_summary_en: feature summary in English.';
comment on column t_nfo_features_stg.stg_category          is 'CSV column category: category name in German.';
comment on column t_nfo_features_stg.stg_link_oracle_doc   is 'CSV column link_feature_oracle_doc: link to the feature in the Oracle documentation.';
comment on column t_nfo_features_stg.stg_link_youtube      is 'CSV column link_feature_youtube: link to the feature in a YouTube video.';
comment on column t_nfo_features_stg.stg_feat_id           is 'Feature created from this row. Set after a successful transfer, empty otherwise.';
comment on column t_nfo_features_stg.stg_message           is 'Error message if the row could not be transferred. Empty otherwise.';

--------------------------------------------------------------------------------
-- Ladetabelle für SQLcl LOAD
--
-- LOAD verlangt, dass alle Spalten außerhalb der CSV nullable sind, Defaults
-- ignoriert es. Daher landet die CSV zuerst in dieser temporären Tabelle und
-- wird per insert ... select in t_nfo_features_stg kopiert, wo die Defaults
-- greifen. Bewusste Ausnahme von Anf. 822/850 (kein PK, keine Auditspalten),
-- weil die Daten nur in der Sitzung existieren.
--
-- Tabellenkürzel: ldf
--------------------------------------------------------------------------------
create global temporary table t_nfo_load_features (
   ldf_feature         varchar2(500 char),
   ldf_release         varchar2(20 char),
   ldf_summary_de      varchar2(4000 byte),
   ldf_summary_en      varchar2(4000 byte),
   ldf_category        varchar2(200 char),
   ldf_link_oracle_doc varchar2(1000 char),
   ldf_link_youtube    varchar2(500 char)
) on commit preserve rows;

comment on table  t_nfo_load_features                     is 'Temporary load table for the CSV file, filled with SQLcl LOAD. Rows exist only within the database session. Technical table, use T_NFO_FEATURES for questions about features.';
comment on column t_nfo_load_features.ldf_feature         is 'CSV column Feature: title of the feature.';
comment on column t_nfo_load_features.ldf_release         is 'CSV column release: APEX version number, for example 26.1.';
comment on column t_nfo_load_features.ldf_summary_de      is 'CSV column feature_summary_de: feature summary in German.';
comment on column t_nfo_load_features.ldf_summary_en      is 'CSV column feature_summary_en: feature summary in English.';
comment on column t_nfo_load_features.ldf_category        is 'CSV column category: category name in German.';
comment on column t_nfo_load_features.ldf_link_oracle_doc is 'CSV column link_feature_oracle_doc: link to the feature in the Oracle documentation.';
comment on column t_nfo_load_features.ldf_link_youtube    is 'CSV column link_feature_youtube: link to the feature in a YouTube video.';
