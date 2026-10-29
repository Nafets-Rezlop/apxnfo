--------------------------------------------------------------------------------
-- pkg_nfo_tapi_gen
--
-- Erzeugt pro Tabelle ein DML-Package nach dem Muster von
-- APEX Builder > SQL Workshop > Utilities > Methods on Tables, aber mit dem
-- Recordtype der UI-View als Übergabeparameter (Anf. 990, 1010):
--
--   mrg (p_rec in out v_nfo_ui_<x>%rowtype, p_md5 in out varchar2)
--   del (p_rec in     v_nfo_ui_<x>%rowtype)
--   get (p_rec in out v_nfo_ui_<x>%rowtype, p_md5 out varchar2)
--   build_md5 (p_row in t_nfo_<x>%rowtype) return varchar2
--
-- DML nur mit MERGE und DELETE (Anf. 1020):
--   - mrg: ist der PK leer, wird er aus s_nfo_<tabelle ohne t_nfo_>_<pk> gezogen
--     und die Zeile eingefügt (Anf. 1030); sonst wird die Zeile aktualisiert.
--     Der PK kommt in p_rec zurück
--   - del: delete from <tabelle> where <pk> = p_rec.<pk>
--
-- Prüfsumme (Anf. 1000), Ablauf wie im Wizard:
--   - mrg liefert in p_md5 die Prüfsumme des gespeicherten Stands zurück,
--     get liefert sie ebenfalls
--   - mrg sperrt eine vorhandene Zeile und vergleicht die übergebene p_md5 mit
--     dem aktuellen Stand der Tabelle; bei Abweichung ORA-20001. Ist p_md5
--     leer, wird nicht geprüft (wie im Wizard)
--   - gehasht werden alle Tabellenspalten, nicht nur die Spalten der View
--
-- Zuordnung View -> Tabelle:
--   - Es werden nur Spalten geschrieben, die in View UND Tabelle gleich heißen
--     (aufgelöste Namensspalten der View werden ignoriert)
--   - Audit-Spalten (_ins_date, _ins_user, _upd_date, _upd_user) setzt die API
--     selbst (Anf. 850)
--
-- Aufruf:
--   exec pkg_nfo_tapi_gen.compile_api('T_NFO_FEATURES');
--   exec pkg_nfo_tapi_gen.compile_api('T_NFO_FEATURES', 'V_NFO_UI_FEATURES');
--   select pkg_nfo_tapi_gen.get_script('T_NFO_FEATURES') from dual;
--
-- Die View wird per Default aus dem Tabellennamen abgeleitet:
--   T_NFO_FEATURES -> V_NFO_UI_FEATURES
--
-- Voraussetzung: Oracle 23ai (Domänen, BOOLEAN), APEX 26.1 (apex_util.get_hash)
--------------------------------------------------------------------------------

create or replace package pkg_nfo_tapi_gen authid current_user is

   function get_spec (p_table_name in varchar2, p_view_name in varchar2 default null) return clob;

   function get_body (p_table_name in varchar2, p_view_name in varchar2 default null) return clob;

   -- Spec und Body inklusive "/" für ein Deployment-Skript
   function get_script (p_table_name in varchar2, p_view_name in varchar2 default null) return clob;

   procedure compile_api (p_table_name in varchar2, p_view_name in varchar2 default null);

end pkg_nfo_tapi_gen;
/

