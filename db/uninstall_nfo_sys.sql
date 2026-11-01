--------------------------------------------------------------------------------
-- Alle NFO-Objekte im Schema NFO_SYS entfernen (Entwicklung: Neuaufbau mit
-- install_nfo_sys.sql). Löscht auch alle Daten!
--------------------------------------------------------------------------------

begin
   for r in (
      select object_type, object_name
        from user_objects
       where object_type in ('PACKAGE', 'VIEW', 'TABLE', 'SEQUENCE')
         and (object_name like 'T\_NFO\_%'   escape '\'
           or object_name like 'V\_NFO\_%'   escape '\'
           or object_name like 'S\_NFO\_%'   escape '\'
           or object_name like 'PKG\_NFO\_%' escape '\')
       order by case object_type when 'PACKAGE' then 1 when 'VIEW' then 2 when 'TABLE' then 3 else 4 end
   ) loop
      execute immediate 'drop ' || r.object_type || ' ' || r.object_name
                     || case when r.object_type = 'TABLE' then ' cascade constraints purge' end;
   end loop;
end;
/
