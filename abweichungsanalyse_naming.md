# Abweichungsanalyse: Namenskonventionen

Verglichen werden die Namensregeln in [nfo_specification.md](nfo_specification.md) (Abschnitt „datenmodell", Anf. 820–1030 und Code-Beispiele) mit [pit_naming_conventions.md](pit_naming_conventions.md) (abgeleitet aus PIT).

Legende: ✅ konform · ⚠️ Abweichung · ❓ Lücke (in den Anforderungen nicht geregelt) · ➕ Erweiterung (in PIT nicht vorhanden, kein Konflikt)

## 1 Gesamtübersicht

| Nr. | Thema | Anforderung | PIT-Konvention | Status |
|----:|---|---|---|:-:|
| 820 | Tabellenpräfix | `t_nfo_…` (Typ- + Projektpräfix) | `pit_…` (nur Projektpräfix) | ⚠️ |
| 822 | PK-Spalte | `<kürzel>_id` (`feat_id`) | `<kürzel>_id` (`pse_id`) | ✅ |
| 822 | Tabellenkürzel | 4 Buchstaben (`feat`, `catg`), `rel` 3 | 3 Buchstaben | ⚠️ (gering) |
| 825 | Sequenz | `s_nfo_features_feat_id` (Präfix `s_`, pro PK) | `pit_log_seq` (Suffix `_seq`), Vergabe via `default on null` | ⚠️ |
| 830 | Spaltenpräfix | Tabellenkürzel als Präfix | Tabellenkürzel als Präfix | ✅ |
| 835 | Plural/Singular | englischer **Plural** (`t_nfo_features`) | **Singular** (`pit_message`) | ⚠️ |
| 840 | FK-Constraint | `cf_nfo_<eltern>_<kind><spalte>` | `<fk-spalte>_fk` | ⚠️ |
| 840 | Beispiel | `cf_nfo_catg_feat_feat_id` | – | ⚠️ (Widerspruch, s. 2.4) |
| 840 | PK/UK/Check/NN | nicht geregelt | `_pk`, `_u`, `_chk`, `_nn` | ❓ |
| – | Indexnamen | nicht geregelt | `idx_<spalte>_fk` | ❓ |
| 850 | Auditspalten | `_ins_date/_ins_user/_upd_date/_upd_user` | nicht definiert | ➕ |
| 850 | Datumsspalten | Suffix `_date` | Suffix `_date` | ✅ |
| 870 | Domäne User | `dom_nfo_user` | PIT: Subtype `ora_name_type` / Platzhalter | ⚠️ / ➕ |
| 890 | Domäne Date | `dom_nfo_date` | – | ➕ |
| 910 | DML-Package | `pkg_nfo_<kürzel>_dml` | `pit_admin`, `param_admin` (kein `pkg_`) | ⚠️ |
| 920–980 | Views | `v_nfo_ui_<name>` (Präfix) | `<tabelle>_v` (Suffix) | ⚠️ |
| 930 | View-Spalten | `feat_link_feature_oracle_doc` … | Spalten aus Tabelle unverändert | ✅ (s. 2.7) |
| 990 | Übergabeparameter | `v_nfo_ui_x%rowtype` | `%rowtype` als `p_row` | ✅ (Name fehlt) |
| 1010 | Prozedurnamen | `mrg`, `del` (Beispiel) | ausgeschrieben, Verb + Objekt | ⚠️ |
| Bsp. | Lokale Variablen | `lo_rec_feature`, `lo_md5` | `l_…` | ⚠️ |
| Bsp. | Typ für MD5 | `varchar2(32767)` | `%type` / Subtype, passende Länge | ⚠️ |
| – | Konstanten, Cursor, Records, Globals | nicht geregelt | `C_`, `_cur`, `_rec`, `g_` | ❓ |
| – | Kommentare / Doku | nicht geregelt | `comment on …` + NaturalDocs | ❓ |
| – | Dateinamen | nicht geregelt | `.tbl .seq .vw .pks .pkb` | ❓ |

## 2 Details und Empfehlung

### 2.1 Tabellenpräfix `t_nfo_` (Anf. 820) ⚠️
PIT kodiert den Objekttyp nicht im Namen; der Typ ergibt sich aus Suffix (Views) oder Kontext. `t_` ist redundant.
**Empfehlung:** Wenn `t_` beibehalten wird, bewusst als Projekt-Abweichung dokumentieren. PIT-konform wäre `nfo_feature`, `nfo_category`, `nfo_release`.

### 2.2 Plural (Anf. 835) ⚠️
PIT nutzt konsequent Singular. Plural ist in der Praxis ebenso verbreitet.
**Empfehlung:** Entscheidung bewusst treffen und festschreiben. Plural beibehalten ist vertretbar, dann aber auch für Views/Packages einheitlich (aktuell `v_nfo_ui_features` Plural, `pkg_nfo_feat_dml` Kürzel).

### 2.3 Tabellenkürzel (822) ⚠️ gering
PIT: genau 3 Buchstaben (`pms`, `pmt`). Hier: `feat`, `catg` (4) und `rel` (3).
**Empfehlung:** Auf Vorliebe achten, aber einheitlich: entweder alle 3 (`fea`, `cat`, `rel`) oder alle 4 (`feat`, `catg`, `rels`). Wichtiger ist Eindeutigkeit des Kürzels im Schema.

### 2.4 FK-Constraint-Name (Anf. 840) ⚠️
- Schema `cf_nfo_<eltern>_<kind><spaltenname ohne kürzel>` ist lang und schwer lesbar; PIT nutzt `<fk-spalte>_fk`, z. B. `feat_catg_id_fk`.
- **Widerspruch im Beispiel:** `cf_nfo_catg_feat_feat_id` – laut Regel müsste die FK-Spalte `catg_id` (in `t_nfo_features.feat_catg_id`) enden, nicht `feat_id`. Entweder Beispiel oder Regel korrigieren (z. B. `cf_nfo_catg_feat_catg_id`).
- Präfix `cf` ist nicht selbsterklärend (Constraint Foreign?). PIT nutzt Suffix `_fk`.
- Constraint-Namen sind im Schema eindeutig zu halten; der Präfix `nfo` macht sie lang (Limit 128 Byte ist aber kein Problem).

**Empfehlung:** `<fk-spalte>_fk`, also `feat_catg_id_fk`, `feat_rel_id_fk`.

### 2.5 Sequenzen (Anf. 825) ⚠️
- PIT: Suffix `_seq`, Bindung an Spalte per `default on null <seq>.nextval`.
- Anforderung: Präfix `s_nfo_`, zusätzlich Tabellen- **und** Spaltenname im Namen (lang, redundant, da PK immer `<kürzel>_id`).
- Die Anforderung nennt nicht, wie die Sequenz an die Spalte gebunden wird. Bei MERGE (Anf. 1030) mit leerem PK muss der Wert in der TAPI oder per `default on null` kommen.

**Empfehlung:** `nfo_feature_seq` bzw. `<tabelle>_seq`; Bindung via `default on null`.

### 2.6 Views (Anf. 920–980) ⚠️
`v_nfo_ui_features` (Präfix) vs. PIT `<tabelle>_v` (Suffix). Der Zusatz `ui` hat bei PIT kein Gegenstück (PIT: `_access_v` für Zugriffssichten).
**Empfehlung:** Bei Beibehaltung `ui` als Zweck-Qualifier einheitlich verwenden, z. B. `nfo_feature_ui_v`. Alternativ Präfix bewusst als Projektstandard festlegen und für alle Objekttypen konsequent anwenden (siehe 2.9).

### 2.7 View-Spalten (Anf. 930) ✅ mit Hinweis
- Die Spaltenpräfixe bleiben erhalten (`feat_…`), PIT-konform.
- `feat_link_feature_oracle_doc` enthält „feature" doppelt (Kürzel + Name); vorzugsweise `feat_link_oracle_doc`, `feat_link_youtube`.
- Anf. 930 sagt, die View löse IDs in **Namen** auf, listet aber nur `feat_catg_id`/`feat_rel_id`. Namensspalten (`catg_name`, `rel_name`) sind nicht benannt. PIT-Konvention wäre die Spalte mit dem Kürzel der aufgelösten Tabelle (`catg_name`, `rel_name`), obwohl sie in der View-Zeile von einer fremden Tabelle stammt. Dies macht das `%rowtype` für DML (Anf. 990) uneinheitlich, weil Join-Spalten nicht schreibbar sind.
- Die View-Spalten `feat_summary_de`/`feat_summary_en`: PIT normalisiert Sprachtexte in einer eigenen Tabelle (`pit_message_text`, Schlüssel Sprache). Sprachsuffix als Spalte ist eine bewusste Abweichung (ggf. mit Issue #6 abstimmen).

### 2.8 DML-Packages und Prozeduren (Anf. 910, 990, 1010) ⚠️
- `pkg_nfo_feat_dml`: `pkg_` ist in PIT unüblich. PIT: `<projekt>_<bereich>` (`pit_admin`). **Empfehlung:** `nfo_feat_dml` oder `nfo_feature_api`.
- `mrg`/`del`: PIT verwendet ausgeschriebene Verben. **Empfehlung:** `merge_feature`/`delete_feature` (oder `merge_row`/`delete_row` im Feature-Package).
- Parameter-Namen sind nicht definiert; PIT: `p_row`, zusätzlich `p_md5` o. ä. **Empfehlung:** `p_row in v_nfo_ui_features%rowtype`, `p_md5 in varchar2`.
- Im Beispiel wird der MD5-Wert als dritter/zweiter Parameter übergeben (`lo_md5`), obwohl eine Spalte `feat_md5` nicht Teil des `%rowtype` ist. Name `lo_md5` und Typ `varchar2(32767)` sind unpassend (MD5 ist 32 Zeichen hex).

### 2.9 Lokale Variablen im Beispielcode ⚠️
`lo_rec_feature`, `lo_md5` vs. PIT `l_<name>`. Zusätzlich ist `rec`-Mitte unnötig, weil Typ aus `%rowtype` erkennbar ist.
**Empfehlung:** `l_row`, `l_md5`.

### 2.10 Domänen (Anf. 870/890) ⚠️/➕
- PIT kennt keine Oracle-Domänen (Oracle 23ai). Das PIT-Pendant ist `pit_util.ora_name_type`/Platzhalter.
- Präfix `dom_` kodiert wiederum den Objekttyp. **Empfehlung:** `nfo_user_dom`/`nfo_date_dom` oder – analog zu PIT-Subtypes – `_type`.
- Domäne `dom_nfo_date` für reines `DATE` bringt wenig Nutzen (keine Einschränkung/Constraint). Prüfen, ob sie nötig ist.
- `varchar2(128 bytes)` entspricht PIT-`ora_name_type` (128 Byte ab 12.2) ✅.

### 2.11 Auditspalten (Anf. 850) ➕
In PIT nicht vorhanden. Spaltennamen folgen dem Spaltenpräfix-Muster ✅. `_ins_date`/`_upd_date` entspricht `_date`-Konvention ✅.
Hinweis: `_ins_user` und `_upd_user` bräuchten Mechanik zur Befüllung (TAPI oder Trigger) – für DML-Packages in 910 ist die TAPI dafür der natürliche Ort.

## 3 Lücken in den Anforderungen (❓)

Nicht geregelt, aber im Projekt nötig:

1. **Constraints:** PK, Unique, Check, Not Null (Vorschlag: `<tabelle>_pk`, `<spalte>_u`, `<spalte>_chk`, `<spalte>_nn`).
2. **Indizes:** FK-Indizes `idx_<fk-spalte>_fk`, sonstige `idx_<spalten>`.
3. **PL/SQL-Elemente:** Parameter `p_`, lokale `l_`, global `g_`, Konstanten `C_`, Cursor `_cur`, Records `_rec`, Collections `_tab`/`_list`.
4. **Dokumentation:** `comment on table/column` und Header-Kommentare für Packages.
5. **Dateinamen / Ablage:** Endungen (`.tbl`, `.seq`, `.vw`, `.pks`, `.pkb`) und Ordner je Objekttyp.
6. **Trigger, Exceptions, Testpackages:** auch in PIT nicht definiert, müssten selbst festgelegt werden.
7. **Boolean/Flag-Spalten:** `<kürzel>_is_<eigenschaft>` mit Check-Constraint.

## 4 Entscheidungsbedarf

| # | Frage | Optionen |
|--:|---|---|
| 1 | Typpräfix im Objektnamen (`t_`, `v_`, `s_`, `pkg_`, `dom_`, `cf_`) oder Suffix wie PIT (`_v`, `_seq`, `_fk`) oder keins? | Projektstandard bewusst wählen; derzeit **uneinheitlich** (`t_`/`v_`/`s_`/`pkg_` Präfix, aber Tabellenkürzel statt Typ in Spalten) |
| 2 | Singular oder Plural? | PIT: Singular · Projekt: Plural |
| 3 | FK-Namen kurz (`feat_catg_id_fk`) oder lang (`cf_nfo_…`)? | PIT-konform kurz empfohlen |
| 4 | Kürzellänge einheitlich (3 oder 4)? | |
| 5 | Namen der DML-Prozeduren und Parameter | `merge_/delete_` mit `p_row`, `p_md5` empfohlen |

> Hinweis: Die Abweichungen sind keine Fehler. PIT ist Vergleichsmaßstab, nicht Pflicht. Wichtig ist, dass jede Abweichung bewusst entschieden und einheitlich im Projekt angewandt wird.
