--------------------------------------------------------------------------------
-- Tabellen und Sequenzen nach er_model_nfo.md und nfo_naming_conventions.md
--
-- Tabellenkürzel:
--   t_nfo_releases       rel
--   t_nfo_categories     catg
--   t_nfo_release_videos vid
--   t_nfo_video_chapters chap
--   t_nfo_features       feat
--   t_nfo_import_logs    imp
--
-- Auditspalten (Anf. 850): Die Domänen dom_nfo_user / dom_nfo_date (Anf. 870,
-- 890) setzen Oracle 23ai voraus. Die Ziel-DB ist 19c, daher werden die
-- Basistypen direkt verwendet: varchar2(128 byte) bzw. date.
--
-- created_at/updated_at aus dem ER-Modell entfallen, das decken die
-- Auditspalten ab.
--
-- Spalten mit Default verwenden "default on null", weil die TAPI im MERGE
-- immer alle Spalten der View schreibt, auch wenn sie leer sind. Das greift
-- nur beim INSERT. Ein UPDATE auf NULL scheitert an NOT NULL (ORA-01407),
-- dadurch kann eine leere Seite keine Werte überschreiben.
--
-- Kommentare: jede Spalte außer den Auditspalten. FK-Spalten übernehmen den
-- Kommentar der Elternspalte.
--------------------------------------------------------------------------------

whenever sqlerror exit failure

--------------------------------------------------------------------------------
-- t_nfo_releases
--------------------------------------------------------------------------------
create sequence s_nfo_releases_rel_id;

create table t_nfo_releases (
   rel_id               number                         not null,
   rel_version          varchar2(20 char)              not null,
   rel_new_features_url varchar2(1000 char),
   rel_pdf_url          varchar2(1000 char),
   rel_ins_date         date default on null sysdate   not null,
   rel_ins_user         varchar2(128 byte)             not null,
   rel_upd_date         date,
   rel_upd_user         varchar2(128 byte),
   constraint cp_nfo_rel         primary key (rel_id),
   constraint c0_nfo_rel_version unique (rel_version)
);

comment on table  t_nfo_releases                      is 'APEX-Release, z.B. 26.1';
comment on column t_nfo_releases.rel_id               is 'Kunstschlüssel eines Releases';
comment on column t_nfo_releases.rel_version          is 'Versionsnummer, z.B. 26.1';
comment on column t_nfo_releases.rel_new_features_url is 'URL der New-Features-Seite (Anf. 610)';
comment on column t_nfo_releases.rel_pdf_url          is 'URL des New-Features-PDFs (Anf. 650)';

--------------------------------------------------------------------------------
-- t_nfo_categories
--------------------------------------------------------------------------------
create sequence s_nfo_categories_catg_id;

create table t_nfo_categories (
   catg_id          number                         not null,
   catg_name_de     varchar2(200 char)             not null,
   catg_name_en     varchar2(200 char)             not null,
   catg_sort_order  number,
   catg_ins_date    date default on null sysdate   not null,
   catg_ins_user    varchar2(128 byte)             not null,
   catg_upd_date    date,
   catg_upd_user    varchar2(128 byte),
   constraint cp_nfo_catg         primary key (catg_id),
   constraint c0_nfo_catg_name_de unique (catg_name_de),
   constraint c0_nfo_catg_name_en unique (catg_name_en)
);

comment on table  t_nfo_categories                 is 'Kategorie eines Features (Anf. 100-170)';
comment on column t_nfo_categories.catg_id         is 'Kunstschlüssel einer Kategorie';
comment on column t_nfo_categories.catg_name_de    is 'Name deutsch, eindeutig (Anf. 170)';
comment on column t_nfo_categories.catg_name_en    is 'Name englisch, eindeutig (Anf. 170)';
comment on column t_nfo_categories.catg_sort_order is 'Reihenfolge der Kategorie in Listen';

--------------------------------------------------------------------------------
-- t_nfo_release_videos
--------------------------------------------------------------------------------
create sequence s_nfo_release_videos_vid_id;

create table t_nfo_release_videos (
   vid_id           number                         not null,
   vid_rel_id       number                         not null,
   vid_title        varchar2(500 char),
   vid_youtube_url  varchar2(500 char)             not null,
   vid_youtube_key  varchar2(11 char)              not null,
   vid_is_main      varchar2(1 char) default on null 'N' not null,
   vid_description  clob,
   vid_fetched_at   date,
   vid_ins_date     date default on null sysdate   not null,
   vid_ins_user     varchar2(128 byte)             not null,
   vid_upd_date     date,
   vid_upd_user     varchar2(128 byte),
   constraint cp_nfo_vid             primary key (vid_id),
   constraint c0_nfo_vid_youtube_url unique (vid_youtube_url),
   constraint c0_nfo_vid_youtube_key unique (vid_youtube_key),
   constraint cc_nfo_vid_is_main     check (vid_is_main in ('Y', 'N')),
   constraint cf_nfo_rel_vid_rel_id  foreign key (vid_rel_id) references t_nfo_releases (rel_id)
);

