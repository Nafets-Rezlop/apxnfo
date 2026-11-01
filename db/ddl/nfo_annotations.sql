--------------------------------------------------------------------------------
-- AI Enrichment: Annotation DESCRIPTION für Tabellen und Spalten
--
-- Select AI und das AI Enrichment von SQLcl / SQL Developer lesen die
-- Annotation DESCRIPTION, nicht die Kommentare. Die Texte werden daher aus den
-- Tabellen- und Spaltenkommentaren übernommen, die Kommentare bleiben die
-- einzige Quelle. Nach einer Änderung an einem Kommentar dieses Skript erneut
-- ausführen.
--
-- Auditspalten haben keinen Kommentar (siehe nfo_tables.sql) und bekommen
-- feste Texte, damit das Enrichment vollständig ist.
--
-- Die Annotations der Views stehen direkt in nfo_views.sql, weil sich
-- View-Spalten nur per create view annotieren lassen.
--
-- Voraussetzung: Oracle 23ai (Annotations), wie pkg_nfo_tapi_gen.
--------------------------------------------------------------------------------

whenever sqlerror exit failure

declare
   l_text varchar2(4000);

   function clause (p_text in varchar2) return varchar2 is
   begin
      return 'annotations (add or replace description ''' || replace(p_text, '''', '''''') || ''')';
   end clause;

   function audit_text (p_column_name in varchar2) return varchar2 is
   begin
      return case regexp_substr(p_column_name, '_(INS|UPD)_(DATE|USER)$')
                when '_INS_DATE' then 'Zeitpunkt der Anlage des Datensatzes'
                when '_INS_USER' then 'Benutzer, der den Datensatz angelegt hat'
                when '_UPD_DATE' then 'Zeitpunkt der letzten Änderung des Datensatzes'
                when '_UPD_USER' then 'Benutzer, der den Datensatz zuletzt geändert hat'
             end;
   end audit_text;
begin
   for r in (select t.table_name, c.comments
               from user_tables t
               join user_tab_comments c on c.table_name = t.table_name
              where t.table_name like 'T\_NFO\_%' escape '\'
                and c.comments is not null)
   loop
      execute immediate 'alter table ' || r.table_name || ' ' || clause(r.comments);
   end loop;

   for r in (select c.table_name, c.column_name, m.comments
               from user_tab_cols c
               join user_tables t on t.table_name = c.table_name
               left join user_col_comments m on m.table_name = c.table_name and m.column_name = c.column_name
              where c.table_name like 'T\_NFO\_%' escape '\'
                and c.hidden_column = 'NO')
   loop
      l_text := nvl(r.comments, audit_text(r.column_name));
      if l_text is not null then
         execute immediate 'alter table ' || r.table_name || ' modify (' || r.column_name || ' ' || clause(l_text) || ')';
      end if;
   end loop;
end;
/
