--------------------------------------------------------------------------------
-- Rechte des Verbindungsschemas prüfen (als NFO_SYS_CONN ausführen)
--
-- Anf. 1110-1150: Lesen und TAPI-Aufrufe über Synonyme gehen, DML, Sperren und
-- das Anlegen von Objekten scheitern. Änderungen werden zurückgerollt.
-- Am Ende ORA-20999, falls eine Prüfung fehlschlägt.
--------------------------------------------------------------------------------

set serveroutput on size unlimited

declare
   g_passed pls_integer := 0;
   g_failed pls_integer := 0;

   -- p_expect_error: null = Anweisung muss gelingen, sonst erwarteter SQLCODE
   procedure check_stmt (p_name in varchar2, p_stmt in varchar2, p_expect_error in number default null) is
   begin
      execute immediate p_stmt;
      if p_expect_error is null then
         g_passed := g_passed + 1;
         dbms_output.put_line('PASS  ' || p_name);
      else
         g_failed := g_failed + 1;
         dbms_output.put_line('FAIL  ' || p_name || ': erwartet ORA' || p_expect_error || ', aber erfolgreich');
      end if;
   exception
      when others then
         if sqlcode = p_expect_error then
            g_passed := g_passed + 1;
            dbms_output.put_line('PASS  ' || p_name || ' (' || sqlcode || ')');
         else
            g_failed := g_failed + 1;
            dbms_output.put_line('FAIL  ' || p_name || ': ' || sqlerrm);
         end if;
   end check_stmt;
begin
   -- Anf. 1110, 1150: lesen über Synonyme, ohne Schemanamen
   check_stmt('read_view',  'declare n number; begin select count(*) into n from v_nfo_ui_features; end;');
   check_stmt('read_table', 'declare n number; begin select count(*) into n from t_nfo_categories; end;');

   -- READ statt SELECT: keine Sperren
   check_stmt('no_select_for_update',
              'select catg_id from t_nfo_categories where rownum = 1 for update', -1031);
   check_stmt('no_lock_table', 'lock table t_nfo_categories in exclusive mode nowait', -1031);

   -- Anf. 1120: kein direktes DML
   check_stmt('no_insert', q'[insert into t_nfo_categories (catg_id, catg_name_de, catg_name_en) values (-1, 'x', 'x')]', -1031);
   check_stmt('no_update', 'update t_nfo_categories set catg_sort_order = catg_sort_order', -1031);
   check_stmt('no_delete', 'delete from t_nfo_features where 1 = 0', -1031);

   -- Anf. 1130, 1160: außer Synonymen nichts anlegen, weder im eigenen noch im Schema NFO_SYS
   check_stmt('no_create_own',     'create table x_conn_test (id number)', -1031);
   check_stmt('no_create_view',    'create view v_conn_test as select 1 x from dual', -1031);
   check_stmt('no_create_nfo_sys', 'create view nfo_sys.v_conn_test as select 1 x from dual', -1031);
   check_stmt('no_synonym_nfo_sys', 'create synonym nfo_sys.s_conn_test for nfo_sys.t_nfo_categories', -1031);
   check_stmt('create_synonym',    'create or replace synonym s_conn_test for nfo_sys.t_nfo_categories');
   check_stmt('replace_synonym',   'create or replace synonym s_conn_test for nfo_sys.t_nfo_features');
   check_stmt('drop_synonym',      'drop synonym s_conn_test');

   -- Anf. 1140: TAPI und Extractor ausführbar, Generator nicht sichtbar
   check_stmt('exec_tapi', q'[
      declare
         l_rec v_nfo_ui_categories%rowtype;
         l_md5 varchar2(32767);
      begin
         l_rec.catg_name_de := 'Conn Test';
         l_rec.catg_name_en := 'Conn Test';
         pkg_nfo_catg_dml.mrg(l_rec, l_md5);
         pkg_nfo_catg_dml.del(l_rec);
      end;]');
   check_stmt('exec_extractor',
              'declare c pkg_nfo_chapter_extractor.t_chapters; begin c := pkg_nfo_chapter_extractor.parse(''0:00 Intro'', ''abcdefghijk''); end;');
   check_stmt('no_exec_generator', q'[begin pkg_nfo_tapi_gen.compile_api('T_NFO_CATEGORIES'); end;]', -6550);

   rollback;
   dbms_output.put_line('----');
   dbms_output.put_line(g_passed || ' bestanden, ' || g_failed || ' fehlgeschlagen');
   if g_failed > 0 then
      raise_application_error(-20999, g_failed || ' Prüfung(en) fehlgeschlagen');
   end if;
end;
/
