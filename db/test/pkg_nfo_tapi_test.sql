--------------------------------------------------------------------------------
-- pkg_nfo_tapi_test
--
-- Unit-Tests für die generierten DML-Packages pkg_nfo_catg_dml und
-- pkg_nfo_feat_dml (Anf. 990-1030). utPLSQL ist in der DB nicht installiert,
-- daher ein schlankes eigenes Testgerüst:
--   - jeder Test läuft in eigener Transaktion und wird zurückgerollt
--   - Ausgabe per dbms_output, am Ende ORA-20999, falls ein Test fehlschlägt
--
-- Aufruf:
--   set serveroutput on
--   exec pkg_nfo_tapi_test.run;
--------------------------------------------------------------------------------

create or replace package pkg_nfo_tapi_test is

   procedure run;

   -- einzelne Tests, public damit run sie per Namen aufrufen kann
   procedure catg_insert;
   procedure catg_get;
   procedure catg_get_missing;
   procedure catg_update;
   procedure catg_lost_update;
   procedure catg_update_without_md5;
   procedure catg_insert_given_pk;
   procedure catg_unique_name;
   procedure catg_delete;
   procedure catg_delete_in_use;
   procedure feat_insert;
   procedure feat_get;
   procedure feat_move_category;
   procedure feat_lost_update_clob;
   procedure feat_unique_summary;
   procedure feat_summary_empty;
   procedure feat_summary_no_overwrite;
   procedure feat_delete;

end pkg_nfo_tapi_test;
/