create index cf_nfo_rel_vid_rel_id on t_nfo_release_videos (vid_rel_id);

comment on table  t_nfo_release_videos                 is 'YouTube-Video zu einem Release (Anf. 210)';
comment on column t_nfo_release_videos.vid_id          is 'Kunstschlüssel eines Release-Videos';
comment on column t_nfo_release_videos.vid_rel_id      is 'Kunstschlüssel eines Releases';
comment on column t_nfo_release_videos.vid_title       is 'Titel des Videos auf YouTube';
comment on column t_nfo_release_videos.vid_youtube_url is 'YouTube-Link des Videos, eindeutig (Anf. 240)';
comment on column t_nfo_release_videos.vid_youtube_key is '11-stellige YouTube-Video-ID';
comment on column t_nfo_release_videos.vid_is_main     is 'Y = Hauptvideo des Releases (Anf. 210)';
comment on column t_nfo_release_videos.vid_description is 'Videobeschreibung, Quelle der Sprungmarken (Anf. 220)';
comment on column t_nfo_release_videos.vid_fetched_at  is 'Zeitpunkt, zu dem die Beschreibung von YouTube geladen wurde';

--------------------------------------------------------------------------------
-- t_nfo_video_chapters
--------------------------------------------------------------------------------
create sequence s_nfo_video_chapters_chap_id;

create table t_nfo_video_chapters (
   chap_id            number                       not null,
   chap_vid_id        number                       not null,
   chap_start_seconds number                       not null,
   chap_title         varchar2(500 char),
   chap_link_url      varchar2(500 char)           not null,
   chap_ins_date      date default on null sysdate not null,
   chap_ins_user      varchar2(128 byte)           not null,
   chap_upd_date      date,
   chap_upd_user      varchar2(128 byte),
   constraint cp_nfo_chap            primary key (chap_id),
   constraint c0_nfo_chap_link_url   unique (chap_link_url),
   constraint cf_nfo_vid_chap_vid_id foreign key (chap_vid_id) references t_nfo_release_videos (vid_id)
);

create index cf_nfo_vid_chap_vid_id on t_nfo_video_chapters (chap_vid_id);

comment on table  t_nfo_video_chapters                    is 'Sprungmarke in einem Release-Video (Anf. 220)';
comment on column t_nfo_video_chapters.chap_id            is 'Kunstschlüssel einer Sprungmarke';
comment on column t_nfo_video_chapters.chap_vid_id        is 'Kunstschlüssel eines Release-Videos';
comment on column t_nfo_video_chapters.chap_start_seconds is 'Startposition im Video in Sekunden';
comment on column t_nfo_video_chapters.chap_title         is 'Titel der Sprungmarke aus der Videobeschreibung';
comment on column t_nfo_video_chapters.chap_link_url      is 'youtu.be/<ID>?t=<Sekunden>, eindeutig (Anf. 240)';

--------------------------------------------------------------------------------
-- t_nfo_features
--------------------------------------------------------------------------------
create sequence s_nfo_features_feat_id;

create table t_nfo_features (
   feat_id                      number                       not null,
   feat_rel_id                  number                       not null,
   feat_catg_id                 number                       not null,
   feat_chap_id                 number,
   feat_chapter_match_score     number,
   feat_title                   varchar2(500 char)           not null,
   feat_raw_text_en             clob,
   feat_summary_en              varchar2(4000 byte) default on null 'empty' not null,
   feat_summary_de              varchar2(4000 byte) default on null 'empty' not null,
   feat_link_feature_oracle_doc varchar2(1000 char),
   feat_ins_date                date default on null sysdate not null,
   feat_ins_user                varchar2(128 byte)           not null,
   feat_upd_date                date,
   feat_upd_user                varchar2(128 byte),
   constraint cp_nfo_feat                     primary key (feat_id),
   constraint cc_nfo_feat_chapter_match_score check (feat_chapter_match_score between 0 and 1),
   constraint cf_nfo_rel_feat_rel_id          foreign key (feat_rel_id)  references t_nfo_releases (rel_id),
   -- kein "on delete": belegte Kategorie kann nicht gelöscht werden (Anf. 140)
   constraint cf_nfo_catg_feat_catg_id        foreign key (feat_catg_id) references t_nfo_categories (catg_id),
   constraint cf_nfo_chap_feat_chap_id        foreign key (feat_chap_id) references t_nfo_video_chapters (chap_id)
);

