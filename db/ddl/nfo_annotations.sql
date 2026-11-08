--------------------------------------------------------------------------------
-- AI Enrichment: englische Metadaten für Schema, Table Groups, Tabellen, Spalten
--
-- Die Beschreibungen kommen aus den Tabellen- und Spaltenkommentaren
-- (nfo_tables.sql, nfo_stage_tables.sql), die einzige Quelle bleiben und
-- englisch sind. Nach einer Änderung an einem Kommentar dieses Skript erneut
-- ausführen. Der Text der Views steht in nfo_views.sql, weil sich View-Spalten
-- nur per create view annotieren lassen.
--
-- Zwei Speicher:
--   - SQL-Annotations (user_annotations_usage): liest Select AI, wenn das
--     Profil das Attribut "annotations" gesetzt hat. "comments" dort nicht
--     zusätzlich setzen, der Inhalt wäre doppelt im Prompt.
--   - metadata_annotations: Speicher des AI Enrichment von SQL Developer for
--     VS Code. Die Erweiterung legt das Package beim Aktivieren im Schema an
--     und liest die SQL-Annotations nicht. Schema-Beschreibung und Table Groups
--     gibt es nur hier.
--
-- Auditspalten haben keinen Kommentar (siehe nfo_tables.sql) und bekommen
-- feste Texte, damit das Enrichment vollständig ist.
--
-- Vordefinierte Labels (metadata_prebuilt_annotations): Oracle dokumentiert ihr
-- Werteformat nicht. Daher ohne Wert, außer FK und Join (Zielspalte als
-- TABELLE.SPALTE) und Aggregation (Funktion). Security-Labels: Benutzernamen
-- gelten als PII, ai_security_sensitive und ai_security_level sind nicht
-- vergeben.
--
-- Voraussetzung: Oracle 23ai (Annotations), wie pkg_nfo_tapi_gen.
--------------------------------------------------------------------------------

whenever sqlerror exit failure

declare
   l_missing varchar2(4000);

   procedure annotate (
      p_table  in varchar2,
      p_column in varchar2,
      p_name   in varchar2,
      p_value  in varchar2 default null)
   is
      l_clause varchar2(4000) :=
         'annotations (add or replace ' || p_name
         || case when p_value is not null then ' ''' || replace(p_value, '''', '''''') || '''' end || ')';
   begin
      execute immediate 'alter table ' || p_table || ' '
         || case when p_column is null then l_clause
                 else 'modify (' || p_column || ' ' || l_clause || ')'
            end;
   end annotate;
