--------------------------------------------------------------------------------
-- APEX-Workspace APX_NEW_FEAT anlegen (als ADMIN ausführen)
--
-- Anf. 1100: einziges Schema des Workspace ist NFO_SYS_CONN. NFO_SYS wird
-- nicht zugeordnet. Den Workspace-Administrator danach in der
-- APEX-Administration anlegen.
--
-- Voraussetzung: create_schema_nfo_sys_conn.sql
--------------------------------------------------------------------------------

whenever sqlerror exit failure

begin
   apex_instance_admin.add_workspace(
      p_workspace      => 'APX_NEW_FEAT',
      p_primary_schema => 'NFO_SYS_CONN');
   commit;
end;
/

select workspace_name, schema
  from apex_workspace_schemas
 where workspace_name = 'APX_NEW_FEAT';
