# Namenskonventionen für PL/SQL und DDL (Tabellen)

Quelle: Repo [j-sieben/PIT](https://github.com/j-sieben/PIT) (PL/SQL Instrumentation Toolkit, Jürgen Sieben).

> **Hinweis zur Herleitung:** PIT enthält kein eigenes Konventionsdokument. Die Regeln unten sind aus dem Quellcode abgeleitet
> (u. a. `core/tables/*.tbl`, `core/packages/pit_internal.pkb`, `pit_util.pks`, `parameters/*`, `core/views`, `core/sequences`).
> Wo PIT selbst uneinheitlich ist, steht das ausdrücklich dabei. Konventionen, die PIT nicht festlegt, sind als *„nicht definiert"* markiert.

---

## 1 DDL – Tabellen und zugehörige Objekte

### 1.1 Allgemein
| Regel | Konvention | Beispiel (PIT) |
|---|---|---|
| Schreibweise | Kleinbuchstaben, Snake Case, Keywords klein | `create table pit_message(...)` |
| Sprache der Namen | Englisch | `pit_message_severity` |
| Einrückung | 2 Leerzeichen | |
| Längenangabe | explizit mit Byte-Semantik | `varchar2(50 byte)` |
| Namenstypen | Namen von Oracle-Objekten über Platzhalter/Subtype statt fester Länge | `&ORA_NAME_TYPE.`, `pit_util.ora_name_type` |
| Flags | Boolean-Ersatz über `&FLAG_TYPE.` (Y/N) mit Check-Constraint | `pal_boolean_value_chk` |

### 1.2 Tabellen
| Regel | Konvention | Beispiel |
|---|---|---|
| Tabellenname | **Singular**, Projektpräfix, kein Typpräfix wie `t_` | `pit_message`, `pit_message_text` |
| Untergeordnete Tabelle | Name der Elterntabelle + Qualifier | `pit_message` → `pit_message_text` |
| Tabellenkürzel | **3 Buchstaben**, aus dem Namen ohne Projektpräfix gebildet | `pit_message` → `pms`, `pit_message_group` → `pmg`, `pit_message_language` → `pml`, `pit_message_severity` → `pse`, `pit_message_text` → `pmt`, `pit_translatable_item` → `pti`, `pit_internal_log` → `pil` |
| Tabellendokumentation | Kopfkommentar im NaturalDocs-Format (`Table:`, `Fields:`) **und** `comment on table` / `comment on column` für jede Spalte | siehe `pit_message.tbl` |

### 1.3 Spalten
| Regel | Konvention | Beispiel |
|---|---|---|
| Präfix | **jede Spalte** beginnt mit `<kürzel>_` | `pms_name`, `pmt_text` |
| Surrogatschlüssel (numerisch) | `<kürzel>_id` | `pse_id`, `pil_log_id` |
| Natürlicher Schlüssel (Name) | `<kürzel>_name` | `pms_name`, `pmg_name` |
| Fremdschlüsselspalte | Kürzel der **Kindtabelle** + Kürzel der Eltern + Spaltenname der Eltern | `pmt_pms_name` (Kind `pmt` → Eltern `pms`, Spalte `name`) |
| Zeitstempel | `<kürzel>_<bedeutung>_date` | `pil_log_date` |
| Werte-Spalten nach Datentyp | `<kürzel>_<typ>_value` | `pal_string_value`, `pal_integer_value`, `pal_date_value` |
| Flags | `<kürzel>_is_<eigenschaft>` | `pgr_is_modifiable` |
| Pflichtfeld | benannter Check-Constraint `<spalte>_nn` | `pmt_text_nn` |
| Primärschlüssel-Vergabe | Sequenz mit `default on null <seq>.nextval` | `pil_log_id integer default on null pit_log_seq.nextval` |

### 1.4 Constraints
| Typ | Konvention | Beispiel | Anmerkung |
|---|---|---|---|
| Primary Key | `<tabelle>_pk` | `pit_message_pk`, `parameter_local_pk` | PIT-Ausreißer: `p_pil_log_id` |
| Foreign Key | `<fk-spalte>_fk` | `pmt_pms_name_fk` | Spaltenname entspricht dem Constraint-Präfix |
| Unique | `<spalte>_u` | `pms_custom_error_u` | |
| Check | `<spalte>_chk` | `pal_boolean_value_chk` | |
| Not Null | `<spalte>_nn` | `pmt_text_nn` | als benannter Check |
| FK-Delete-Verhalten | explizit angeben | `on delete cascade` | |

### 1.5 Indizes
| Regel | Konvention | Beispiel |
|---|---|---|
| FK-Index | `idx_<spaltenname>_fk` | `idx_pmt_pml_name_fk` |
| Grundsatz | zu jedem Fremdschlüssel ein Index | |
| Andere Indizes | nicht definiert (analog `idx_<spalten>` ableitbar) | |

### 1.6 Sequenzen
| Regel | Konvention | Beispiel |
|---|---|---|
| Name | `<projekt>_<verwendung>_seq` (Suffix `_seq`) | `pit_log_seq`, `pit_translatable_item_seq` |
| Optionen | begründet kommentieren (z. B. `order`, `cache`) | `create sequence pit_log_seq order cache 10000;` |

### 1.7 Views
| Regel | Konvention | Beispiel |
|---|---|---|
| View | Tabellenname + Suffix `_v` | `pit_message_v`, `pit_message_group_v` |
| Materialized View | Suffix `_mv` | `pit_message_mv` |
| Spalten | Spaltennamen der Basistabelle (mit Kürzel) werden unverändert durchgereicht | `select m.* ...` |
| Dokumentation | `comment on table` auch für Views | |

### 1.8 Dateinamen (Repository)
| Objekt | Endung | Beispiel |
|---|---|---|
| Tabelle | `.tbl` | `pit_message.tbl` |
| Sequenz | `.seq` | `pit_log_seq.seq` |
| View | `.vw` | `pit_message_v.vw` |
| Package Spec / Body | `.pks` / `.pkb` | `pit.pks`, `pit.pkb` |
| Type Spec / Body | `.tps` / `.tpb` | `message_type.tps` |
| Migrationsskript | `change_<tabelle>.sql` | `change_pit_message.sql` |

Dateiname = Objektname, Ablage in Unterordnern je Objekttyp (`tables/`, `views/`, `packages/`, `types/`, `sequences/`).

---

## 2 PL/SQL

### 2.1 Objektnamen
| Objekt | Konvention | Beispiel |
|---|---|---|
| Package | Substantiv/Bereich, **kein** Typpräfix (`pkg_`); Projektpräfix für Projektobjekte; Zusatz-Package mit Suffix | `pit`, `pit_admin`, `pit_internal`, `pit_util`, `param`, `param_admin` |
| Object Type | Suffix `_type` oder Substantiv | `pit_context_type`, `message_type` |
| Collection-Type (SQL) | Suffix `_table` / `_list` | `pit_message_table`, `pit_module_list` |
| Methoden | Verb im Englischen, ausgeschrieben, `snake_case` | `set_import_mode`, `get_parameter_settings`, `validate_parameter_group`, `edit_parameter_group` |
| Methodenkopf | `function`/`procedure`, Parameter je eine Zeile, `return` in eigener Zeile, `as` statt `is` | |
| Abschluss | Name am `end` wiederholen | `end get_parameter;` |

### 2.2 Variablen, Parameter, Konstanten

| Element | Präfix / Suffix | Beispiel |
|---|---|---|
| Parameter | `p_` | `p_mode`, `p_pgr_id`, `p_row` |
| Lokale Variable | `l_` | `l_row`, `l_boolean`, `l_pml_list` |
| Package-Variable (global) | `g_` | `g_active_message`, `g_collect_mode` |
| Konstante | `C_` + GROSSBUCHSTABEN | `C_PARAM_GROUP`, `C_TRUE` |
| Cursor | Suffix `_cur` | `message_cur`, `context_cur` |
| Record-Typ | Suffix `_rec` | `translatable_item_rec` |
| Collection-Typ (PL/SQL) | Suffix `_tab` / `_list` | `context_list_tab`, `least_severity_list` |
| Subtype | Suffix `_type` / `_t` | `ora_name_type`, `flag_type`, `client_info_t` |
| Datentyp-Ableitung | `%type` / `%rowtype` statt fester Typen | `parameter_v.par_id%type`, `parameter_group%rowtype` |

Weitere Regeln:
- Parameter-Modus immer explizit (`in`, `in out`), z. B. `p_mode in boolean`.
- Ein Record/`%rowtype` wird als Parameter mit Namen `p_row` übergeben.
- Konstanten für Message-Namen werden zentral gehalten (generiertes Package `msg`).
- Boolean in SQL-Kontext über `flag_type` (`Y`/`N`), im PL/SQL über echtes `boolean`.

### 2.3 Dokumentation
- NaturalDocs-Kommentarblöcke `/** ... */` mit `Package:`, `Procedure:`, `Function:`, `Parameters:`, `Returns:`, `Group:`, `Constants:`, `Variables:`.
- Kommentare auf Englisch.

### 2.4 Formatierung
- Alle Keywords klein, 2 Leerzeichen Einrückung, `as` nach Methodenkopf.
- `begin` / `exception` / `end <name>;` auf Methodenebene.

### 2.5 Nicht definiert
PIT legt dazu nichts fest: Trigger, Domains (Oracle 23ai), Identity-Spalten, Auditspalten, DML-/TAPI-Packages, Benennung von Exceptions und Testpackages.

---

## 3 Kurzreferenz

```text
Tabelle         pit_message                (singular, kein t_)
Kürzel          pms                        (3 Buchstaben)
Spalte          pms_name, pse_id           (<kürzel>_<name|id|...>)
PK              pit_message_pk
FK              pmt_pms_name_fk
Unique          pms_custom_error_u
Check / NN      pal_boolean_value_chk / pmt_text_nn
FK-Index        idx_pmt_pml_name_fk
Sequenz         pit_log_seq
View / MView    pit_message_v / pit_message_mv
Package         pit_admin                  (kein pkg_)
Parameter       p_row     Lokal l_row     Global g_x     Konstante C_X
Cursor          message_cur     Record x_rec     Collection x_tab / x_list
```