begin
   -----------------------------------------------------------------------------
   -- Beschreibungen aus den Kommentaren
   -----------------------------------------------------------------------------
   for r in (select t.table_name, c.comments
               from user_tables t
               join user_tab_comments c on c.table_name = t.table_name
              where t.table_name like 'T\_NFO\_%' escape '\'
                and c.comments is not null)
   loop
      annotate(r.table_name, null, 'description', r.comments);
   end loop;

   for r in (select c.table_name, c.column_name,
                    nvl(m.comments,
                        case regexp_substr(c.column_name, '_(INS|UPD)_(DATE|USER)$')
                           when '_INS_DATE' then 'Date and time the row was created.'
                           when '_INS_USER' then 'User who created the row.'
                           when '_UPD_DATE' then 'Date and time the row was last changed. Empty if it was never changed.'
                           when '_UPD_USER' then 'User who last changed the row. Empty if it was never changed.'
                        end) as text
               from user_tab_cols c
               join user_tables t on t.table_name = c.table_name
               left join user_col_comments m on m.table_name = c.table_name and m.column_name = c.column_name
              where c.table_name like 'T\_NFO\_%' escape '\'
                and c.hidden_column = 'NO')
   loop
      if r.text is not null then
         annotate(r.table_name, r.column_name, 'description', r.text);
      end if;
   end loop;

   -- Benutzerspalten sind personenbezogen
   for r in (select table_name, column_name
               from user_tab_cols
              where table_name like 'T\_NFO\_%' escape '\'
                and regexp_like(column_name, '_(INS|UPD)_USER$')
                and hidden_column = 'NO')
   loop
      annotate(r.table_name, r.column_name, 'ai_security_pii');
   end loop;

   -----------------------------------------------------------------------------
   -- Vordefinierte Labels
   -----------------------------------------------------------------------------
   -- Schlüssel kommen aus dem Data Dictionary
   for r in (select c.table_name, cc.column_name
               from user_constraints c
               join user_cons_columns cc on cc.constraint_name = c.constraint_name
              where c.constraint_type = 'P'
                and c.table_name like 'T\_NFO\_%' escape '\')
   loop
      annotate(r.table_name, r.column_name, 'ai_relationship_primary_key');
   end loop;

   for r in (select c.table_name, cc.column_name, pc.table_name || '.' || pc.column_name as target
               from user_constraints c
               join user_cons_columns cc on cc.constraint_name = c.constraint_name
               join user_cons_columns pc on pc.constraint_name = c.r_constraint_name and pc.position = cc.position
              where c.constraint_type = 'R'
                and c.table_name like 'T\_NFO\_%' escape '\')
   loop
      annotate(r.table_name, r.column_name, 'ai_relationship_foreign_key', r.target);
   end loop;

   -- Beziehung ohne Fremdschlüssel
   annotate('T_NFO_FEATURES_STG', 'STG_FEAT_ID', 'ai_relationship_join', 'T_NFO_FEATURES.FEAT_ID');

   annotate('T_NFO_RELEASES',       'REL_VERSION',     'ai_analytics_dimension');
   annotate('T_NFO_CATEGORIES',     'CATG_NAME_DE',    'ai_analytics_dimension');
   annotate('T_NFO_CATEGORIES',     'CATG_NAME_EN',    'ai_analytics_dimension');
   annotate('T_NFO_RELEASE_VIDEOS', 'VID_IS_MAIN',     'ai_analytics_dimension');
   annotate('T_NFO_IMPORT_LOGS',    'IMP_IMPORT_TYPE', 'ai_analytics_dimension');
   annotate('T_NFO_IMPORT_LOGS',    'IMP_STATUS',      'ai_analytics_dimension');

   annotate('T_NFO_FEATURES', 'FEAT_CHAPTER_MATCH_SCORE', 'ai_analytics_agg', 'AVG');

   annotate('T_NFO_IMPORT_LOGS', 'IMP_STARTED_BY', 'ai_security_pii');

   -----------------------------------------------------------------------------
   -- Vollständigkeit: neue Spalte ohne Kommentar soll auffallen
   -----------------------------------------------------------------------------
   select listagg(c.table_name || '.' || c.column_name, ', ') within group (order by c.table_name, c.column_name)
     into l_missing
     from user_tab_cols c
    where c.table_name like 'T\_NFO\_%' escape '\'
      and c.hidden_column = 'NO'
      and not exists (select null
                        from user_annotations_usage a
                       where a.object_name = c.table_name
                         and a.column_name = c.column_name
                         and a.annotation_name = 'DESCRIPTION');
   if l_missing is not null then
      raise_application_error(-20001, 'AI Enrichment: Spalten ohne Kommentar: ' || l_missing);
   end if;
end;
/

-- AI Enrichment (SQL Developer for VS Code): Schema-Beschreibung und Table Groups
-- setzen, SQL-Annotations in den eigenen Speicher kopieren. Aufrufe dynamisch,
-- weil das Package fehlen kann.
declare
   l_installed number;

   procedure store_set (p_label in varchar2, p_value in varchar2, p_name in varchar2, p_type in varchar2) is
   begin
      -- delete + set statt edit, damit auch neue Einträge ohne Vorgänger gehen
      begin
         execute immediate 'begin metadata_annotations.delete(:l, :n, :t); end;'
            using p_label, p_name, p_type;
      exception
         when others then null;   -- noch kein Eintrag vorhanden
      end;
      execute immediate 'begin metadata_annotations.set(:l, nvl(:v, metadata_annotations.no_value), :n, :t); end;'
         using p_label, p_value, p_name, p_type;
   end store_set;

   procedure table_group (p_name in varchar2, p_description in varchar2, p_members in sys.odcivarchar2list, p_type in varchar2 default 'TABLE') is
   begin
      begin
         execute immediate 'begin metadata_annotations.drop_group(:g); end;' using p_name;
      exception
         when others then null;   -- Gruppe existiert noch nicht
      end;
      execute immediate 'begin metadata_annotations.create_group(:g); end;' using p_name;
      store_set('DESCRIPTION', p_description, p_name, 'GROUP');
      for i in 1 .. p_members.count loop
         execute immediate 'begin metadata_annotations.add_to_group(:g, :n, :t); end;'
            using p_name, p_members(i), p_type;
      end loop;
   end table_group;
begin
   select count(*) into l_installed from user_objects where object_name = 'METADATA_ANNOTATIONS' and object_type = 'PACKAGE';
   if l_installed = 0 then
      dbms_output.put_line('AI Enrichment nicht aktiviert, metadata_annotations wird übersprungen');
      return;
   end if;

   store_set('DESCRIPTION',
             'This schema stores the new features of Oracle APEX releases for a bilingual (German and English) web application. '
             || 'Key entities are releases, feature categories, features, YouTube release videos with their chapters, and import runs. '
             || 'Use it to answer which features a release introduced, how features are categorized, and where a feature is presented in a video. '
             || 'Prefer the V_NFO_UI_* views for queries, they resolve release versions and category names.',
             user, 'SCHEMA');

   table_group('NFO_FEATURE_CATALOG',
               'Core data: APEX releases, feature categories and the new features of each release. Use these tables for questions about features.',
               sys.odcivarchar2list('T_NFO_RELEASES', 'T_NFO_CATEGORIES', 'T_NFO_FEATURES'));
   table_group('NFO_RELEASE_VIDEOS',
               'YouTube videos of APEX releases and their chapters, and the link from a feature to the video chapter that presents it.',
               sys.odcivarchar2list('T_NFO_RELEASES', 'T_NFO_RELEASE_VIDEOS', 'T_NFO_VIDEO_CHAPTERS', 'T_NFO_FEATURES'));
   table_group('NFO_IMPORT_PIPELINE',
               'Technical tables of the CSV feature import: the log of import runs, the staging table and the temporary load table. Not meant for questions about features.',
               sys.odcivarchar2list('T_NFO_IMPORT_LOGS', 'T_NFO_FEATURES_STG', 'T_NFO_LOAD_FEATURES'));
   table_group('NFO_UI_VIEWS',
               'Views used by the APEX application. They wrap the tables, resolve release versions and category names, and are the preferred source for queries.',
               sys.odcivarchar2list('V_NFO_UI_FEATURES', 'V_NFO_UI_RELEASES', 'V_NFO_UI_CATEGORIES', 'V_NFO_UI_RELEASE_VIDEOS',
                                    'V_NFO_UI_VIDEO_CHAPTERS', 'V_NFO_UI_IMPORT_LOGS', 'V_NFO_LOV_CATEGORIES'),
               'VIEW');

   for r in (select annotation_name, annotation_value,
                    object_name || nvl2(column_name, '.' || column_name, null) as identifier_name,
                    object_type || nvl2(column_name, ' COLUMN', null)          as identifier_type
               from user_annotations_usage
              where object_type in ('TABLE', 'VIEW')
                and regexp_like(object_name, '^(T|V)_NFO_'))
   loop
      store_set(r.annotation_name, r.annotation_value, r.identifier_name, r.identifier_type);
   end loop;
end;
/

-- alter table ... annotations invalidiert abhängige Packages (%rowtype)
exec dbms_utility.compile_schema(user, compile_all => false)
