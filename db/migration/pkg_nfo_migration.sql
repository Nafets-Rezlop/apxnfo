--------------------------------------------------------------------------------
-- pkg_nfo_migration
--
-- Migration (Anf. 900): überträgt die Features aus t_nfo_features_stg in die
-- produktiven Tabellen. Alle Schreibzugriffe laufen über die DML-Packages.
--
-- Reihenfolge (Fremdschlüssel):
--   1. t_nfo_categories   Kategorien aus apex-new-features.md (Anf. 110)
--   2. t_nfo_releases     je Release in der Staging-Tabelle
--   3. t_nfo_import_logs  ein Eintrag je Release (Anf. 430)
--   4. t_nfo_features     verweist auf Release und Kategorie
--
-- Wiederholbar: vorhandene Releases (Version), Kategorien (Name deutsch) und
-- Features (Release + Titel) werden aktualisiert statt doppelt angelegt.
-- Fehler je Zeile stehen in t_nfo_features_stg.stg_message, das Release
-- bekommt dann im Import-Log den Status ERROR.
--
-- Aufruf:
--   exec pkg_nfo_migration.run;
--------------------------------------------------------------------------------

create or replace package pkg_nfo_migration is

   procedure run;

end pkg_nfo_migration;
/

create or replace package body pkg_nfo_migration is

   ---------------------------------------------------------------------------
   -- 1. Kategorien
   ---------------------------------------------------------------------------

   procedure mrg_category (p_name_de in varchar2, p_name_en in varchar2, p_sort_order in number) is
      l_rec v_nfo_ui_categories%rowtype;
      l_md5 varchar2(32767);
   begin
      begin
         select catg_id into l_rec.catg_id from t_nfo_categories where catg_name_de = p_name_de;
      exception
         when no_data_found then
            null;
      end;
      l_rec.catg_name_de    := p_name_de;
      l_rec.catg_name_en    := p_name_en;
      l_rec.catg_sort_order := p_sort_order;
      pkg_nfo_catg_dml.mrg(l_rec, l_md5);
   end mrg_category;

   procedure migrate_categories is
   begin
      mrg_category('Administration und Betrieb',           'Administration and Operations',      10);
      mrg_category('APIs und JavaScript-Bibliotheken',     'APIs and JavaScript Libraries',      20);
      mrg_category('Charts, Maps und Kalender',            'Charts, Maps and Calendars',         30);
      mrg_category('Entwicklung und Lifecycle',            'Development and Lifecycle',          40);
      mrg_category('Items, Formulare und Dynamic Actions', 'Items, Forms and Dynamic Actions',   50);
      mrg_category('KI und Generative AI',                 'AI and Generative AI',               60);
      mrg_category('Reports, Grids und Suche',             'Reports, Grids and Search',          70);
      mrg_category('REST, Datenquellen und Daten-Import',  'REST, Data Sources and Data Loading', 80);
      mrg_category('Security und Authentifizierung',       'Security and Authentication',        90);
      mrg_category('Universal Theme, UI und PWA',          'Universal Theme, UI and PWA',       100);
      mrg_category('Workflow, Tasks und Automations',      'Workflow, Tasks and Automations',   110);
   end migrate_categories;

   ---------------------------------------------------------------------------
   -- 2. Release
   ---------------------------------------------------------------------------

   function mrg_release (p_version in varchar2) return number is
      l_rec v_nfo_ui_releases%rowtype;
      l_md5 varchar2(32767);
   begin
      begin
         select rel_id into l_rec.rel_id from t_nfo_releases where rel_version = p_version;
         pkg_nfo_rel_dml.get(l_rec, l_md5);
      exception
         when no_data_found then
            null;
      end;
      l_rec.rel_version := p_version;
      -- New-Features-Seite = Doku-Link eines Features ohne Sprungmarke
      select min(regexp_replace(stg_link_oracle_doc, '#.*$'))
        into l_rec.rel_new_features_url
        from t_nfo_features_stg
       where stg_release = p_version;
      pkg_nfo_rel_dml.mrg(l_rec, l_md5);
      return l_rec.rel_id;
   end mrg_release;

   ---------------------------------------------------------------------------
   -- 3. Import-Log
   ---------------------------------------------------------------------------

   function start_log (p_rel_id in number) return v_nfo_ui_import_logs%rowtype is
      l_rec v_nfo_ui_import_logs%rowtype;
      l_md5 varchar2(32767);
   begin
      l_rec.imp_rel_id      := p_rel_id;
      l_rec.imp_started_by  := coalesce(sys_context('APEX$SESSION', 'APP_USER'), user);
      l_rec.imp_import_type := 'CSV';
      l_rec.imp_started_at  := sysdate;
      pkg_nfo_imp_dml.mrg(l_rec, l_md5);
      return l_rec;
   end start_log;

   procedure finish_log (p_rec in out v_nfo_ui_import_logs%rowtype, p_version in varchar2,
                         p_ok in pls_integer, p_errors in pls_integer) is
      l_md5 varchar2(32767);
   begin
      p_rec.imp_finished_at := sysdate;
      if p_errors = 0 then
         p_rec.imp_status  := 'OK';
         p_rec.imp_message := 'CSV Datei für release ' || p_version || ' erfolgreich importiert ('
                           || p_ok || ' Features)';
      else
         p_rec.imp_status  := 'ERROR';
         p_rec.imp_message := 'CSV Datei für release ' || p_version || ': ' || p_ok || ' Features importiert, '
                           || p_errors || ' fehlerhaft (siehe t_nfo_features_stg.stg_message)';
      end if;
      pkg_nfo_imp_dml.mrg(p_rec, l_md5);
   end finish_log;

   ---------------------------------------------------------------------------
   -- 4. Features
   ---------------------------------------------------------------------------

   procedure migrate_release (p_version in varchar2) is
      l_rel_id number;
      l_log    v_nfo_ui_import_logs%rowtype;
      l_rec    v_nfo_ui_features%rowtype;
      l_empty  v_nfo_ui_features%rowtype;
      l_md5    varchar2(32767);
      l_ok    pls_integer := 0;
      l_errors pls_integer := 0;
      l_msg    varchar2(4000);
   begin
      l_rel_id := mrg_release(p_version);
      l_log    := start_log(l_rel_id);

      for r in (
         select s.*,
                (select c.catg_id from t_nfo_categories c where c.catg_name_de = s.stg_category) as catg_id,
                (select f.feat_id from t_nfo_features f
                  where f.feat_rel_id = l_rel_id and f.feat_title = s.stg_feature) as feat_id
           from t_nfo_features_stg s
          where s.stg_release = p_version
          order by s.stg_id
      ) loop
         savepoint before_feature;
         begin
            if r.catg_id is null then
               raise_application_error(-20100, 'Kategorie "' || r.stg_category || '" ist unbekannt.');
            end if;

            l_rec := l_empty;
            l_md5 := null;
            if r.feat_id is not null then
               l_rec.feat_id := r.feat_id;
               pkg_nfo_feat_dml.get(l_rec, l_md5);
            end if;
            l_rec.feat_rel_id                  := l_rel_id;
            l_rec.feat_catg_id                 := r.catg_id;
            l_rec.feat_title                   := r.stg_feature;
            -- leere Zusammenfassung behält den gespeicherten Wert bzw. bekommt den Initialwert
            l_rec.feat_summary_de              := coalesce(r.stg_summary_de, l_rec.feat_summary_de);
            l_rec.feat_summary_en              := coalesce(r.stg_summary_en, l_rec.feat_summary_en);
            l_rec.feat_link_feature_oracle_doc := r.stg_link_oracle_doc;
            pkg_nfo_feat_dml.mrg(l_rec, l_md5);

            update t_nfo_features_stg
               set stg_feat_id  = l_rec.feat_id,
                   stg_message  = null,
                   stg_upd_date = sysdate,
                   stg_upd_user = user
             where stg_id = r.stg_id;
            l_ok := l_ok + 1;
         exception
            when others then
               l_msg := sqlerrm;
               rollback to before_feature;
               update t_nfo_features_stg
                  set stg_feat_id  = null,
                      stg_message  = l_msg,
                      stg_upd_date = sysdate,
                      stg_upd_user = user
                where stg_id = r.stg_id;
               l_errors := l_errors + 1;
         end;
      end loop;

      finish_log(l_log, p_version, l_ok, l_errors);
      dbms_output.put_line(rpad(p_version, 6) || l_log.imp_status || '  ' || l_log.imp_message);
   end migrate_release;

   ---------------------------------------------------------------------------

   procedure run is
   begin
      migrate_categories;
      for r in (
         select stg_release
           from t_nfo_features_stg
          group by stg_release
          order by to_number(regexp_substr(stg_release, '^\d+')), to_number(regexp_substr(stg_release, '\d+$'))
      ) loop
         migrate_release(r.stg_release);
      end loop;
   end run;

end pkg_nfo_migration;
/