create index cf_nfo_rel_feat_rel_id   on t_nfo_features (feat_rel_id);
create index cf_nfo_catg_feat_catg_id on t_nfo_features (feat_catg_id);
create index cf_nfo_chap_feat_chap_id on t_nfo_features (feat_chap_id);

-- Zusammenfassungen eindeutig (Anf. 450), ausgenommen der Initialwert 'empty',
-- den mehrere Features gleichzeitig haben dürfen. Ein Unique Constraint kann
-- keine Werte ausnehmen, daher ein funktionsbasierter Unique Index.
create unique index c0_nfo_feat_summary_en on t_nfo_features (case when feat_summary_en != 'empty' then feat_summary_en end);
create unique index c0_nfo_feat_summary_de on t_nfo_features (case when feat_summary_de != 'empty' then feat_summary_de end);

comment on table  t_nfo_features                              is 'New Feature eines APEX-Releases';
comment on column t_nfo_features.feat_id                      is 'Kunstschlüssel eines Features';
comment on column t_nfo_features.feat_rel_id                  is 'Kunstschlüssel eines Releases';
comment on column t_nfo_features.feat_catg_id                 is 'Kunstschlüssel einer Kategorie';
comment on column t_nfo_features.feat_chap_id                 is 'Kunstschlüssel einer Sprungmarke';
comment on column t_nfo_features.feat_chapter_match_score     is '0-1, Qualität der Zuordnung zur Sprungmarke';
comment on column t_nfo_features.feat_title                   is 'Titel des Features (CSV-Spalte Feature)';
comment on column t_nfo_features.feat_raw_text_en             is 'Originaltext von der Oracle-Seite';
comment on column t_nfo_features.feat_summary_en              is 'Zusammenfassung englisch, eindeutig außer Initialwert ''empty'' (Anf. 450)';
comment on column t_nfo_features.feat_summary_de              is 'Zusammenfassung deutsch, eindeutig außer Initialwert ''empty'' (Anf. 450)';
comment on column t_nfo_features.feat_link_feature_oracle_doc is 'Link zur Oracle-Doku (CSV-Spalte link_feature_oracle_doc)';

--------------------------------------------------------------------------------
-- t_nfo_import_logs
--------------------------------------------------------------------------------
create sequence s_nfo_import_logs_imp_id;

create table t_nfo_import_logs (
   imp_id           number                       not null,
   imp_rel_id       number,
   imp_started_by   varchar2(128 byte)           not null,
   imp_import_type  varchar2(20 char)            not null,
   imp_status       varchar2(10 char),
   imp_message      varchar2(4000 char),
   imp_started_at   date default on null sysdate not null,
   imp_finished_at  date,
   imp_ins_date     date default on null sysdate not null,
   imp_ins_user     varchar2(128 byte)           not null,
   imp_upd_date     date,
   imp_upd_user     varchar2(128 byte),
   constraint cp_nfo_imp             primary key (imp_id),
   constraint cc_nfo_imp_import_type check (imp_import_type in ('CSV', 'AI_EXTRACT', 'AI_ENRICH')),
   constraint cc_nfo_imp_status      check (imp_status in ('OK', 'ERROR')),
   constraint cf_nfo_rel_imp_rel_id  foreign key (imp_rel_id) references t_nfo_releases (rel_id)
);

create index cf_nfo_rel_imp_rel_id on t_nfo_import_logs (imp_rel_id);

comment on table  t_nfo_import_logs                 is 'Protokoll der Importe (Anf. 430)';
comment on column t_nfo_import_logs.imp_id          is 'Kunstschlüssel eines Imports';
comment on column t_nfo_import_logs.imp_rel_id      is 'Kunstschlüssel eines Releases';
comment on column t_nfo_import_logs.imp_started_by  is 'APEX-Benutzername (APP_USER), kein Fremdschlüssel';
comment on column t_nfo_import_logs.imp_import_type is 'Art des Imports: CSV, AI_EXTRACT, AI_ENRICH';
comment on column t_nfo_import_logs.imp_status      is 'OK, ERROR; leer solange der Import läuft';
comment on column t_nfo_import_logs.imp_message     is 'Ergebnismeldung des Imports (Anf. 430)';
comment on column t_nfo_import_logs.imp_started_at  is 'Beginn des Imports';
comment on column t_nfo_import_logs.imp_finished_at is 'Ende des Imports';
