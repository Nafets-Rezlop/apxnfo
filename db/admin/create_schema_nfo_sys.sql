--------------------------------------------------------------------------------
-- Schema NFO_SYS anlegen (als ADMIN ausführen)
--
-- Aufruf: @create_schema_nfo_sys.sql <passwort>
--------------------------------------------------------------------------------

whenever sqlerror exit failure

-- Passwort läuft nie ab. Das Profil nutzen NFO_SYS und NFO_SYS_CONN, beide Skripte
-- legen es bei Bedarf an. Das Passwort muss die ADB-Regeln erfüllen: 12-30
-- Zeichen, Groß- und Kleinbuchstaben, Ziffer, ohne den Benutzernamen.
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

create user nfo_sys identified by "&1"
   default tablespace data
   temporary tablespace temp
   quota unlimited on data
   profile nfo_profile;

-- direkt vergeben (nicht über Rollen), damit Definer-Rights-Packages und der
-- TAPI-Generator (execute immediate) die Rechte sicher haben
grant create session           to nfo_sys;
grant create table             to nfo_sys;
grant create view              to nfo_sys;
grant create sequence          to nfo_sys;
grant create procedure         to nfo_sys;
grant create trigger           to nfo_sys;
grant create type              to nfo_sys;
grant create synonym           to nfo_sys;
grant create materialized view to nfo_sys;
grant create job               to nfo_sys;
