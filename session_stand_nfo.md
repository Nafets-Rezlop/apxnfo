# Arbeitsstand NFO (2026-11-08)

Zum Weitermachen nach einem Neustart. Claude Code in `apxnfo` starten und diese Datei lesen lassen.

## Nächste Schritte

Keine Entscheidung ist mehr offen. Als Nächstes ansehen:

1. **Service der APEX-Verbindung prüfen.** Auf `_HIGH` scheitern mehrere Schreibvorgänge in einer Transaktion weiterhin, siehe unten.
2. **Branch `feature/chapter-matcher` pushen und zusammenführen.** Bisher nur lokal committet.
3. Die Punkte unter „Weitere offene Punkte“.

## Datenbank

- Verbindung: `sql -name "Autonomous (Spielwiese) (NFO_SYS)"`. `Cloud Autonomous (NFO_SYS)` zeigt auf dieselbe Datenbank, hat aber kein gespeichertes Passwort.
- Ziel-DB: Oracle AI Database 26ai (23.26.4), Service `_HIGH`.
- In PowerShell starten, Git Bash verändert `/nolog`.

## Erledigt und in der DB eingespielt

**AI Enrichment auf Englisch**
- Schema-Beschreibung, 4 Table Groups, alle Tabellen, Views und Spalten.
- Dazu `AI_RELATIONSHIP_*`, `AI_ANALYTICS_*` und `AI_SECURITY_PII`. Ihr Werteformat ist von Oracle nicht dokumentiert, `TABELLE.SPALTE` bei FK und Join ist eine eigene Festlegung.
- Im VS-Code-Dashboard noch nicht angesehen. Dort vor allem prüfen, ob die View-Gruppe `NFO_UI_VIEWS` erscheint.

**DB-Kommentare auf Englisch** (Anf. 830)
- Die Kommentare sind die einzige Quelle für die Beschreibungen der Tabellen. Nach einer Änderung `db/ddl/nfo_annotations.sql` erneut ausführen.
- Die Texte der Views stehen in `db/ddl/nfo_views.sql`.

**`pkg_nfo_chapter_matcher`** (Issue #10)
- Vergleicht Featuretitel und Titel der Sprungmarke desselben Releases.
- Ab Score 0,6 Zuordnung, ab 0,4 nur Vorschlag.
- Manuelle Zuordnungen (Kapitel gesetzt, Score leer) bleiben erhalten.

```sql
select * from pkg_nfo_chapter_matcher.preview(:rel_id);  -- ohne DML
exec pkg_nfo_chapter_matcher.match_all;                  -- ohne commit
```

Für 26.1 gespeichert und committet: 7 Zuordnungen. Dazu 4 Vorschläge und 54 ohne Treffer, beide nicht gespeichert.

| Score | Feature | Sprungmarke |
|---:|---|---|
| 1,00 | AI Agent Tools | AI Agents and Tools |
| 1,00 | Data Reporter | Data Reporter |
| 0,97 | Natural Language Support for Interactive Report | Natural Language Reporting with AI Interactive Reporting |
| 0,87 | Universal Theme Enhancements | Redesigned Builder Interface and Universal Theme 26.1 |
| 0,87 | Interactive Report Enhancements | Natural Language Reporting with AI Interactive Reporting |
| 0,80 | APEXlang Features | Open Application Specification Language (APEXlang) |
| 0,67 | AI Tool Guardrails | AI Agents and Tools |

**Oracle-Skills `db` und `apex`**
- Liegen unverändert in `.claude/skills/`, Stand Commit `0779f03` von `oracle/skills`.
- Herkunft und Lizenz stehen in `.claude/skills/README.md`.
- `apexlang/26.2` bleibt im Repo, obwohl die Spec APEX 26.1 nennt.

## Parallel DML auf dem `_HIGH`-Service

Mehrere Schreibvorgänge in einer Transaktion scheitern mit `ORA-12839` oder `ORA-12860`. Der TAPI-Ablauf aus Insert, Sperre und Update endete ohne Umschalten in 5 von 5 Versuchen mit `ORA-12860`.

**Umgesetzt:** `alter session disable parallel dml` in `install_nfo_sys.sql` und am Anfang von `run` in allen drei Testpackages, wie schon in `run_migration.sql`. Die TAPIs bleiben unverändert. Ein Hint in den generierten Merges ist ausdrücklich nicht gewünscht.

| Testpackage | Ohne Umschalten | Jetzt, in frischer Session |
|---|---|---|
| `pkg_nfo_chapter_matcher_test` | 8 von 16 | 16 von 16 |
| `pkg_nfo_chapter_extractor_test` | 4 von 7 | 7 von 7 |
| `pkg_nfo_tapi_test` | 17 von 18 | 18 von 18 |

**Nicht in den Matcher:** Das Umschalten scheitert in offener Transaktion mit `ORA-12841`. In `match_release` würde es deshalb jeden Aufruf nach einem vorherigen Schreibvorgang abbrechen, in `match_all` jeden zweiten Lauf ohne Commit dazwischen. `match_all` lief im Versuch auf `_HIGH` auch ohne Umschalten durch (7 Updates auf vorhandene Zeilen), das ist aber nur eine einzelne Beobachtung.

**Noch ungeklärt:**
- Anwendungscode auf `_HIGH` bleibt gefährdet, zum Beispiel Insert und anschließendes Update derselben Zeile in einer Transaktion.
- Über welchen Service APEX verbindet und wie es sich dort verhält, ist nicht geprüft.
- `install_nfo_sys.sql` wurde nach der Änderung nicht komplett durchlaufen, nur die Testpackages wurden neu kompiliert und ausgeführt.

## Weitere offene Punkte

- Die Spec verweist in Anf. 820 noch auf den alten Namen `nfo_naming_conventions.md`, und `naming_conventions_db_nfo.md` verweist noch auf `nfo_specification.md`.
- `feat_summary_en` steht bei allen 364 Features auf dem Platzhalter `'empty'`. `feat_raw_text_en` ist ebenfalls leer.
- Sprungmarken gibt es bisher nur für ein Video von 26.1, andere Releases bekommen keine Zuordnung.
- `APEXlang Export and Import` (0,31) und `APEXlang Name for Plug-ins` (0,24) gehören wohl zur APEXlang-Sprungmarke, fallen beim Titelvergleich aber durch.
- Issue #10: Umgang mit Sprungmarken, die nicht mehr in der Beschreibung stehen, ist nicht geklärt.
- Einige Featuretitel enthalten doppelte Anführungszeichen, zum Beispiel `New ""Describe Tables"" Feature`. Sieht nach einem CSV-Importfehler aus.
- `NFO_SYS_CONN` hat kein Ausführungsrecht auf den Matcher. Ein Start aus APEX bräuchte einen Grant in `db/grants_nfo_sys_conn.sql`.
- Ein Select-AI-Profil gibt es noch nicht. Beim Anlegen `annotations` setzen, `comments` nicht, sonst stehen die Texte doppelt im Prompt.
