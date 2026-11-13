--------------------------------------------------------------------------------
-- gen_ir_ai_context.sql
--
-- Erzeugt Report Context und Column Context für einen Interactive Report mit
-- KI-Suche (APEX 26.1) aus den Annotations DESCRIPTION einer View. Die
-- Kommentare bzw. Annotations bleiben damit die einzige Quelle der
-- Beschreibungen (Anf. 830).
--
-- Ausgabe: APEXlang-Zeilen zum Einfügen in die Seite
--   reportContext: <Annotation der View>
--   <SPALTE>: columnContext: <Annotation der Spalte>
--
-- Aufruf als NFO_SYS:
--   sql -name "Autonomous (Spielwiese) (NFO_SYS)" @tools/gen_ir_ai_context.sql V_NFO_UI_FEATURES
--------------------------------------------------------------------------------

set define on verify off feedback off heading off pagesize 0 linesize 4000 trimspool on

select 'reportContext: ' || annotation_value
  from user_annotations_usage
 where object_name     = upper('&1')
   and column_name     is null
   and annotation_name = 'DESCRIPTION';

select rpad(column_name, 30) || ' columnContext: ' || annotation_value
  from user_annotations_usage
 where object_name     = upper('&1')
   and column_name     is not null
   and annotation_name = 'DESCRIPTION'
 order by column_name;

set feedback on heading on pagesize 100
