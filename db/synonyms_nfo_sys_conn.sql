--------------------------------------------------------------------------------
-- Synonyme im Verbindungsschema (als NFO_SYS_CONN ausführen)
--
-- Anf. 1150: APEX referenziert den Schemanamen NFO_SYS nicht direkt. Für jedes
-- Objekt, auf das NFO_SYS_CONN ein Recht hat, entsteht ein gleichnamiges
-- Synonym. Synonyme ohne Recht werden entfernt.
--
-- Anf. 1160: NFO_SYS_CONN legt die Synonyme selbst an (create synonym), andere
-- Objekte darf es nicht anlegen. Wiederholbar, nach grants_nfo_sys_conn.sql
-- (als NFO_SYS) ausführen.
--------------------------------------------------------------------------------

set serveroutput on size unlimited

begin
   for r in (
      select distinct table_name
        from user_tab_privs_recd
       where owner = 'NFO_SYS'
   ) loop
      execute immediate 'create or replace synonym ' || r.table_name || ' for nfo_sys.' || r.table_name;
      dbms_output.put_line('Synonym ' || r.table_name);
   end loop;

   for r in (
      select s.synonym_name
        from user_synonyms s
       where not exists (select 1
                           from user_tab_privs_recd p
                          where p.owner      = s.table_owner
                            and p.table_name = s.table_name)
   ) loop
      execute immediate 'drop synonym ' || r.synonym_name;
      dbms_output.put_line('entfernt ' || r.synonym_name);
   end loop;
end;
/
