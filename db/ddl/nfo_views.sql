--------------------------------------------------------------------------------
-- Views für UI und LOVs
--
-- Die UI-Views (Anf. 920-960) sind Grundlage der TAPI (Recordtype, Anf. 990).
-- Aufgelöste Namen kommen per skalarer Unterabfrage, damit die View eine
-- Ein-Tabellen-View und damit updatable bleibt (Anf. 940, 960). Der
-- TAPI-Generator schreibt nur Spalten, die es auch in der Tabelle gibt.
--
-- AI Enrichment: View-Spalten lassen sich nur per create view annotieren,
-- daher die Spaltenliste. Die Texte übernehmen den Kommentar der Quellspalte
-- in der Tabelle (nfo_tables.sql), die Annotations der Tabellen setzt
-- nfo_annotations.sql.
--------------------------------------------------------------------------------

whenever sqlerror exit failure

create or replace view v_nfo_ui_categories (
   catg_id         annotations (description 'Kunstschlüssel einer Kategorie'),
   catg_name_de    annotations (description 'Name deutsch, eindeutig (Anf. 170)'),
   catg_name_en    annotations (description 'Name englisch, eindeutig (Anf. 170)'),
   catg_sort_order annotations (description 'Reihenfolge der Kategorie in Listen')
) annotations (description 'Kategorie eines Features (Anf. 100-170), updatable UI-View auf t_nfo_categories (Anf. 950, 960)') as
select catg_id,
       catg_name_de,
       catg_name_en,
       catg_sort_order
  from t_nfo_categories;

create or replace view v_nfo_ui_releases (
   rel_id               annotations (description 'Kunstschlüssel eines Releases'),
   rel_version          annotations (description 'Versionsnummer, z.B. 26.1'),
   rel_new_features_url annotations (description 'URL der New-Features-Seite (Anf. 610)'),
   rel_pdf_url          annotations (description 'URL des New-Features-PDFs (Anf. 650)')
) annotations (description 'APEX-Release, z.B. 26.1, updatable UI-View auf t_nfo_releases (Anf. 970, 980)') as
select rel_id,
       rel_version,
       rel_new_features_url,
       rel_pdf_url
  from t_nfo_releases;

create or replace view v_nfo_ui_release_videos (
   vid_id          annotations (description 'Kunstschlüssel eines Release-Videos'),
   vid_rel_id      annotations (description 'Kunstschlüssel eines Releases'),
   rel_version     annotations (description 'Versionsnummer, z.B. 26.1'),
   vid_title       annotations (description 'Titel des Videos auf YouTube'),
   vid_youtube_url annotations (description 'YouTube-Link des Videos, eindeutig (Anf. 240)'),
   vid_youtube_key annotations (description '11-stellige YouTube-Video-ID'),
   vid_is_main     annotations (description 'Y = Hauptvideo des Releases (Anf. 210)'),
   vid_description annotations (description 'Videobeschreibung, Quelle der Sprungmarken (Anf. 220)'),
   vid_fetched_at  annotations (description 'Zeitpunkt, zu dem die Beschreibung von YouTube geladen wurde')
) annotations (description 'YouTube-Video zu einem Release (Anf. 210), UI-View auf t_nfo_release_videos') as
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
   chap_id            annotations (description 'Kunstschlüssel einer Sprungmarke'),
   chap_vid_id        annotations (description 'Kunstschlüssel eines Release-Videos'),
   vid_youtube_key    annotations (description '11-stellige YouTube-Video-ID'),
   chap_start_seconds annotations (description 'Startposition im Video in Sekunden'),
   chap_title         annotations (description 'Titel der Sprungmarke aus der Videobeschreibung'),
   chap_link_url      annotations (description 'youtu.be/<ID>?t=<Sekunden>, eindeutig (Anf. 240)')
) annotations (description 'Sprungmarke in einem Release-Video (Anf. 220), UI-View auf t_nfo_video_chapters') as
select c.chap_id,
       c.chap_vid_id,
       (select v.vid_youtube_key from t_nfo_release_videos v where v.vid_id = c.chap_vid_id) as vid_youtube_key,
       c.chap_start_seconds,
       c.chap_title,
       c.chap_link_url
  from t_nfo_video_chapters c;