create or replace package body pkg_nfo_tapi_test is

   e_checksum       exception;
   e_unique         exception;
   e_child_found    exception;
   pragma exception_init(e_checksum,    -20001);
   pragma exception_init(e_unique,      -00001);
   pragma exception_init(e_child_found, -02292);
   e_null_update    exception;
   pragma exception_init(e_null_update, -01407);

   e_assert exception;
   pragma exception_init(e_assert, -20990);

   g_passed pls_integer;
   g_failed pls_integer;

   ---------------------------------------------------------------------------
   -- Asserts
   ---------------------------------------------------------------------------

   procedure fail (p_msg in varchar2) is
   begin
      raise_application_error(-20990, p_msg);
   end fail;

   procedure assert_true (p_cond in boolean, p_msg in varchar2) is
   begin
      if p_cond is null or not p_cond then
         fail(p_msg);
      end if;
   end assert_true;

   procedure assert_eq (p_act in varchar2, p_exp in varchar2, p_msg in varchar2) is
   begin
      if not (p_act = p_exp or (p_act is null and p_exp is null)) then
         fail(p_msg || ': erwartet "' || p_exp || '", erhalten "' || p_act || '"');
      end if;
   end assert_eq;

   procedure assert_not_null (p_act in varchar2, p_msg in varchar2) is
   begin
      if p_act is null then
         fail(p_msg || ': Wert ist leer');
      end if;
   end assert_not_null;

   ---------------------------------------------------------------------------
   -- Testdaten
   ---------------------------------------------------------------------------

   function new_release return number is
      l_id t_nfo_releases.rel_id%type;
   begin
      insert into t_nfo_releases (rel_id, rel_version, rel_ins_user)
      values (s_nfo_releases_rel_id.nextval, 'T' || s_nfo_releases_rel_id.currval, 'TEST')
      returning rel_id into l_id;
      return l_id;
   end new_release;

   function new_category (p_name in varchar2) return v_nfo_ui_categories%rowtype is
      l_rec v_nfo_ui_categories%rowtype;
      l_md5 varchar2(32767);
   begin
      l_rec.catg_name_de    := p_name || ' (de)';
      l_rec.catg_name_en    := p_name || ' (en)';
      l_rec.catg_sort_order := 10;
      pkg_nfo_catg_dml.mrg(l_rec, l_md5);
      return l_rec;
   end new_category;

   function new_feature (p_rel_id in number, p_catg_id in number, p_title in varchar2)
      return v_nfo_ui_features%rowtype
   is
      l_rec v_nfo_ui_features%rowtype;
      l_md5 varchar2(32767);
   begin
      l_rec.feat_rel_id     := p_rel_id;
      l_rec.feat_catg_id    := p_catg_id;
      l_rec.feat_title      := p_title;
      l_rec.feat_summary_de := p_title || ' Zusammenfassung';
      l_rec.feat_summary_en := p_title || ' summary';
      pkg_nfo_feat_dml.mrg(l_rec, l_md5);
      return l_rec;
   end new_feature;

   function catg_row (p_id in number) return t_nfo_categories%rowtype is
      l_row t_nfo_categories%rowtype;
   begin
      select * into l_row from t_nfo_categories where catg_id = p_id;
      return l_row;
   end catg_row;

   function feat_row (p_id in number) return t_nfo_features%rowtype is
      l_row t_nfo_features%rowtype;
   begin
      select * into l_row from t_nfo_features where feat_id = p_id;
      return l_row;
   end feat_row;

   function catg_count (p_id in number) return number is
      l_cnt number;
   begin
      select count(*) into l_cnt from t_nfo_categories where catg_id = p_id;
      return l_cnt;
   end catg_count;

   function feat_count (p_id in number) return number is
      l_cnt number;
   begin
      select count(*) into l_cnt from t_nfo_features where feat_id = p_id;
      return l_cnt;
   end feat_count;

   ---------------------------------------------------------------------------
   -- Tests pkg_nfo_catg_dml
   ---------------------------------------------------------------------------

   -- leerer PK -> INSERT mit PK aus Sequenz, Auditspalten gesetzt (Anf. 850, 1030)
   procedure catg_insert is
      l_rec v_nfo_ui_categories%rowtype;
      l_md5 varchar2(32767);
      l_row t_nfo_categories%rowtype;
   begin
      l_rec.catg_name_de    := 'Test Insert de';
      l_rec.catg_name_en    := 'Test Insert en';
      l_rec.catg_sort_order := 5;
      pkg_nfo_catg_dml.mrg(l_rec, l_md5);

      assert_not_null(l_rec.catg_id, 'PK zurückgegeben');
      assert_not_null(l_md5, 'MD5 zurückgegeben');
      l_row := catg_row(l_rec.catg_id);
      assert_eq(l_row.catg_name_de, 'Test Insert de', 'name_de');
      assert_eq(l_row.catg_name_en, 'Test Insert en', 'name_en');
      assert_eq(l_row.catg_sort_order, 5, 'sort_order');
      assert_true(l_row.catg_ins_date is not null, 'ins_date gesetzt');
      assert_eq(l_row.catg_ins_user, user, 'ins_user');
      assert_true(l_row.catg_upd_date is null, 'upd_date leer');
      assert_true(l_row.catg_upd_user is null, 'upd_user leer');
      assert_eq(l_md5, pkg_nfo_catg_dml.build_md5(l_row), 'MD5 = build_md5 der Tabellenzeile');
   end catg_insert;

   -- get liefert View-Zeile und dieselbe MD5 wie mrg
   procedure catg_get is
      l_rec v_nfo_ui_categories%rowtype;
      l_get v_nfo_ui_categories%rowtype;
      l_md5 varchar2(32767);
      l_md5_get varchar2(32767);
   begin
      l_rec.catg_name_de := 'Test Get de';
      l_rec.catg_name_en := 'Test Get en';
      pkg_nfo_catg_dml.mrg(l_rec, l_md5);

      l_get.catg_id := l_rec.catg_id;
      pkg_nfo_catg_dml.get(l_get, l_md5_get);
      assert_eq(l_get.catg_name_de, 'Test Get de', 'name_de');
      assert_eq(l_get.catg_name_en, 'Test Get en', 'name_en');
      assert_eq(l_md5_get, l_md5, 'MD5 aus get = MD5 aus mrg');
   end catg_get;

   -- get auf nicht vorhandenen PK: MD5 leer, keine Exception
   procedure catg_get_missing is
      l_rec v_nfo_ui_categories%rowtype;
      l_md5 varchar2(32767) := 'x';
   begin
      l_rec.catg_id := -1;
      pkg_nfo_catg_dml.get(l_rec, l_md5);
      assert_true(l_md5 is null, 'MD5 leer');
   end catg_get_missing;

   -- gefüllter PK + aktuelle MD5 -> UPDATE, upd-Auditspalten gesetzt, ins unverändert (Anf. 160)
   procedure catg_update is
      l_rec    v_nfo_ui_categories%rowtype := new_category('Test Upd');
      l_md5    varchar2(32767);
      l_before t_nfo_categories%rowtype;
      l_row    t_nfo_categories%rowtype;
      l_id     number;
   begin
      pkg_nfo_catg_dml.get(l_rec, l_md5);
      l_before := catg_row(l_rec.catg_id);
      l_id     := l_rec.catg_id;

      l_rec.catg_name_de := 'Test Upd umbenannt';
      pkg_nfo_catg_dml.mrg(l_rec, l_md5);

      assert_eq(l_rec.catg_id, l_id, 'PK unverändert');
      l_row := catg_row(l_id);
      assert_eq(l_row.catg_name_de, 'Test Upd umbenannt', 'name_de geändert');
      assert_eq(l_row.catg_name_en, 'Test Upd (en)', 'name_en unverändert');
      assert_true(l_row.catg_ins_date = l_before.catg_ins_date, 'ins_date unverändert');
      assert_eq(l_row.catg_ins_user, l_before.catg_ins_user, 'ins_user unverändert');
      assert_true(l_row.catg_upd_date is not null, 'upd_date gesetzt');
      assert_eq(l_row.catg_upd_user, user, 'upd_user');
      assert_eq(l_md5, pkg_nfo_catg_dml.build_md5(l_row), 'neue MD5 zurückgegeben');
      assert_eq(catg_count(l_id), 1, 'kein zusätzlicher Datensatz');
   end catg_update;

   -- veraltete MD5 -> ORA-20001, Daten unverändert (Lost Update, Anf. 1000)
   procedure catg_lost_update is
      l_rec_a v_nfo_ui_categories%rowtype := new_category('Test Lost');
      l_rec_b v_nfo_ui_categories%rowtype;
      l_md5_a varchar2(32767);
      l_md5_b varchar2(32767);
   begin
      -- Benutzer A und B laden denselben Stand
      pkg_nfo_catg_dml.get(l_rec_a, l_md5_a);
      l_rec_b := l_rec_a;
      l_md5_b := l_md5_a;

      -- B speichert zuerst
      l_rec_b.catg_name_de := 'Test Lost von B';
      pkg_nfo_catg_dml.mrg(l_rec_b, l_md5_b);

      -- A speichert mit veralteter Prüfsumme
      l_rec_a.catg_name_de := 'Test Lost von A';
      begin
         pkg_nfo_catg_dml.mrg(l_rec_a, l_md5_a);
         fail('ORA-20001 erwartet');
      exception
         when e_checksum then
            null;
      end;
      assert_eq(catg_row(l_rec_a.catg_id).catg_name_de, 'Test Lost von B', 'Stand von B bleibt');
   end catg_lost_update;

   -- leere MD5 -> keine Prüfung (wie im Wizard)
   procedure catg_update_without_md5 is
      l_rec v_nfo_ui_categories%rowtype := new_category('Test NoMd5');
      l_md5 varchar2(32767);
   begin
      l_rec.catg_name_de := 'Test NoMd5 neu';
      pkg_nfo_catg_dml.mrg(l_rec, l_md5);
      assert_eq(catg_row(l_rec.catg_id).catg_name_de, 'Test NoMd5 neu', 'name_de geändert');
      assert_not_null(l_md5, 'MD5 zurückgegeben');
   end catg_update_without_md5;

   -- gefüllter PK, Zeile fehlt -> INSERT mit diesem PK
   procedure catg_insert_given_pk is
      l_rec v_nfo_ui_categories%rowtype;
      l_md5 varchar2(32767);
      l_id  number := s_nfo_categories_catg_id.nextval;
   begin
      l_rec.catg_id      := l_id;
      l_rec.catg_name_de := 'Test PK de';
      l_rec.catg_name_en := 'Test PK en';
      pkg_nfo_catg_dml.mrg(l_rec, l_md5);
      assert_eq(l_rec.catg_id, l_id, 'PK unverändert');
      assert_eq(catg_row(l_id).catg_name_de, 'Test PK de', 'Zeile angelegt');
   end catg_insert_given_pk;

   -- doppelter Name -> ORA-00001 (Anf. 170)
   procedure catg_unique_name is
      l_rec v_nfo_ui_categories%rowtype;
      l_md5 varchar2(32767);
   begin
      l_rec := new_category('Test Dup');
      l_rec.catg_id      := null;
      l_rec.catg_name_en := 'Test Dup anders (en)';
      begin
         pkg_nfo_catg_dml.mrg(l_rec, l_md5);
         fail('ORA-00001 erwartet');
      exception
         when e_unique then
            null;
      end;
   end catg_unique_name;

   -- del löscht die Zeile
   procedure catg_delete is
      l_rec v_nfo_ui_categories%rowtype := new_category('Test Del');
      l_del v_nfo_ui_categories%rowtype;
   begin
      l_del.catg_id := l_rec.catg_id;   -- nur der PK wird gebraucht
      pkg_nfo_catg_dml.del(l_del);
      assert_eq(catg_count(l_rec.catg_id), 0, 'Zeile gelöscht');
   end catg_delete;

   -- belegte Kategorie kann nicht gelöscht werden (Anf. 140)
   procedure catg_delete_in_use is
      l_catg v_nfo_ui_categories%rowtype := new_category('Test InUse');
      l_feat v_nfo_ui_features%rowtype;
   begin
      l_feat := new_feature(new_release, l_catg.catg_id, 'Test InUse Feature');
      begin
         pkg_nfo_catg_dml.del(l_catg);
         fail('ORA-02292 erwartet');
      exception
         when e_child_found then
            null;
      end;
   end catg_delete_in_use;

   ---------------------------------------------------------------------------
   -- Tests pkg_nfo_feat_dml
   ---------------------------------------------------------------------------

   -- INSERT mit Defaults (default on null) und Auditspalten
   procedure feat_insert is
      l_catg v_nfo_ui_categories%rowtype := new_category('Test FIns');
      l_rel  number := new_release;
      l_rec  v_nfo_ui_features%rowtype;
      l_md5  varchar2(32767);
      l_row  t_nfo_features%rowtype;
   begin
      l_rec.feat_rel_id      := l_rel;
      l_rec.feat_catg_id     := l_catg.catg_id;
      l_rec.feat_title       := 'Test Feature';
      l_rec.feat_raw_text_en := 'raw text';
      l_rec.feat_summary_de  := 'Test Feature de';
      l_rec.feat_summary_en  := 'Test Feature en';
      l_rec.feat_link_feature_oracle_doc := 'https://docs.oracle.com/x';
      -- aufgelöste Spalten der View werden ignoriert
      l_rec.catg_name_de     := 'wird ignoriert';
      l_rec.rel_version      := 'wird ignoriert';
      pkg_nfo_feat_dml.mrg(l_rec, l_md5);

      assert_not_null(l_rec.feat_id, 'PK zurückgegeben');
      assert_not_null(l_md5, 'MD5 zurückgegeben');
      l_row := feat_row(l_rec.feat_id);
      assert_eq(l_row.feat_title, 'Test Feature', 'title');
      assert_eq(l_row.feat_rel_id, l_rel, 'rel_id');
      assert_eq(l_row.feat_catg_id, l_catg.catg_id, 'catg_id');
      assert_eq(dbms_lob.substr(l_row.feat_raw_text_en, 100, 1), 'raw text', 'raw_text_en');
      assert_eq(l_row.feat_link_feature_oracle_doc, 'https://docs.oracle.com/x', 'doc link');
      assert_eq(l_row.feat_ins_user, user, 'ins_user');
      assert_true(l_row.feat_upd_date is null, 'upd_date leer');
      assert_eq(catg_row(l_catg.catg_id).catg_name_de, 'Test FIns (de)', 'Kategoriename unverändert');
   end feat_insert;

   -- get löst Namen auf und liefert dieselbe MD5
   procedure feat_get is
      l_catg v_nfo_ui_categories%rowtype := new_category('Test FGet');
      l_rec  v_nfo_ui_features%rowtype;
      l_get  v_nfo_ui_features%rowtype;
      l_md5  varchar2(32767);
   begin
      l_rec.feat_rel_id     := new_release;
      l_rec.feat_catg_id    := l_catg.catg_id;
      l_rec.feat_title      := 'Test FGet';
      l_rec.feat_summary_de := 'Test FGet de';
      pkg_nfo_feat_dml.mrg(l_rec, l_md5);

      l_get.feat_id := l_rec.feat_id;
      declare
         l_md5_get varchar2(32767);
      begin
         pkg_nfo_feat_dml.get(l_get, l_md5_get);
         assert_eq(l_md5_get, l_md5, 'MD5 aus get = MD5 aus mrg');
      end;
      assert_eq(l_get.catg_name_de, 'Test FGet (de)', 'catg_name_de aufgelöst');
      assert_eq(l_get.catg_name_en, 'Test FGet (en)', 'catg_name_en aufgelöst');
      assert_not_null(l_get.rel_version, 'rel_version aufgelöst');
      assert_eq(l_get.feat_title, 'Test FGet', 'title');
   end feat_get;

   -- Feature in andere Kategorie verschieben (Anf. 130)
   procedure feat_move_category is
      l_catg_a v_nfo_ui_categories%rowtype := new_category('Test MoveA');
      l_catg_b v_nfo_ui_categories%rowtype := new_category('Test MoveB');
      l_rec    v_nfo_ui_features%rowtype := new_feature(new_release, l_catg_a.catg_id, 'Test Move');
      l_md5    varchar2(32767);
      l_row    t_nfo_features%rowtype;
   begin
      pkg_nfo_feat_dml.get(l_rec, l_md5);
      l_rec.feat_catg_id := l_catg_b.catg_id;
      pkg_nfo_feat_dml.mrg(l_rec, l_md5);

      l_row := feat_row(l_rec.feat_id);
      assert_eq(l_row.feat_catg_id, l_catg_b.catg_id, 'neue Kategorie');
      assert_eq(l_row.feat_title, 'Test Move', 'title unverändert');
      assert_true(l_row.feat_upd_date is not null, 'upd_date gesetzt');
      assert_eq(l_row.feat_upd_user, user, 'upd_user');

      -- danach ist die alte Kategorie frei und löschbar (Anf. 140)
      pkg_nfo_catg_dml.del(l_catg_a);
      assert_eq(catg_count(l_catg_a.catg_id), 0, 'alte Kategorie gelöscht');
   end feat_move_category;

   -- Lost Update auch über CLOB-Änderung erkannt
   procedure feat_lost_update_clob is
      l_catg  v_nfo_ui_categories%rowtype := new_category('Test FLost');
      l_rec_a v_nfo_ui_features%rowtype := new_feature(new_release, l_catg.catg_id, 'Test FLost');
      l_rec_b v_nfo_ui_features%rowtype;
      l_md5_a varchar2(32767);
      l_md5_b varchar2(32767);
   begin
      pkg_nfo_feat_dml.get(l_rec_a, l_md5_a);
      l_rec_b := l_rec_a;
      l_md5_b := l_md5_a;

      l_rec_b.feat_raw_text_en := 'geändert von B';
      pkg_nfo_feat_dml.mrg(l_rec_b, l_md5_b);
      assert_true(l_md5_b != l_md5_a, 'MD5 nach CLOB-Änderung anders');

      l_rec_a.feat_title := 'Test FLost von A';
      begin
         pkg_nfo_feat_dml.mrg(l_rec_a, l_md5_a);
         fail('ORA-20001 erwartet');
      exception
         when e_checksum then
            null;
      end;
      assert_eq(feat_row(l_rec_a.feat_id).feat_title, 'Test FLost', 'title unverändert');
   end feat_lost_update_clob;

   -- doppelte Zusammenfassung -> ORA-00001 (Anf. 450)
   procedure feat_unique_summary is
      l_catg v_nfo_ui_categories%rowtype := new_category('Test FDup');
      l_rel  number := new_release;
      l_rec  v_nfo_ui_features%rowtype := new_feature(l_rel, l_catg.catg_id, 'Test FDup');
      l_md5  varchar2(32767);
   begin
      l_rec.feat_id         := null;
      l_rec.feat_summary_en := 'Test FDup anders';   -- summary_de bleibt gleich
      begin
         pkg_nfo_feat_dml.mrg(l_rec, l_md5);
         fail('ORA-00001 erwartet');
      exception
         when e_unique then
            null;
      end;
   end feat_unique_summary;

   -- leere Zusammenfassungen -> Initialwert 'empty', mehrfach erlaubt (Anf. 450)
   procedure feat_summary_empty is
      l_catg v_nfo_ui_categories%rowtype := new_category('Test FEmpty');
      l_rel  number := new_release;
      l_rec1 v_nfo_ui_features%rowtype;
      l_rec2 v_nfo_ui_features%rowtype;
      l_md5  varchar2(32767);
   begin
      l_rec1.feat_rel_id  := l_rel;
      l_rec1.feat_catg_id := l_catg.catg_id;
      l_rec1.feat_title   := 'Test FEmpty 1';
      l_rec2 := l_rec1;
      l_rec2.feat_title   := 'Test FEmpty 2';
      pkg_nfo_feat_dml.mrg(l_rec1, l_md5);
      pkg_nfo_feat_dml.mrg(l_rec2, l_md5);

      assert_eq(feat_row(l_rec1.feat_id).feat_summary_de, 'empty', 'summary_de Feature 1');
      assert_eq(feat_row(l_rec1.feat_id).feat_summary_en, 'empty', 'summary_en Feature 1');
      assert_eq(feat_row(l_rec2.feat_id).feat_summary_de, 'empty', 'summary_de Feature 2');
      assert_eq(feat_row(l_rec2.feat_id).feat_summary_en, 'empty', 'summary_en Feature 2');
   end feat_summary_empty;

   -- UPDATE mit leerer Zusammenfassung überschreibt nicht, sondern scheitert (ORA-01407)
   procedure feat_summary_no_overwrite is
      l_catg v_nfo_ui_categories%rowtype := new_category('Test FNoOvr');
      l_rec  v_nfo_ui_features%rowtype := new_feature(new_release, l_catg.catg_id, 'Test FNoOvr');
      l_md5  varchar2(32767);
   begin
      pkg_nfo_feat_dml.get(l_rec, l_md5);
      l_rec.feat_summary_de := null;
      begin
         pkg_nfo_feat_dml.mrg(l_rec, l_md5);
         fail('ORA-01407 erwartet');
      exception
         when e_null_update then
            null;
      end;
      assert_eq(feat_row(l_rec.feat_id).feat_summary_de, 'Test FNoOvr Zusammenfassung', 'summary_de unverändert');
   end feat_summary_no_overwrite;

   -- del löscht die Zeile, nur der PK wird gebraucht
   procedure feat_delete is
      l_catg v_nfo_ui_categories%rowtype := new_category('Test FDel');
      l_rec  v_nfo_ui_features%rowtype := new_feature(new_release, l_catg.catg_id, 'Test FDel');
      l_del  v_nfo_ui_features%rowtype;
   begin
      l_del.feat_id := l_rec.feat_id;
      pkg_nfo_feat_dml.del(l_del);
      assert_eq(feat_count(l_rec.feat_id), 0, 'Zeile gelöscht');
   end feat_delete;

   ---------------------------------------------------------------------------
   -- Runner
   ---------------------------------------------------------------------------

   procedure exec_test (p_name in varchar2) is
   begin
      execute immediate 'begin pkg_nfo_tapi_test.' || p_name || '; end;';
      rollback;
      g_passed := g_passed + 1;
      dbms_output.put_line('PASS  ' || p_name);
   exception
      when others then
         rollback;
         g_failed := g_failed + 1;
         dbms_output.put_line('FAIL  ' || p_name || ': ' || sqlerrm);
   end exec_test;

   procedure run is
   begin
      g_passed := 0;
      g_failed := 0;
      exec_test('catg_insert');
      exec_test('catg_get');
      exec_test('catg_get_missing');
      exec_test('catg_update');
      exec_test('catg_lost_update');
      exec_test('catg_update_without_md5');
      exec_test('catg_insert_given_pk');
      exec_test('catg_unique_name');
      exec_test('catg_delete');
      exec_test('catg_delete_in_use');
      exec_test('feat_insert');
      exec_test('feat_get');
      exec_test('feat_move_category');
      exec_test('feat_lost_update_clob');
      exec_test('feat_unique_summary');
      exec_test('feat_summary_empty');
      exec_test('feat_summary_no_overwrite');
      exec_test('feat_delete');
      dbms_output.put_line('----');
      dbms_output.put_line(g_passed || ' bestanden, ' || g_failed || ' fehlgeschlagen');
      if g_failed > 0 then
         raise_application_error(-20999, g_failed || ' Test(s) fehlgeschlagen');
      end if;
   end run;

end pkg_nfo_tapi_test;
/
