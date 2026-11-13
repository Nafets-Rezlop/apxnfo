--------------------------------------------------------------------------------
-- Views für UI und LOVs
--
-- Die UI-Views (Anf. 920-960) sind Grundlage der TAPI (Recordtype, Anf. 990).
-- Aufgelöste Namen kommen per skalarer Unterabfrage, damit die View eine
-- Ein-Tabellen-View und damit updatable bleibt (Anf. 940, 960). Der
-- TAPI-Generator schreibt nur Spalten, die es auch in der Tabelle gibt.
--
-- AI Enrichment: View-Spalten lassen sich nur per create view annotieren,
-- daher die Spaltenliste. Die Texte sind englisch und aus den Kommentaren der
-- Quellspalten (nfo_tables.sql) übersetzt, die Annotations der Tabellen setzt
-- nfo_annotations.sql. Views haben keine Fremdschlüssel, daher nennt
-- ai_relationship_join die Zielspalte für Joins.
--------------------------------------------------------------------------------

whenever sqlerror exit failure

create or replace view v_nfo_ui_categories (
   catg_id         annotations (description 'Surrogate key of the category.', ai_relationship_primary_key),
   catg_name_de    annotations (description 'Category name in German. Unique.', ai_analytics_dimension),
   catg_name_en    annotations (description 'Category name in English. Unique.', ai_analytics_dimension),
   catg_sort_order annotations (description 'Position of the category in sorted lists. Lower values come first.'),
   catg_icon       annotations (description 'Font APEX icon class shown for the category, for example fa-database. Defaults to fa-tag.')
) annotations (description 'Thematic categories used to classify APEX new features, such as "Security and Authentication". One row per category with German and English names. Updatable view on T_NFO_CATEGORIES.') as
select catg_id,
       catg_name_de,
       catg_name_en,
       catg_sort_order,
       catg_icon
  from t_nfo_categories;

create or replace view v_nfo_ui_releases (
   rel_id               annotations (description 'Surrogate key of the release.', ai_relationship_primary_key),
   rel_version          annotations (description 'APEX version number, for example 26.1. Unique. Stored as text, so do not sort it alphabetically when numeric order matters.', ai_analytics_dimension),
   rel_new_features_url annotations (description 'URL of the Oracle documentation page that lists the new features of this release.'),
   rel_pdf_url          annotations (description 'URL of the Oracle new features PDF of this release. Empty if no PDF is known.')
) annotations (description 'Oracle APEX releases, one row per version, for example 26.1. Updatable view on T_NFO_RELEASES.') as
select rel_id,
       rel_version,
       rel_new_features_url,
       rel_pdf_url
  from t_nfo_releases;

create or replace view v_nfo_ui_release_videos (
   vid_id          annotations (description 'Surrogate key of the video.', ai_relationship_primary_key),
   vid_rel_id      annotations (description 'Release this video presents.', ai_relationship_join 'V_NFO_UI_RELEASES.REL_ID'),
   rel_version     annotations (description 'APEX version number of the release, for example 26.1. Resolved from the release.', ai_analytics_dimension),
   vid_title       annotations (description 'Title of the video on YouTube.'),
   vid_youtube_url annotations (description 'Full YouTube URL of the video. Unique.'),
   vid_youtube_key annotations (description 'YouTube video ID, always 11 characters. Unique.'),
   vid_is_main     annotations (description 'Main video flag. Y = main video of the release, N = additional video.', ai_analytics_dimension),
   vid_description annotations (description 'Video description text from YouTube. The video chapters are extracted from it. Empty until it has been fetched.'),
   vid_fetched_at  annotations (description 'Date and time the description was fetched from YouTube. Empty if it was not fetched yet.')
) annotations (description 'YouTube videos that present the new features of an APEX release. A release can have several videos. View on T_NFO_RELEASE_VIDEOS with the resolved release version.') as
select v.vid_id,
       v.vid_rel_id,
       (select r.rel_version from t_nfo_releases r where r.rel_id = v.vid_rel_id) as rel_version,
       v.vid_title,
       v.vid_youtube_url,
       v.vid_youtube_key,
       v.vid_is_main,
       v.vid_description,
       v.vid_fetched_at
  from t_nfo_release_videos v;

create or replace view v_nfo_ui_video_chapters (
   chap_id            annotations (description 'Surrogate key of the video chapter.', ai_relationship_primary_key),
   chap_vid_id        annotations (description 'Video this chapter belongs to.', ai_relationship_join 'V_NFO_UI_RELEASE_VIDEOS.VID_ID'),
   vid_youtube_key    annotations (description 'YouTube video ID of the video, always 11 characters. Resolved from the video.'),
   chap_start_seconds annotations (description 'Start position of the chapter in the video, in seconds.'),
   chap_title         annotations (description 'Chapter title taken from the video description.'),
   chap_link_url      annotations (description 'Link that opens the video at the chapter start, in the format https://youtu.be/<video ID>?t=<seconds>. Unique.')
) annotations (description 'Chapters of a release video, also called timestamps or jump marks. Each chapter is a position in the video where a topic starts. View on T_NFO_VIDEO_CHAPTERS with the resolved YouTube video ID.') as
select c.chap_id,
       c.chap_vid_id,
       (select v.vid_youtube_key from t_nfo_release_videos v where v.vid_id = c.chap_vid_id) as vid_youtube_key,
       c.chap_start_seconds,
       c.chap_title,
       c.chap_link_url
  from t_nfo_video_chapters c;