create or replace package body pkg_nfo_tapi_gen is

   c_lf        constant varchar2(1)  := chr(10);
   c_sep       constant varchar2(70) := '--------------------------------------------------------------';
   c_user_expr constant varchar2(200) :=
      'coalesce(sys_context(''APEX$SESSION'', ''APP_USER''), sys_context(''USERENV'', ''SESSION_USER''))';

   type t_col is record (
      name      user_tab_cols.column_name%type,
      data_type user_tab_cols.data_type%type,
      role      varchar2(10),  -- PK, DATA, INS_DATE, INS_USER, UPD_DATE, UPD_USER
      in_view   boolean        -- Spalte gibt es mit gleichem Namen in der View
   );
   type t_cols  is table of t_col index by pls_integer;
   type t_lines is table of varchar2(4000);
   type t_names is table of boolean index by varchar2(128);

   g_table   user_tables.table_name%type;
   g_view    user_views.view_name%type;
   g_abbr    varchar2(128);
   g_pk      user_tab_cols.column_name%type;
   g_seq     user_sequences.sequence_name%type;
   g_cols    t_cols;
   g_col_pad pls_integer;
   g_code    clob;

   ---------------------------------------------------------------------------
   -- Metadaten
   ---------------------------------------------------------------------------

   procedure init (p_table_name in varchar2, p_view_name in varchar2) is
      l_col       t_col;
      l_view_cols t_names;
      l_dummy     pls_integer;
   begin
      g_table := upper(trim(p_table_name));
      g_view  := upper(trim(coalesce(p_view_name, 'V_NFO_UI_' || regexp_replace(g_table, '^T_NFO_'))));
      g_cols.delete;
      g_seq := null;

      begin
         select cc.column_name
           into g_pk
           from user_constraints c
           join user_cons_columns cc on cc.constraint_name = c.constraint_name
          where c.table_name      = g_table
            and c.constraint_type = 'P';
      exception
         when no_data_found then
            raise_application_error(-20000, 'Tabelle ' || g_table || ' fehlt oder hat keinen Primärschlüssel.');
         when too_many_rows then
            raise_application_error(-20000, 'Tabelle ' || g_table || ' hat einen zusammengesetzten Primärschlüssel, das wird nicht unterstützt.');
      end;

      g_abbr := regexp_substr(g_pk, '^[^_]+');

      select count(*) into l_dummy from user_views where view_name = g_view;
      if l_dummy = 0 then
         raise_application_error(-20000, 'View ' || g_view || ' existiert nicht. Name als zweiten Parameter angeben oder View anlegen.');
      end if;

      for r in (
         select column_name
           from user_tab_cols
          where table_name    = g_view
            and hidden_column = 'NO'
      ) loop
         l_view_cols(r.column_name) := true;
      end loop;

      if not l_view_cols.exists(g_pk) then
         raise_application_error(-20000, 'View ' || g_view || ' enthält die Primärschlüsselspalte ' || g_pk || ' nicht.');
      end if;

      for r in (
         select column_name, data_type
           from user_tab_cols
          where table_name     = g_table
            and hidden_column  = 'NO'
            and virtual_column = 'NO'
          order by column_id
      ) loop
         l_col.name      := r.column_name;
         l_col.data_type := r.data_type;
         l_col.in_view   := l_view_cols.exists(r.column_name);
         l_col.role      := case r.column_name
                               when g_pk                   then 'PK'
                               when g_abbr || '_INS_DATE'  then 'INS_DATE'
                               when g_abbr || '_INS_USER'  then 'INS_USER'
                               when g_abbr || '_UPD_DATE'  then 'UPD_DATE'
                               when g_abbr || '_UPD_USER'  then 'UPD_USER'
                               else 'DATA'
                            end;
         g_cols(g_cols.count + 1) := l_col;
      end loop;

      begin
         select sequence_name
           into g_seq
           from user_sequences
          where sequence_name = 'S_NFO_' || regexp_replace(g_table, '^T_NFO_') || '_' || g_pk;
      exception
         when no_data_found then
            null;
      end;

      g_col_pad := 0;
      for i in 1 .. g_cols.count loop
         g_col_pad := greatest(g_col_pad, length(g_cols(i).name));
      end loop;
   end init;

   ---------------------------------------------------------------------------
   -- Namen und Code-Bausteine
   ---------------------------------------------------------------------------

   procedure add (p_line in varchar2 default null) is
   begin
      g_code := g_code || p_line || c_lf;
   end add;

   procedure add_lines (p_lines in t_lines, p_indent in varchar2, p_last in varchar2 default null) is
   begin
      for i in 1 .. p_lines.count loop
         add(p_indent || p_lines(i) || case when i < p_lines.count then ',' else p_last end);
      end loop;
   end add_lines;

   function tab      return varchar2 is begin return lower(g_table); end;
   function vw       return varchar2 is begin return lower(g_view); end;
   function pkg_name return varchar2 is begin return 'pkg_nfo_' || lower(g_abbr) || '_dml'; end;
   function pk       return varchar2 is begin return lower(g_pk); end;
   function rec (p_col in varchar2) return varchar2 is begin return 'p_rec.' || lower(p_col); end;

   -- Wert einer Spalte als Text für die Prüfsumme; null = Typ wird nicht gehasht
   function hash_expr (p_col in t_col) return varchar2 is
      l_p varchar2(200) := 'p_row.' || lower(p_col.name);
   begin
      return case
         when p_col.data_type in ('VARCHAR2', 'NVARCHAR2', 'CHAR', 'NCHAR') then
            l_p
         when p_col.data_type in ('NUMBER', 'FLOAT', 'BINARY_FLOAT', 'BINARY_DOUBLE') then
            'to_char(' || l_p || ', ''TM9'', ''nls_numeric_characters=.,'')'
         when p_col.data_type = 'DATE' then
            'to_char(' || l_p || ', ''yyyymmddhh24miss'')'
         when p_col.data_type like 'TIMESTAMP%WITH TIME ZONE' then
            'to_char(' || l_p || ', ''yyyymmddhh24missff9 tzr'')'
         when p_col.data_type like 'TIMESTAMP%' then
            'to_char(' || l_p || ', ''yyyymmddhh24missff9'')'
         when p_col.data_type like 'INTERVAL%' then
            'to_char(' || l_p || ')'
         when p_col.data_type = 'BOOLEAN' then
            'case when ' || l_p || ' then ''1'' when not ' || l_p || ' then ''0'' end'
         when p_col.data_type in ('CLOB', 'NCLOB') then
            -- apex_t_varchar2 fasst max. 32767 Byte: Länge + Anfang des LOBs
            'dbms_lob.getlength(' || l_p || ') || '':'' || dbms_lob.substr(' || l_p || ', 8000, 1)'
         when p_col.data_type = 'BLOB' then
            'dbms_lob.getlength(' || l_p || ') || '':'' || rawtohex(dbms_lob.substr(' || l_p || ', 2000, 1))'
         when p_col.data_type = 'RAW' then
            'rawtohex(' || l_p || ')'
      end;
   end hash_expr;

   -- p_mode: MRG, DEL, GET, MD5
   function param_list (p_mode in varchar2) return t_lines is
      l_lines t_lines := t_lines();

      procedure p (p_text in varchar2) is
      begin
         l_lines.extend;
         l_lines(l_lines.count) := p_text;
      end p;
   begin
      case p_mode
         when 'MRG' then
            p('p_rec in out ' || vw || '%rowtype');
            p('p_md5 in out varchar2');
         when 'DEL' then
            p('p_rec in     ' || vw || '%rowtype');
         when 'GET' then
            p('p_rec in out ' || vw || '%rowtype');
            p('p_md5 out    varchar2');
         when 'MD5' then
            p('p_row in ' || tab || '%rowtype');
      end case;
      return l_lines;
   end param_list;

   -- p_end: ';' in der Spec, null im Body (dort folgt "is")
   procedure add_signature (p_kind in varchar2, p_name in varchar2, p_mode in varchar2, p_comment in varchar2,
                            p_end in varchar2 default null) is
   begin
      add(c_sep);
      add('-- ' || p_comment || ' for table ' || tab);
      add('   ' || p_kind || ' ' || p_name || ' (');
      add_lines(param_list(p_mode), '      ',
                case when p_kind = 'function' then ') return varchar2' else ')' end || p_end);
   end add_signature;

   ---------------------------------------------------------------------------
   -- Spec
   ---------------------------------------------------------------------------

   function get_spec (p_table_name in varchar2, p_view_name in varchar2 default null) return clob is
   begin
      init(p_table_name, p_view_name);
      g_code := null;

      add('create or replace package ' || pkg_name || ' is');
      add('-- Generiert von pkg_nfo_tapi_gen (Muster: SQL Workshop > Methods on Tables)');
      add_signature('procedure', 'mrg', 'MRG', 'merge procedure', ';');
      add_signature('procedure', 'del', 'DEL', 'delete procedure', ';');
      add_signature('procedure', 'get', 'GET', 'get procedure', ';');
      add_signature('function', 'build_md5', 'MD5', 'build MD5 function', ';');
      add(c_sep);
      add('end ' || pkg_name || ';');

      return g_code;
   end get_spec;

   ---------------------------------------------------------------------------
   -- Body
   ---------------------------------------------------------------------------

   procedure gen_mrg is
      l_set    t_lines := t_lines();
      l_cols   t_lines := t_lines();
      l_values t_lines := t_lines();

      procedure s (p_col in varchar2, p_value in varchar2) is
      begin
         l_set.extend;
         l_set(l_set.count) := rpad(lower(p_col), g_col_pad) || ' = ' || p_value;
      end s;

      procedure v (p_col in varchar2, p_value in varchar2) is
      begin
         l_cols.extend;   l_cols(l_cols.count)     := lower(p_col);
         l_values.extend; l_values(l_values.count) := p_value;
      end v;
   begin
      for i in 1 .. g_cols.count loop
         case g_cols(i).role
            when 'PK'       then v(g_cols(i).name, 'src.' || lower(g_cols(i).name));
            when 'DATA'     then
               if g_cols(i).in_view then
                  s(g_cols(i).name, rec(g_cols(i).name));
                  v(g_cols(i).name, rec(g_cols(i).name));
               end if;
            when 'INS_DATE' then v(g_cols(i).name, 'sysdate');
            when 'INS_USER' then v(g_cols(i).name, c_user_expr);
            when 'UPD_DATE' then s(g_cols(i).name, 'sysdate');
            when 'UPD_USER' then s(g_cols(i).name, c_user_expr);
         end case;
      end loop;

      add_signature('procedure', 'mrg', 'MRG', 'merge procedure');
      add('   is');
      add('      l_row ' || tab || '%rowtype;');
      add('      l_md5 varchar2(32767);');
      add('   begin');
      add('      if ' || rec(g_pk) || ' is null then');
      if g_seq is not null then
         add('         -- leerer Primärschlüssel: INSERT (Anf. 1030)');
         add('         ' || rec(g_pk) || ' := ' || lower(g_seq) || '.nextval;');
      else
         add('         raise_application_error(-20002, ''Primärschlüssel ' || pk || ' darf nicht leer sein (keine Sequenz gefunden).'');');
      end if;
      add('      else');
      add('         -- vorhandene Zeile sperren und Prüfsumme vergleichen');
      add('         begin');
      add('            select *');
      add('              into l_row');
      add('              from ' || tab);
      add('             where ' || pk || ' = ' || rec(g_pk));
      add('               for update;');
      add;
      add('            l_md5 := build_md5(l_row);');
      add('            if p_md5 is not null and l_md5 != p_md5 then');
      add('               raise_application_error(-20001, ''Current version of data in database has changed since user initiated update process. current checksum = "''');
      add('                  || l_md5 || ''", item checksum = "'' || p_md5 || ''".'');');
      add('            end if;');
      add('         exception');
      add('            when no_data_found then');
      add('               null; -- Zeile gibt es noch nicht: MERGE fügt sie ein');
      add('         end;');
      add('      end if;');
      add;
      add('      merge into ' || tab || ' tgt');
      add('      using (select ' || rec(g_pk) || ' as ' || pk || ' from dual) src');
      add('         on (tgt.' || pk || ' = src.' || pk || ')');
      if l_set.count > 0 then
         add('      when matched then');
         add('         update set');
         add_lines(l_set, '            ');
      end if;
      add('      when not matched then');
      add('         insert (');
      add_lines(l_cols, '            ');
      add('         ) values (');
      add_lines(l_values, '            ');
      add('         );');
      add;
      add('      select *');
      add('        into l_row');
      add('        from ' || tab);
      add('       where ' || pk || ' = ' || rec(g_pk) || ';');
      add('      p_md5 := build_md5(l_row);');
      add('   end mrg;');
      add;
   end gen_mrg;

   procedure gen_del is
   begin
      add_signature('procedure', 'del', 'DEL', 'delete procedure');
      add('   is');
      add('   begin');
      add('      delete from ' || tab);
      add('       where ' || pk || ' = ' || rec(g_pk) || ';');
      add('   end del;');
      add;
   end gen_del;

   procedure gen_get is
   begin
      add_signature('procedure', 'get', 'GET', 'get procedure');
      add('   is');
      add('      l_id  ' || vw || '.' || pk || '%type := ' || rec(g_pk) || ';');
      add('      l_row ' || tab || '%rowtype;');
      add('   begin');
      add('      select *');
      add('        into p_rec');
      add('        from ' || vw);
      add('       where ' || pk || ' = l_id;');
      add;
      add('      select *');
      add('        into l_row');
      add('        from ' || tab);
      add('       where ' || pk || ' = l_id;');
      add('      p_md5 := build_md5(l_row);');
      add('   exception');
      add('      when no_data_found then');
      add('         p_md5 := null;');
      add('   end get;');
      add;
   end gen_get;

   procedure gen_md5 is
      l_values t_lines := t_lines();
      l_expr   varchar2(4000);
   begin
      add_signature('function', 'build_md5', 'MD5', 'build MD5 function');
      add('   is');
      add('   begin');
      for i in 1 .. g_cols.count loop
         l_expr := hash_expr(g_cols(i));
         if l_expr is null then
            add('      -- ' || lower(g_cols(i).name) || ' (' || g_cols(i).data_type || ') geht nicht in die Prüfsumme ein');
         else
            l_values.extend;
            l_values(l_values.count) := l_expr;
         end if;
      end loop;
      add('      return apex_util.get_hash(');
      if l_values.count = 0 then
         add('         p_values => apex_t_varchar2(),');
      else
         add('         p_values => apex_t_varchar2(');
         add_lines(l_values, '            ', '),');
      end if;
      add('         p_salted => true);');
      add('   end build_md5;');
      add;
   end gen_md5;

   function get_body (p_table_name in varchar2, p_view_name in varchar2 default null) return clob is
   begin
      init(p_table_name, p_view_name);
      g_code := null;

      add('create or replace package body ' || pkg_name || ' is');
      add;
      gen_mrg;
      gen_del;
      gen_get;
      gen_md5;
      add('end ' || pkg_name || ';');

      return g_code;
   end get_body;

   function get_script (p_table_name in varchar2, p_view_name in varchar2 default null) return clob is
   begin
      return get_spec(p_table_name, p_view_name) || '/' || c_lf || c_lf
          || get_body(p_table_name, p_view_name) || '/' || c_lf;
   end get_script;

   procedure compile_api (p_table_name in varchar2, p_view_name in varchar2 default null) is
   begin
      execute immediate get_spec(p_table_name, p_view_name);
      execute immediate get_body(p_table_name, p_view_name);
   end compile_api;

end pkg_nfo_tapi_gen;
/
