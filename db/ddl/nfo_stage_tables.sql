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

comment on table  t_nfo_features_stg                       is 'Staging für den CSV-Import von Features (Anf. 900)';
comment on column t_nfo_features_stg.stg_id                is 'Kunstschlüssel einer Staging-Zeile';
comment on column t_nfo_features_stg.stg_feature           is 'CSV-Spalte Feature: Titel des Features';
comment on column t_nfo_features_stg.stg_release           is 'CSV-Spalte release: Versionsnummer, z.B. 26.1';
comment on column t_nfo_features_stg.stg_summary_de        is 'CSV-Spalte feature_summary_de';
comment on column t_nfo_features_stg.stg_summary_en        is 'CSV-Spalte feature_summary_en';
comment on column t_nfo_features_stg.stg_category          is 'CSV-Spalte category: deutscher Kategoriename';
comment on column t_nfo_features_stg.stg_link_oracle_doc   is 'CSV-Spalte link_feature_oracle_doc';
comment on column t_nfo_features_stg.stg_link_youtube      is 'CSV-Spalte link_feature_youtube';
comment on column t_nfo_features_stg.stg_feat_id           is 'Kunstschlüssel eines Features, gesetzt nach erfolgreicher Übertragung';
comment on column t_nfo_features_stg.stg_message           is 'Fehlermeldung, falls die Zeile nicht übertragen werden konnte';

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

comment on table  t_nfo_load_features                     is 'Temporäre Ladetabelle für SQLcl LOAD der CSV-Datei (Anf. 440)';
comment on column t_nfo_load_features.ldf_feature         is 'CSV-Spalte Feature: Titel des Features';
comment on column t_nfo_load_features.ldf_release         is 'CSV-Spalte release: Versionsnummer, z.B. 26.1';
comment on column t_nfo_load_features.ldf_summary_de      is 'CSV-Spalte feature_summary_de';
comment on column t_nfo_load_features.ldf_summary_en      is 'CSV-Spalte feature_summary_en';
comment on column t_nfo_load_features.ldf_category        is 'CSV-Spalte category: deutscher Kategoriename';
comment on column t_nfo_load_features.ldf_link_oracle_doc is 'CSV-Spalte link_feature_oracle_doc';
comment on column t_nfo_load_features.ldf_link_youtube    is 'CSV-Spalte link_feature_youtube';