create or replace view v_nfo_ui_import_logs (
   imp_id          annotations (description 'Surrogate key of the import run.', ai_relationship_primary_key),
   imp_rel_id      annotations (description 'Release the import run processed. Empty if no release could be determined.', ai_relationship_join 'V_NFO_UI_RELEASES.REL_ID'),
   rel_version     annotations (description 'APEX version number of the release, for example 26.1. Resolved from the release.', ai_analytics_dimension),
   imp_started_by  annotations (description 'APEX user name (APP_USER) of the person who started the import. Not a foreign key.', ai_security_pii),
   imp_import_type annotations (description 'Type of import. Valid values: CSV = CSV file upload, AI_EXTRACT = AI extraction, AI_ENRICH = AI enrichment.', ai_analytics_dimension),
   imp_status      annotations (description 'Result of the import. Valid values: OK, ERROR. Empty while the import is still running.', ai_analytics_dimension),
   imp_message     annotations (description 'Result message of the import run.'),
   imp_started_at  annotations (description 'Date and time the import started.'),
   imp_finished_at annotations (description 'Date and time the import finished. Empty while it is still running.')
) annotations (description 'Log of import runs that load new features, one row per run. View on T_NFO_IMPORT_LOGS with the resolved release version.') as
select i.imp_id,
       i.imp_rel_id,
       (select r.rel_version from t_nfo_releases r where r.rel_id = i.imp_rel_id) as rel_version,
       i.imp_started_by,
       i.imp_import_type,
       i.imp_status,
       i.imp_message,
       i.imp_started_at,
       i.imp_finished_at
  from t_nfo_import_logs i;

create or replace view v_nfo_ui_features (
   feat_id                      annotations (description 'Surrogate key of the feature.', ai_relationship_primary_key),
   feat_rel_id                  annotations (description 'Release that introduced the feature.', ai_relationship_join 'V_NFO_UI_RELEASES.REL_ID'),
   rel_version                  annotations (description 'APEX version number of the release, for example 26.1. Resolved from the release.', ai_analytics_dimension),
   feat_catg_id                 annotations (description 'Category of the feature.', ai_relationship_join 'V_NFO_UI_CATEGORIES.CATG_ID'),
   catg_name_de                 annotations (description 'Category name in German. Resolved from the category.', ai_analytics_dimension),
   catg_name_en                 annotations (description 'Category name in English. Resolved from the category.', ai_analytics_dimension),
   catg_icon                    annotations (description 'Font APEX icon class of the category, for example fa-database. Resolved from the category.'),
   feat_chap_id                 annotations (description 'Video chapter that presents the feature. Empty if the feature is not assigned to a chapter.', ai_relationship_join 'V_NFO_UI_VIDEO_CHAPTERS.CHAP_ID'),
   feat_chapter_match_score     annotations (description 'Quality of the assignment to the video chapter, from 0 (lowest) to 1 (highest). Empty if the feature is not assigned to a chapter.', ai_analytics_agg 'AVG'),
   feat_title                   annotations (description 'Title of the feature, in English as published by Oracle.'),
   feat_raw_text_en             annotations (description 'Original English feature text from the Oracle documentation. Empty if it was not loaded.'),
   feat_summary_de              annotations (description 'Short feature summary in German. Unique. The value ''empty'' is a placeholder that means no summary exists yet, so exclude it from results.'),
   feat_summary_en              annotations (description 'Short feature summary in English. Unique. The value ''empty'' is a placeholder that means no summary exists yet, so exclude it from results.'),
   feat_link_feature_oracle_doc annotations (description 'Link to the feature in the Oracle documentation.'),
   chap_link_url                annotations (description 'Link that opens the video at the chapter presenting the feature, in the format https://youtu.be/<video ID>?t=<seconds>. Empty if the feature is not assigned to a chapter.')
) annotations (description 'New features of Oracle APEX releases, one row per feature, with resolved release version, category names and video link. Main view for questions about features. Updatable view on T_NFO_FEATURES.') as
select f.feat_id,
       f.feat_rel_id,
       (select r.rel_version  from t_nfo_releases   r where r.rel_id  = f.feat_rel_id)  as rel_version,
       f.feat_catg_id,
       (select c.catg_name_de from t_nfo_categories c where c.catg_id = f.feat_catg_id) as catg_name_de,
       (select c.catg_name_en from t_nfo_categories c where c.catg_id = f.feat_catg_id) as catg_name_en,
       (select c.catg_icon    from t_nfo_categories c where c.catg_id = f.feat_catg_id) as catg_icon,
       f.feat_chap_id,
       f.feat_chapter_match_score,
       f.feat_title,
       f.feat_raw_text_en,
       f.feat_summary_de,
       f.feat_summary_en,
       f.feat_link_feature_oracle_doc,
       (select ch.chap_link_url from t_nfo_video_chapters ch where ch.chap_id = f.feat_chap_id) as chap_link_url
  from t_nfo_features f;

-- LOV für Kategorien: Rückgabewert catg_id, Anzeige je Sprache (Issue #6)
create or replace view v_nfo_lov_categories (
   return_value     annotations (description 'Surrogate key of the category, returned by the list of values.', ai_relationship_join 'V_NFO_UI_CATEGORIES.CATG_ID'),
   display_value_de annotations (description 'Category name in German, shown in the German user interface.'),
   display_value_en annotations (description 'Category name in English, shown in the English user interface.'),
   sort_order       annotations (description 'Position of the category in the list. Lower values come first.')
) annotations (description 'List of values for selecting a category in the application, with display names per language. Use V_NFO_UI_CATEGORIES for category queries.') as
select catg_id         as return_value,
       catg_name_de    as display_value_de,
       catg_name_en    as display_value_en,
       catg_sort_order as sort_order
  from t_nfo_categories;
