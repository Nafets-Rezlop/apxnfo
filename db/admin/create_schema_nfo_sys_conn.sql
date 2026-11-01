--------------------------------------------------------------------------------
-- Verbindungsschema NFO_SYS_CONN anlegen (als ADMIN ausführen)
--
-- Anf. 1100-1160: einziges Schema des APEX-Workspace APX_NEW_FEAT. Es besitzt
-- keine eigenen Objekte außer Synonymen und darf sonst nichts anlegen oder
-- ändern (Anf. 1130, 1160). Die Rechte auf NFO_SYS vergibt
-- grants_nfo_sys_conn.sql (als NFO_SYS), die Synonyme legt
-- synonyms_nfo_sys_conn.sql (als NFO_SYS_CONN) an.
--
-- Aufruf: @create_schema_nfo_sys_conn.sql <passwort>
--------------------------------------------------------------------------------

whenever sqlerror exit failure

-- Passwort läuft nie ab (Verbindungsschema für APEX). Das Passwort muss die
-- ADB-Regeln erfüllen: 12-30 Zeichen, Groß- und Kleinbuchstaben, Ziffer,
-- darf den Benutzernamen nicht enthalten (auch nicht in anderer Schreibweise).
begin
   execute immediate 'create profile nfo_profile limit '
                  || 'password_life_time unlimited password_grace_time unlimited';
exception
   when others then
      if sqlcode != -2379 then  -- Profil existiert schon
         raise;
      end if;
end;
/

create user nfo_sys_conn identified by "&1"
   default tablespace data
   temporary tablespace temp
   quota 0 on data
   profile nfo_profile;

-- anmelden und eigene Synonyme anlegen/ändern, sonst keine create-Rechte
-- (Anf. 1130, 1160)
grant create session to nfo_sys_conn;
grant create synonym to nfo_sys_conn;
