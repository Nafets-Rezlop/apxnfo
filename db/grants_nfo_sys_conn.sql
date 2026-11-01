--------------------------------------------------------------------------------
-- Rechte für das Verbindungsschema NFO_SYS_CONN (als NFO_SYS ausführen)
--
--   Anf. 1110: READ auf alle Tabellen und Views. READ statt SELECT, damit
--              NFO_SYS_CONN keine Sperren setzen kann (select ... for update,
--              lock table).
--   Anf. 1140: EXECUTE nur auf die TAPI-Packages pkg_nfo_*_dml, dazu
--              pkg_nfo_chapter_extractor (Sprungmarken aus APEX auslösen).
--   Anf. 1120: kein INSERT/UPDATE/DELETE, alle DML laufen über die TAPI.
--
-- Wiederholbar, nach jedem neuen Objekt erneut ausführen und danach
-- synonyms_nfo_sys_conn.sql (als NFO_SYS_CONN, Anf. 1160).
--------------------------------------------------------------------------------

set serveroutput on size unlimited

begin
   for r in (
      select object_name,
             case when object_type in ('TABLE', 'VIEW') then 'read' else 'execute' end as privilege
        from user_objects
       where (object_type in ('TABLE', 'VIEW')
              and (object_name like 'T\_NFO\_%' escape '\' or object_name like 'V\_NFO\_%' escape '\'))
          or (object_type = 'PACKAGE'
              and (object_name like 'PKG\_NFO\_%\_DML' escape '\' or object_name = 'PKG_NFO_CHAPTER_EXTRACTOR'))
       order by object_type, object_name
   ) loop
      execute immediate 'grant ' || r.privilege || ' on ' || r.object_name || ' to nfo_sys_conn';
      dbms_output.put_line(rpad(r.privilege, 8) || r.object_name);
   end loop;
end;
/
