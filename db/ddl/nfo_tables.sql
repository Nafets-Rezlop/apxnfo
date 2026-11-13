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
-- Kommentare: englisch, jede Spalte außer den Auditspalten. FK-Spalten
-- beschreiben die Beziehung. nfo_annotations.sql übernimmt die Texte als
-- Annotation DESCRIPTION für das AI Enrichment, daher nennen sie auch gültige
-- Werte, Platzhalter und Formate.
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

comment on table  t_nfo_releases                      is 'Oracle APEX releases, one row per version, for example 26.1. Parent of features, videos and import runs.';
comment on column t_nfo_releases.rel_id               is 'Surrogate key of the release.';
comment on column t_nfo_releases.rel_version          is 'APEX version number, for example 26.1. Unique. Stored as text, so do not sort it alphabetically when numeric order matters.';
comment on column t_nfo_releases.rel_new_features_url is 'URL of the Oracle documentation page that lists the new features of this release.';
comment on column t_nfo_releases.rel_pdf_url          is 'URL of the Oracle new features PDF of this release. Empty if no PDF is known.';

--------------------------------------------------------------------------------
-- t_nfo_categories
--------------------------------------------------------------------------------
create sequence s_nfo_categories_catg_id;

create table t_nfo_categories (
   catg_id          number                         not null,
   catg_name_de     varchar2(200 char)             not null,
   catg_name_en     varchar2(200 char)             not null,
   catg_sort_order  number,
   catg_icon        varchar2(100 char) default on null 'fa-tag' not null,
   catg_ins_date    date default on null sysdate   not null,
   catg_ins_user    varchar2(128 byte)             not null,
   catg_upd_date    date,
   catg_upd_user    varchar2(128 byte),
   constraint cp_nfo_catg         primary key (catg_id),
   constraint c0_nfo_catg_name_de unique (catg_name_de),
   constraint c0_nfo_catg_name_en unique (catg_name_en)
);

comment on table  t_nfo_categories                 is 'Thematic categories used to classify APEX new features, such as "Security and Authentication". One row per category with German and English names.';
comment on column t_nfo_categories.catg_id         is 'Surrogate key of the category.';
comment on column t_nfo_categories.catg_name_de    is 'Category name in German. Unique.';
comment on column t_nfo_categories.catg_name_en    is 'Category name in English. Unique.';
comment on column t_nfo_categories.catg_sort_order is 'Position of the category in sorted lists. Lower values come first.';
comment on column t_nfo_categories.catg_icon       is 'Font APEX icon class shown for the category, for example fa-database. Defaults to fa-tag.';

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

comment on table  t_nfo_release_videos                 is 'YouTube videos that present the new features of an APEX release. A release can have several videos.';
comment on column t_nfo_release_videos.vid_id          is 'Surrogate key of the video.';
comment on column t_nfo_release_videos.vid_rel_id      is 'Release this video presents.';
comment on column t_nfo_release_videos.vid_title       is 'Title of the video on YouTube.';
comment on column t_nfo_release_videos.vid_youtube_url is 'Full YouTube URL of the video. Unique.';
comment on column t_nfo_release_videos.vid_youtube_key is 'YouTube video ID, always 11 characters. Unique.';
comment on column t_nfo_release_videos.vid_is_main     is 'Main video flag. Y = main video of the release, N = additional video.';
comment on column t_nfo_release_videos.vid_description is 'Video description text from YouTube. The video chapters are extracted from it. Empty until it has been fetched.';
comment on column t_nfo_release_videos.vid_fetched_at  is 'Date and time the description was fetched from YouTube. Empty if it was not fetched yet.';

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

comment on table  t_nfo_video_chapters                    is 'Chapters of a release video, also called timestamps or jump marks. Each chapter is a position in the video where a topic starts.';
comment on column t_nfo_video_chapters.chap_id            is 'Surrogate key of the video chapter.';
comment on column t_nfo_video_chapters.chap_vid_id        is 'Video this chapter belongs to.';
comment on column t_nfo_video_chapters.chap_start_seconds is 'Start position of the chapter in the video, in seconds.';
comment on column t_nfo_video_chapters.chap_title         is 'Chapter title taken from the video description.';
comment on column t_nfo_video_chapters.chap_link_url      is 'Link that opens the video at the chapter start, in the format https://youtu.be/<video ID>?t=<seconds>. Unique.';

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

comment on table  t_nfo_features                              is 'New features of Oracle APEX releases, one row per feature. Each feature belongs to one release and one category and can be assigned to one video chapter.';
comment on column t_nfo_features.feat_id                      is 'Surrogate key of the feature.';
comment on column t_nfo_features.feat_rel_id                  is 'Release that introduced the feature.';
comment on column t_nfo_features.feat_catg_id                 is 'Category of the feature.';
comment on column t_nfo_features.feat_chap_id                 is 'Video chapter that presents the feature. Empty if the feature is not assigned to a chapter.';
comment on column t_nfo_features.feat_chapter_match_score     is 'Quality of the assignment to the video chapter, from 0 (lowest) to 1 (highest). Empty if the feature is not assigned to a chapter.';
comment on column t_nfo_features.feat_title                   is 'Title of the feature, in English as published by Oracle.';
comment on column t_nfo_features.feat_raw_text_en             is 'Original English feature text from the Oracle documentation. Empty if it was not loaded.';
comment on column t_nfo_features.feat_summary_en              is 'Short feature summary in English. Unique. The value ''empty'' is a placeholder that means no summary exists yet, so exclude it from results.';
comment on column t_nfo_features.feat_summary_de              is 'Short feature summary in German. Unique. The value ''empty'' is a placeholder that means no summary exists yet, so exclude it from results.';
comment on column t_nfo_features.feat_link_feature_oracle_doc is 'Link to the feature in the Oracle documentation.';

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

comment on table  t_nfo_import_logs                 is 'Log of import runs that load new features, one row per run.';
comment on column t_nfo_import_logs.imp_id          is 'Surrogate key of the import run.';
comment on column t_nfo_import_logs.imp_rel_id      is 'Release the import run processed. Empty if no release could be determined.';
comment on column t_nfo_import_logs.imp_started_by  is 'APEX user name (APP_USER) of the person who started the import. Not a foreign key.';
comment on column t_nfo_import_logs.imp_import_type is 'Type of import. Valid values: CSV = CSV file upload, AI_EXTRACT = AI extraction, AI_ENRICH = AI enrichment.';
comment on column t_nfo_import_logs.imp_status      is 'Result of the import. Valid values: OK, ERROR. Empty while the import is still running.';
comment on column t_nfo_import_logs.imp_message     is 'Result message of the import run.';
comment on column t_nfo_import_logs.imp_started_at  is 'Date and time the import started.';
comment on column t_nfo_import_logs.imp_finished_at is 'Date and time the import finished. Empty while it is still running.';
