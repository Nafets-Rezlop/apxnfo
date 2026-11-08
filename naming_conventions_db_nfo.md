# Namenskonventionen NFO

Gilt für alle Datenbankobjekte des Systems (siehe [nfo_specification.md](nfo_specification.md), Abschnitt "datenmodell").

## Allgemein
- Alle Objekte tragen das Projektkürzel `nfo` im Namen.
- Jede Tabelle hat ein eindeutiges Tabellenkürzel (z.B. `feat`, `catg`, `rel`), das in Spalten-, Constraint-, Index- und Package-Namen verwendet wird.

## Übersicht

| Objekt | Konvention | Beispiel |
|--------|------------|----------|
| Tabelle | `t_nfo_<englischer Pluralname>` | `t_nfo_features`, `t_nfo_categories`, `t_nfo_releases` |
| Spalte | `<tabellenkürzel>_<spaltenname>` | `feat_id`, `feat_summary_de` |
| Primärschlüsselspalte | `<tabellenkürzel>_id` (künstlicher Schlüssel) | `feat_id` |
| Auditspalten | `<tabellenkürzel>_ins_date`, `_ins_user`, `_upd_date`, `_upd_user` | `feat_ins_date` |
| Sequenz | `s_nfo_<tabellenname ohne t_nfo_>_<primärschlüsselspalte>` | `s_nfo_features_feat_id` |
| Primary Key Constraint | `cp_nfo_<tabellenkürzel>` oder `cp_nfo_<tabellenname ohne t_nfo_>` | `cp_nfo_feat`, `cp_nfo_features` |
| Foreign Key Constraint | `cf_nfo_<tabellenkürzel elterntabelle>_<tabellenkürzel kindtabelle>_<spaltenname ohne tabellenkürzel>` | `cf_nfo_catg_feat_catg_id` |
| Unique Constraint | `c0_nfo_<tabellenkürzel>_<spaltenname ohne tabellenkürzel>` oder `c0_nfo_<tabellenname ohne t_nfo_>_<spaltenname ohne tabellenkürzel>` | `c0_nfo_catg_name`, `c0_nfo_categories_name` |
| Check Constraint | `cc_nfo_<tabellenkürzel>_<spaltenname ohne tabellenkürzel>` | `cc_nfo_feat_status` |
| Index auf FK-Spalte | identisch mit dem Namen des FK-Constraints | `cf_nfo_catg_feat_catg_id` |
| Sonstiger Index | `i_nfo_<tabellenkürzel>_<spaltenname ohne tabellenkürzel>` | `i_nfo_feat_summary_de` |
| Domäne | `dom_nfo_<name>` | `dom_nfo_user`, `dom_nfo_date` |
| SQL-Makro (skalar) | `sms_nfo_<name>` | `sms_nfo_format_date` |
| SQL-Makro (Tabelle) | `smt_nfo_<name>` | `smt_nfo_features_by_release` |
| DML-Package (TAPI) | `pkg_nfo_<tabellenkürzel>_dml` | `pkg_nfo_feat_dml` |
| View für die UI | `v_nfo_ui_<tabellenname ohne t_nfo_>` | `v_nfo_ui_features` |
| View für APEX-LOVs | `v_nfo_lov_<tabellenname ohne t_nfo_>` | `v_nfo_lov_categories` |