create or replace view v_nfo_ui_import_logs (
   imp_id          annotations (description 'Kunstschlüssel eines Imports'),
   imp_rel_id      annotations (description 'Kunstschlüssel eines Releases'),
   rel_version     annotations (description 'Versionsnummer, z.B. 26.1'),
   imp_started_by  annotations (description 'APEX-Benutzername (APP_USER), kein Fremdschlüssel'),
   imp_import_type annotations (description 'Art des Imports: CSV, AI_EXTRACT, AI_ENRICH'),
   imp_status      annotations (description 'OK, ERROR; leer solange der Import läuft'),
   imp_message     annotations (description 'Ergebnismeldung des Imports (Anf. 430)'),
   imp_started_at  annotations (description 'Beginn des Imports'),
   imp_finished_at annotations (description 'Ende des Imports')
) annotations (description 'Protokoll der Importe (Anf. 430), UI-View auf t_nfo_import_logs') as
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
   feat_id                      annotations (description 'Kunstschlüssel eines Features'),
   feat_rel_id                  annotations (description 'Kunstschlüssel eines Releases'),
   rel_version                  annotations (description 'Versionsnummer, z.B. 26.1'),
   feat_catg_id                 annotations (description 'Kunstschlüssel einer Kategorie'),
   catg_name_de                 annotations (description 'Name deutsch, eindeutig (Anf. 170)'),
   catg_name_en                 annotations (description 'Name englisch, eindeutig (Anf. 170)'),
   feat_chap_id                 annotations (description 'Kunstschlüssel einer Sprungmarke'),
   feat_chapter_match_score     annotations (description '0-1, Qualität der Zuordnung zur Sprungmarke'),
   feat_title                   annotations (description 'Titel des Features (CSV-Spalte Feature)'),
   feat_raw_text_en             annotations (description 'Originaltext von der Oracle-Seite'),
   feat_summary_de              annotations (description 'Zusammenfassung deutsch, eindeutig außer Initialwert ''empty'' (Anf. 450)'),
   feat_summary_en              annotations (description 'Zusammenfassung englisch, eindeutig außer Initialwert ''empty'' (Anf. 450)'),
   feat_link_feature_oracle_doc annotations (description 'Link zur Oracle-Doku (CSV-Spalte link_feature_oracle_doc)'),
   chap_link_url                annotations (description 'youtu.be/<ID>?t=<Sekunden>, eindeutig (Anf. 240)')
) annotations (description 'New Feature eines APEX-Releases, updatable UI-View auf t_nfo_features mit aufgelösten Namen (Anf. 930, 940)') as
select f.feat_id,
       f.feat_rel_id,
       (select r.rel_version  from t_nfo_releases   r where r.rel_id  = f.feat_rel_id)  as rel_version,
       f.feat_catg_id,
       (select c.catg_name_de from t_nfo_categories c where c.catg_id = f.feat_catg_id) as catg_name_de,
       (select c.catg_name_en from t_nfo_categories c where c.catg_id = f.feat_catg_id) as catg_name_en,
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
   return_value     annotations (description 'Kunstschlüssel einer Kategorie'),
   display_value_de annotations (description 'Name deutsch, eindeutig (Anf. 170)'),
   display_value_en annotations (description 'Name englisch, eindeutig (Anf. 170)'),
   sort_order       annotations (description 'Reihenfolge der Kategorie in Listen')
) annotations (description 'LOV der Kategorien, Anzeige je Sprache (Issue #6)') as
select catg_id         as return_value,
       catg_name_de    as display_value_de,
       catg_name_en    as display_value_en,
       catg_sort_order as sort_order
  from t_nfo_categories;
