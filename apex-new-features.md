# Oracle APEX – New Features 18.1 bis 26.2

Übersicht aller Abschnitte aus den *New Features*-Kapiteln der Oracle APEX Release Notes, gruppiert nach Themen. Featurenamen stehen im englischen Original, damit die Browser-Suche (Strg+F / Cmd+F) dieselben Begriffe findet wie die Oracle-Doku. Jeder Name verlinkt direkt auf seinen Abschnitt in den Release Notes.

- **Stand:** 27.10.2026 · **Einträge:** 364 · **Releases:** 16 (ein Release 25.x gibt es nicht; auf 24.2 folgt 26.1)
- **Sichtbar:** Releases der letzten fünf Jahre (22.1 – 26.2), absteigend sortiert
- **Eingeklappt:** 18.1 – 21.2 je Kategorie unter *Ältere Releases*. Ob die Browser-Suche Treffer in eingeklappten Bereichen findet, hängt vom Browser ab – im Zweifel aufklappen.
- **Aufbau:** je Kategorie eine Unterüberschrift pro Release, darin die Features dieses Release
- **Zusammenfassung:** 1–3 Sätze, sinngemäß aus dem Originaltext der Release Notes. Ein einzelner Satz steht dort, wo schon der Originaltext nur aus einem Satz besteht.

## Kategorien

| Kategorie | 22.1 – 26.2 | 18.1 – 21.2 |
|:--|--:|--:|
| [KI und Generative AI](#ki-und-generative-ai) | 21 | 0 |
| [Workflow, Tasks und Automations](#workflow-tasks-und-automations) | 19 | 1 |
| [Entwicklung und Lifecycle](#entwicklung-und-lifecycle) | 59 | 23 |
| [Security und Authentifizierung](#security-und-authentifizierung) | 14 | 2 |
| [Reports, Grids und Suche](#reports-grids-und-suche) | 22 | 18 |
| [Items, Formulare und Dynamic Actions](#items-formulare-und-dynamic-actions) | 29 | 9 |
| [Charts, Maps und Kalender](#charts-maps-und-kalender) | 6 | 9 |
| [Universal Theme, UI und PWA](#universal-theme-ui-und-pwa) | 31 | 18 |
| [REST, Datenquellen und Daten-Import](#rest-datenquellen-und-daten-import) | 17 | 12 |
| [Administration und Betrieb](#administration-und-betrieb) | 16 | 2 |
| [APIs und JavaScript-Bibliotheken](#apis-und-javascript-bibliotheken) | 22 | 14 |

## KI und Generative AI

### Release 26.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Reasoning Effort for AI Agents](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-E3EC1EE4-8A4E-4CBE-9303-D5C170FA6DC9) | 26.2 | AI Agents haben eine deklarative Einstellung „Reasoning Effort“, die steuert, wie viel ein Modell vor der Antwort „nachdenkt“. Mehr Aufwand kann komplexe Aufgaben verbessern, erhöht aber Latenz und Token-Verbrauch; der Wert lässt sich auch im AI Request Handler oder über APEX_AI setzen. |
| [New Provider API Setting for Generative AI Services](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-31C88C7A-697C-46D6-AA1B-8C61D73A3607) | 26.2 | Generative-AI-Services für OpenAI, Ollama, OpenAI-kompatible Anbieter, OCI Generative AI und Google Gemini haben eine Einstellung „Provider API“, die Endpunkt und Request-Format bestimmt. Neuer Standard sind die Responses- bzw. Interactions-APIs, die bisherigen APIs gelten als veraltet. |
| [OCI Generative AI Service Settings](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-112154A3-8209-4129-A363-DCF87183818D) | 26.2 | Modell, Compartment-ID, Serving Mode, Endpoint-ID und Project-ID sind bei OCI Generative AI eigene Einstellungen statt Teil des JSON in den Additional Attributes. Sie sind über APEX_WORKSPACE_AI_SERVICES abfragbar und bei der Installation überschreibbar. |
| [AI-Generated Navigation in Show AI Assistant](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-6AAA6EDC-D109-40FF-AFE4-B3BFEF064105) | 26.2 | AI Agents im „Show AI Assistant“ können in ihren Antworten Navigationslinks erzeugen, deren Ziele, Parameter und Berechtigungen die Anwendung kontrolliert. Die Prüfung und Link-Erzeugung läuft lokal in APEX, ohne zusätzliche Aufrufe beim KI-Anbieter. |
| [Computed Columns with Natural Language in Interactive Reports](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-4B21AEBB-7A81-4DB8-9ECD-9728E64C0AA8) | 26.2 | Berechnete Spalten in Interactive Reports lassen sich per natürlicher Sprache anlegen, etwa „Gewinn = Umsatz minus Kosten“. APEX übersetzt das in eine normale Computed Column, die wie gewohnt bearbeitet oder entfernt werden kann. |

### Release 26.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Natural Language Support for Interactive Report](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-97FD585A-B2FE-4D83-8EC9-B014CFA94A4F) | 26.1 | Endanwender können Einstellungen in Interactive Reports wie Filter, Gruppenwechsel oder Diagramme per natürlicher Sprache vornehmen. Vorausgesetzt ist ein konfigurierter Generative-AI-Service in den AI-Attributen der Anwendung; der Standard-Suchmodus ist dann „Search with AI“. |
| [Create Page Using Natural Language](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-65875D64-78DE-48CF-B9AE-1AD535FBC62A) | 26.1 | Seiten lassen sich per Beschreibung in natürlicher Sprache anlegen, etwa „Erstelle einen Bericht auf EBA_PROJECTS“. Die KI schlägt Seitenname, Seitentyp und Tabelle oder Beispieldaten vor, die man übernehmen oder verfeinern kann. |
| [AI Agent Tools](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-D8D70E73-BF6C-4CF3-8B3A-B20C2463AA92) | 26.1 | AI Configurations heißen jetzt AI Agents und können AI Tools nutzen, die per SQL, PL/SQL oder JavaScript implementiert werden. Der KI-Dienst ruft „On Demand“-Tools bei Bedarf selbst auf, während „Augment System Prompt“-Tools (früher RAG Sources) vorab Kontext liefern. |
| [AI Tool Guardrails](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-D4DFB073-9A1D-4819-89BB-E223189FA7EA) | 26.1 | Sensible On-Demand-Tools können eine Bestätigung durch den Benutzer verlangen, bevor sie ausgeführt werden. Lehnt der Benutzer ab, wird das Tool nicht ausgeführt; solche Agents sind nur aus Frontend-Komponenten wie „Show AI Assistant“ nutzbar. |
| [Generate Text with AI Page Process](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-64E68A65-83E3-4E27-BB9B-6A93491E3360) | 26.1 | Der neue Seitenprozess „Generate Text with AI“ ist das deklarative Gegenstück zu apex_ai.generate(). Er eignet sich für feste Aufgaben wie Tags erzeugen, Texte zusammenfassen oder übersetzen. |
| [AI-Generated Structured Outputs (JSON)](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-32B7FD4E-822A-4F31-995A-49629F46D05E) | 26.1 | Als Antwortformat lässt sich neben Text auch „JSON Object“ mit einem JSON Schema vorgeben, sodass die KI strukturierte Daten liefert. Unter Database 26ai prüft APEX die Ausgabe gegen das Schema; derzeit nur über APEX_AI.GENERATE nutzbar. |
| [Generative AI Token Usage Limits](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-90A11DF5-356B-498D-8305-C0F4358265FA) | 26.1 | Mit „Max AI Tokens“ lässt sich die Zahl der ein- und ausgehenden Tokens für KI-Anfragen begrenzen. Das Limit kann auf Instanz-, Workspace-, Service- oder Vector-Provider-Ebene gesetzt werden. |
| [Additional AI Provider Support](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-2BBD7696-4F50-4DEF-834A-0DA80D26DF57) | 26.1 | Als KI-Anbieter werden zusätzlich Anthropic Claude, Google Gemini, Mistral AI und Ollama unterstützt. |
| [AI Dynamic Action Enhancements](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-4378479C-E9E8-4D00-9B77-5894E56BDFB8) | 26.1 | Die KI-Aktionen „Open AI Assistant“ und „Generate Text with AI“ haben die Einstellung „Items to Submit“. Die Werte dieser Items stehen serverseitig zur Verfügung, etwa für Substitutionen im System Prompt. |
| [Blueprints](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-4DEE6D63-8818-419B-9111-769AF8661AD2) | 26.1 | APEX unterstützt ein Markdown-basiertes Blueprint-Format für Spec-Driven Development mit KI-Codeassistenten. Ein Blueprint beschreibt Seiten, Navigation, Regionen und Verhalten der Anwendung und kann direkt im App Builder importiert werden. |
| [File Attachment Support for APEX_AI](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-D44EA632-F671-46CB-9AF7-B364E8843351) | 26.1 | APEX_AI.GENERATE kann Bilder und andere Dateien als Anhänge an das KI-Modell schicken. Welche Dateitypen unterstützt werden, hängt vom Anbieter ab; ein Detailgrad-Parameter regelt bei Bildern das Verhältnis von Tempo und Genauigkeit. |

### Release 24.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Dynamic Action: Generate Text with AI](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-3E6CC92E-A56C-4002-BC68-072A14D66D86) | 24.2 | Die dynamische Aktion „Generate Text with AI“ ruft den konfigurierten KI-Dienst für eine einmalige Antwort auf Basis von Benutzereingaben auf. Sie eignet sich etwa zum Zusammenfassen, Übersetzen oder Entwerfen von E-Mails. |
| [Create Custom Data Models Using AI](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-9BE115BE-5CFA-4A68-8FBB-3AFDCAD752FB) | 24.2 | Ein neues SQL-Workshop-Werkzeug erzeugt mit KI ein Skript für Tabellen, Trigger und Constraints in Oracle SQL oder Quick SQL. Voraussetzung ist ein Generative-AI-Service mit aktivierter Einstellung „Used by App Builder“. |
| [AI Configurations and RAG Sources](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-53C1F273-1F73-4E3F-BFC2-EDA2B1DABA93) | 24.2 | AI Configurations bündeln KI-Einstellungen wie System Prompt, Begrüßungstext und RAG Sources zur Wiederverwendung. RAG Sources fügen Antworten dynamisch passende Daten hinzu, gesteuert über Bedingungen zu Prompt oder Sicherheit. |
| [Generative AI Configuration Screen Enhancements](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-3E75A967-82A2-42D5-8950-4B050B47507D) | 24.2 | Die Detailseite eines Generative-AI-Service hat einen Button „Test Connection“. Er prüft vorab Angaben wie API-Schlüssel, URL und Modellbezeichnung. |

### Release 24.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Generative AI Support](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-58986BEB-A222-4976-A48E-E364DAD38406) | 24.1 | APEX unterstützt erstmals Generative AI mit OpenAI, Cohere und OCI Generative AI, konfiguriert auf Instanz- und Workspace-Ebene. Dazu gehören ein KI-Chat-Widget, die Erstellung von Anwendungen per natürlicher Sprache und ein KI-Assistent in den Code-Editoren. |

<sub>[↑ Kategorien](#kategorien)</sub>

## Workflow, Tasks und Automations

### Release 26.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Custom Outcomes for Action Tasks](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-6AB2FA91-A557-4F45-BB24-66A4C2955A42) | 26.2 | Action Tasks können eigene Ergebnisse wie YES, NO oder UNDECIDED definieren. Diese steuern Entscheidungen und Verzweigungen im Workflow und lassen sich deklarativ oder zur Laufzeit setzen. |
| [Improved Task Error Handling](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-2AD4490E-4772-49FA-A2F6-E5C0F184E4D7) | 26.2 | Human Tasks lösen beim Wechsel in den Status „Errored“ ein Fail-Ereignis aus. Darauf lassen sich Task Actions konfigurieren, etwa eine E-Mail oder PL/SQL-Code. |
| [Draft Workflow Activities](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-F11BE282-E667-454E-A5D6-28364E325446) | 26.2 | Neue Draft-Aktivitäten (Generic, Switch, Wait) erlauben es, Workflow-Modelle zu speichern, bevor alle Schritte fertig konfiguriert sind. So lässt sich der Gesamtablauf zuerst grob von oben nach unten modellieren. |
| [Workflow Diagram Export](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-6FDD8FBE-AA28-4A86-A6DC-87CBE303863F) | 26.2 | Workflow-Diagramme lassen sich direkt als PNG oder SVG exportieren. Wahlweise wird das ganze Diagramm oder nur der sichtbare Ausschnitt heruntergeladen. |
| [Migrate Workflow Instances](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-B6648905-23B9-4C6F-9C3A-1F121C59C08F) | 26.2 | Mit APEX_WORKFLOW.MIGRATE_INSTANCE wird eine laufende Workflow-Instanz auf eine neuere Workflow-Version umgestellt, ohne sie neu zu starten. Dabei können Variablen angepasst, neue Pflichtparameter befüllt und die Fortsetzungsaktivität gewählt werden. |

### Release 26.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Parallel Flow Support](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-CC52A11F-62F6-4264-B087-3EC84D39A202) | 26.1 | Mit Parallel Flow laufen Workflow-Aktivitäten in zwei oder mehr parallelen Zweigen. Erst wenn alle Zweige fertig sind, geht der Workflow zur nächsten Aktivität weiter. |
| [Multi-Tenancy and Data Segregation](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-BA7BB84C-C72D-40B3-A008-73110585B77A) | 26.1 | Workflow- und Task-Instanzen speichern die Tenant-ID der APEX-Session, sodass Daten in mandantenfähigen Umgebungen getrennt bleiben. Workflow Console und Unified Task List zeigen nur Daten des jeweiligen Mandanten. |
| [Other Workflow Enhancements](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-2ABE31DC-2B86-4EE3-B87F-4765F4FF208A) | 26.1 | Workflow- und Task-Instanzen können mit der Anwendung exportiert und importiert werden, und es gibt eine KI-Aktivität „Generate Text with AI“. Nach einem Anwendungs-Upgrade werden angehaltene Instanzen automatisch fortgesetzt; APEX_WORKFLOW.SET_ACTIVITY_DUE_DATE setzt Fälligkeiten von Aktivitäten. |
| [Other Task Enhancements](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-B30648E7-A783-4881-8E87-7AC3F8627BAC) | 26.1 | Tasks können einem Authorization Scheme als Teilnehmergruppe zugewiesen werden, und es gibt ausgeschlossene Owner und Admins. Informationsanfragen lassen sich an andere Benutzer umleiten, Teilnehmer per Code-Editor definieren und der Primärschlüssel in der Task-Details-URL referenzieren. |

### Release 24.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Workflow Enhancements](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-2ABE31DC-2B86-4EE3-B87F-4765F4FF208A) | 24.2 | Mit der Aktivität „Invoke Workflow“ ruft ein Workflow einen anderen auf, Parameter können In, Out oder In/Out sein. Variablen und Parameter unterstützen CLOB, Workflows lassen sich aus anderen Anwendungen kopieren und angehaltene Instanzen an beliebiger Aktivität fortsetzen. |
| [Accessibility Improvements (Workflow Designer)](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-EF1BA272-1D35-4A2D-8F1C-E52265AB05B6) | 24.2 | Bei der Tastaturnavigation im Workflow Designer folgt der Diagrammausschnitt dem Fokus. Der fokussierte Knoten liegt damit immer im sichtbaren Bereich. |

### Release 24.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Workflow Enhancements](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-2ABE31DC-2B86-4EE3-B87F-4765F4FF208A) | 24.1 | Eine neue, schreibgeschützte Region „Workflow Diagram“ zeigt den Weg einer Workflow-Instanz grafisch. Dazu kommen Views für bereinigbare Workflows und Tasks sowie Verbesserungen für Aktivitäts-Plug-ins und Debugging. |
| [Human Task Enhancements](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-B30648E7-A783-4881-8E87-7AC3F8627BAC) | 24.1 | Mit „Initiator Can Complete“ dürfen Antragsteller ihre eigenen Genehmigungsaufgaben abschließen. Urlaubsregeln per Prozedur ersetzen Teilnehmer zur Laufzeit. |

### Release 23.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [New Workflow Feature](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-2CE1ABC5-2788-4118-BDF3-E48051A44DA4) | 23.2 | APEX bringt eine integrierte Workflow-Lösung mit visuellem Workflow Designer, Workflow Console zur Überwachung und eigener Laufzeit-Engine. Workflows können Tasks, bedingte Verzweigungen, API-Aufrufe, E-Mail- oder Push-Benachrichtigungen, Wartezeiten und Prozess-Plug-ins kombinieren. |
| [Approvals Component Enhancements](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-99DA3745-2057-4E2B-92DD-9E22DA9D48C4) | 23.2 | Task-Parameter können als änderbar markiert werden, sodass Owner oder Business-Administratoren sie vor der Genehmigung anpassen. Administratoren können potenzielle Owner entfernen und Tasks abbrechen, und Benutzer können offene Tasks direkt aus der Task-Liste übernehmen. |
| [Action Tasks](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-89A4F2EE-7351-446D-BF88-CC99AA633EC9) | 23.2 | Action Tasks sind Aufgaben ohne Genehmigung, etwa ein Formular ausfüllen, eine Datei hochladen oder Angaben prüfen. Sie können als Workflow-Schritt dienen, jedem Benutzer zugewiesen werden und erhalten eine generierte, anpassbare Detailseite. |

### Release 23.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Approvals Component Enhancements](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-99DA3745-2057-4E2B-92DD-9E22DA9D48C4) | 23.1 | Tasks haben einen Parameter für das Fälligkeitsdatum, der die Berechnung aus der Task Definition überschreibt. Er ist im Page Designer als „Due Date Item“ und in CREATE_TASK als p_due_date verfügbar. |

### Release 22.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Approvals Functionality Updated](https://docs.oracle.com/en/database/oracle/apex/22.2/htmrn/new-features.html#GUID-08623B76-54F2-477E-BE45-DE466387EFAD) | 22.2 | Task Definitions lassen sich kopieren, und Task-Owner können vor dem Abschluss Informationen beim Antragsteller anfordern. Neu sind außerdem Protokollierung von Aktionen, flexible Fälligkeitsdaten und Ablaufregeln für Tasks. |

### Release 22.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Approvals and Unified Task List](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-D427B40D-FB12-43F0-B311-6791913EE7EC) | 22.1 | Genehmigungsaufgaben lassen sich über Task Definitions mit statischen oder dynamischen Ownern und Administratoren konfigurieren. Eine Unified Task List bündelt alle Aufgaben zentral, eine generierte Task-Details-Seite und eine Beispiel-App erleichtern den Einstieg. |

<details>
<summary>Ältere Releases 21.2 – 18.1 (1 Eintrag)</summary>

### Release 20.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Automations](https://docs.oracle.com/en/database/oracle/application-express/20.2/htmrn/index.html#GUID-13F8ABFF-C240-49B1-B6E9-2EFA1512070D) | 20.2 | Automations führen PL/SQL-Aktionen aus, ausgelöst durch Abfrageergebnisse, etwa um Anträge automatisch zu genehmigen oder Warnmails zu senden. Sie laufen nach Zeitplan oder auf Abruf über APEX_AUTOMATION und können lokale, REST-Enabled-SQL- oder REST-Quellen nutzen. |

</details>

<sub>[↑ Kategorien](#kategorien)</sub>

## Entwicklung und Lifecycle

### Release 26.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [APEXlang Deployment Files](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-2B1C0CA8-EE71-4E99-B48C-16C56BB38E7A) | 26.2 | Deployment-relevante Werte für Anwendung, Workspace, Subscriptions und Theme lassen sich in einer eigenen JSON-Deployment-Datei festlegen. Damit sind Umgebungsdetails von den eigentlichen .apx-Definitionsdateien getrennt. |
| [APEXlang APEX Upgrade Process](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-480F96D8-3AB4-4866-AA72-27A39EFC83FC) | 26.2 | Für Teams, die APEXlang-Dateien in Git als maßgebliche Quelle führen, beschreibt Oracle einen eigenen Ablauf, um jede Anwendung nach einem APEX-Upgrade nachzuziehen. Details stehen im Oracle APEX Developer's Companion. |
| [File-Level Import with APEXlang](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-49ABFCF7-51D3-4E40-A8C6-5416C44DB1BE) | 26.2 | Aus einer APEXlang-Anwendung können einzelne Dateien importiert werden, ohne die ganze Anwendung neu zu importieren. Das geht nur über die SQL-Developer-Erweiterung für VS Code und SQLcl, nicht im App Builder, und ist nur für Entwicklungsumgebungen gedacht. |
| [Subscription Mapping](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-9C5BCE28-1EF6-4E8C-A9DB-0E7AD8D01E56) | 26.2 | Beim Import von APEXlang-Anwendungen im App Builder lassen sich Subscriptions auf die passenden Elternanwendungen umhängen. Das erleichtert das Verschieben zwischen Workspaces mit unterschiedlichen Anwendungs-IDs und erhält abonnierte Komponenten. |
| [Application Locking and Working Copy APIs](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-3F6CCAA3-7694-4FCB-8500-9362F76056CE) | 26.2 | APEX_APPLICATION_ADMIN erhält öffentliche APIs zum Sperren und Entsperren von Anwendungen sowie zum Anlegen von Working Copies. Sie sind für CI/CD-Pipelines, SQLcl Projects und KI-gestützte Entwicklung gedacht und beachten die bestehenden Workspace-Rechte und Sperrregeln. |

### Release 26.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [APEXlang Features](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-C8176BD4-296C-4CAB-901E-A187DD964EAF) | 26.1 | APEX-Anwendungen lassen sich optional in APEXlang darstellen, einer offenen, für Menschen und LLMs lesbaren Spezifikationssprache. Die .apx-Dateien können versioniert, verglichen und geprüft werden und dienen in der Versionsverwaltung als maßgebliche Quelle; Bearbeitung ist auch in SQL Developer für VS Code und SQLcl möglich. |
| [APEXlang Export and Import](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-6448C9B9-9CED-42D5-BD79-4025BE5CF9C5) | 26.1 | Exporte gibt es in vier Typen (Standard, Runtime, Full, Custom) und wahlweise im SQL- oder APEXlang-Format. APEXlang-Importe laden immer die ganze Anwendung und setzen ein REST-fähiges Schema im Workspace voraus; Laufzeitdaten wie Berichte oder Workflow-Instanzen sind im APEXlang-Export noch nicht enthalten. |
| [APEXlang Name for Plug-ins](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-18187087-D740-4C95-8D63-C5916B1031BA) | 26.1 | Plug-ins und ihre Bestandteile erhalten ein Attribut „APEXlang Name“, über das sie in APEXlang referenziert werden. Beim Upgrade erzeugt APEX dafür automatisch eindeutige, lesbare Namen aus dem Komponentennamen. |
| [Static ID Added](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-CA0162F5-B44C-417F-9CE9-E4FA5C2CE6CB) | 26.1 | Alle Komponenten erhalten im Export eine eindeutige Static ID, damit Vergleiche zwischen Instanzen weniger Fehlalarme liefern. Fehlende IDs erzeugt APEX beim Upgrade oder Import automatisch; die Static ID ist standardmäßig schreibgeschützt und sollte als dauerhafter Bezeichner gelten. |
| [New Application Types](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-CE2FFDE2-5C6B-4D6C-8AF2-BBEC16899828) | 26.1 | Neben Standard-Anwendungen gibt es die Typen Theme, Library und Boilerplate. Damit lassen sich Themes, gemeinsam genutzte Komponenten und Vorlagen für neue Anwendungen zentral pflegen und abonnieren. |
| [Extension Menu Changes](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-12E44A23-1A63-4FC1-9BA8-9B0D0FEC559F) | 26.1 | Erweiterungsanwendungen können Backlinks erzeugen, die die zugehörige Seite oder Shared Component im ursprünglichen App Builder öffnen. Ein neues Attribut „Tab Identifier“ steuert, in welchem Browser-Tab ein Extension-Menü-Link geöffnet wird. |
| [Unlimited Attributes: Authorization, Authentication, and REST Source Plug-ins](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-F9096BBD-9D3D-4399-9897-4242C77CAF92) | 26.1 | Authorization-, Authentication- und REST-Source-Plug-ins unterstützen beliebig viele Attribute. Bestehende Plug-ins müssen dafür auf die Procedure-Schnittstelle umgestellt werden und lesen Attribute dann über deren Static ID. |
| [Unlimited Attributes: Dynamic Action Plug-ins](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-7DDF76D4-0D86-4122-82AC-A41431DDC31C) | 26.1 | Dynamic-Action-Plug-ins unterstützen beliebig viele Attribute. Bestehende Plug-ins werden auf die Procedure-Schnittstelle umgestellt und lesen ihre Attribute dann typisiert über die Static ID. |
| [Unlimited Attributes: Process Plug-ins](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-3F4C34F5-EE1A-4873-B5A9-DD4FD28209F2) | 26.1 | Process-Plug-ins unterstützen beliebig viele Attribute. Nach Umstellung auf die Procedure-Schnittstelle werden Attribute über ihre Static ID gelesen. |
| [Run Applications from Modal Dialog](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-72F64CF5-865E-4E8B-AB93-DE3A3E472EEC) | 26.1 | „Save and Run“ funktioniert auch auf der Global Page und in Modal Dialogs. Je nach Kontext wird dann die aktive Seite, der offene Dialog oder die Startseite neu geladen. |
| [Application Lock](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-81CE3725-46DE-41F0-BB1F-2183977ADCEC) | 26.1 | Anwendungen lassen sich sperren, sodass Änderungen im App Builder nicht mehr möglich sind und nur noch über APEXlang erfolgen. Bei Working Copies kann so die Main-Version geschützt werden. |
| [Improved Authoring of Template Directives](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-DE4F720E-F028-470F-BCE4-C5EE5858F963) | 26.1 | Template Directives werden im Code-Editor farblich hervorgehoben, und beim Tippen von {, # oder & erscheinen Vorschläge. Plug-in-Attribute können angeben, ob sie Substitutionen oder Template Directives unterstützen. |
| [Sample Data Source](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-C3D0ED96-F60C-441B-9A9E-E8A0B0735BB9) | 26.1 | Die Datenquelle „Sample Data“ liefert neuen Komponenten einige Beispielzeilen. So lassen sich Komponenten anlegen und anzeigen, bevor eine echte Datenquelle festgelegt ist. |
| [New "Describe Tables" Feature](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-CBDA84FB-DCA8-4756-9CB7-EFB01D55C6D4) | 26.1 | „Describe Tables“ in SQL Workshop und das Paket APEX_DB_DICTIONARY erzeugen eine lesbare, LLM-taugliche Beschreibung von Tabellen und Views in Markdown oder Text. Sie enthält Spalten, Datentypen, Kommentare und optional Constraints und Indizes; Voraussetzung ist DBMS_DEVELOPER. |
| [Text Message-Based Application Translations](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-6E5BC077-B6EF-448F-AA4D-3501387DC419) | 26.1 | Anwendungen lassen sich über Text Messages übersetzen, die als XLIFF oder CSV exportiert und wieder importiert werden. So läuft eine Anwendung in mehreren Sprachen, ohne für jede Sprache eine eigene übersetzte Anwendung zu benötigen. |
| [Subscription Mode](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-83B073E4-0805-4947-83F3-7C11164EC989) | 26.1 | Die Installationsoption „Subscription Mode“ legt fest, wie Subscriptions beim Installieren einer Anwendung behandelt werden. Mit set_subscription_mapping lassen sich Subscriptions dabei auf andere Anwendungen umlenken; gilt für Exporte ab 26.1. |

### Release 24.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Database Object Dependencies](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-00978EEB-46D7-4212-96F9-F896DBB599A9) | 24.2 | Ein neuer Bericht zeigt die Abhängigkeiten einer Anwendung oder Seite von Tabellen, Views, Packages und System-APIs. Er verbessert die API APEX_APP_OBJECT_DEPENDENCY aus 24.1 und erkennt Abhängigkeiten auch in SQL-Ausdrücken und REST-Quellen. |
| [Shared Component Utilization Reports](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-18FA9E57-D095-430F-A49A-6F1103BECD94) | 24.2 | Die Utilization-Berichte für Task Definitions, E-Mail-Templates und REST Data Sources zeigen auch die Verwendung in Workflows und Tasks. |
| [Unlimited Attributes for Item Plug-ins](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-D165A54A-FA88-4BDD-B948-B9BB235FA1D6) | 24.2 | Item-Plug-ins unterstützen wie Region-Plug-ins beliebig viele Attribute. Bestehende Plug-ins müssen auf die Procedure-Schnittstelle umgestellt werden und lesen Attribute dann typisiert über deren Static ID. |
| [Export App Enhancements](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-BD646581-6AFF-4906-AED7-DAF6EA5C1230) | 24.2 | Beim Export einer übersetzten Anwendung prüft APEX, ob die Übersetzungen aktuell sind, und warnt gegebenenfalls. Über „View Application Translations“ lassen sich diese prüfen und aktualisieren. |
| [Builder Extension Auto-Subscribe](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-75F1FF14-3228-49EF-9DBC-C4943787580A) | 24.2 | Instanzadministratoren können Builder Extensions automatisch für alle Workspaces veröffentlichen. Einzelne Workspaces müssen Erweiterungen dann nicht mehr manuell abonnieren. |
| [Text Messages Enhancements](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-734007F5-2156-464A-9CB6-F8EA1F108B66) | 24.2 | Text Messages erhalten Felder für Entwicklerkommentare und strukturierte Metadaten. Im Page Designer zeigt ein Picker Text Messages mit Vorschau an und macht sie im Code-Editor verfügbar. |
| [New Substitution String (MAIN_APP_ID)](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-D3E8A453-C6B7-44DE-BC6C-3B09F1EEE4AB) | 24.2 | Die neue Substitution MAIN_APP_ID liefert in einer Working Copy die ID der Hauptanwendung, sonst die aktuelle ID. Sie ist als Bind-Variable, über NV() und als Substitution nutzbar. |

### Release 24.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Component Groups](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-D9726828-B633-4835-82AF-CD1181DE08AA) | 24.1 | Component Groups bündeln zusammengehörige Shared Components. Alle Komponenten einer Gruppe lassen sich gemeinsam kopieren, abonnieren oder aktualisieren; Themes und Templates sind ausgenommen. |
| [Unlimited Attributes for Regions](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-56A901E6-C321-4DC1-8C18-8CF99CB1C87C) | 24.1 | Region-Plug-ins unterstützen beliebig viele Attribute, wie zuvor schon Template Components. Bestehende Plug-ins müssen auf die Procedure-Schnittstelle umgestellt werden und lesen Attribute dann über deren Static ID. |
| [Application Working Copy Enhancements](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-472AD1B8-AAA9-4826-B4D2-7EA3CF0157AC) | 24.1 | Der Page Designer zeigt an, wenn eine Seite in einer anderen Working Copy geändert oder gesperrt ist, und bietet einen Vergleich mit Main. Ein Bericht listet betroffene Seiten, und der YAML-Diff-Editor zeigt das letzte Änderungsdatum. |
| [App and Page Database Object Dependencies API](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-5937329A-2314-41FB-86DD-6C52566EBC95) | 24.1 | Die neue API APEX_APP_OBJECT_DEPENDENCY analysiert, welche Tabellen und Datenbankobjekte Seiten und Anwendungen verwenden. |
| [Builder Extensions Enhancements](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-2ABC757F-F8D0-4A5A-9D75-2BA18F23E3A5) | 24.1 | Anwendungen aus einem Extension-Workspace lassen sich aus anderen Workspaces derselben Instanz aufrufen. Neu sind ein Anmeldeschema ohne erneute Anmeldung, die Veröffentlichung über Extension-Menüs und APEX_EXTENSION.SET_WORKSPACE. |
| [Improved Shared Component Subscriptions](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-C9C9F957-38FD-4152-8F9D-88E052B1FCDF) | 24.1 | Die Subscription-Funktionen aus 23.2 gelten für weitere Shared Components wie Listen, REST Data Sources, Authentifizierungsschemata, LOVs und Plug-ins. Nach dem Upgrade muss der Abo-Status durch Veröffentlichen oder Aktualisieren neu ermittelt werden. |
| [App Builder Enhancements](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-CC9BE1A7-1E8E-43D3-AA86-5A0C16F31035) | 24.1 | Spotlight Search findet Ergebnisse schneller dank unscharfer Suche, gruppiert sie und hebt Treffer hervor. Komponenten lassen sich jetzt auch im App Builder zwischen Workspaces und Anwendungen exportieren und importieren. |
| [Readable Export Enhancements](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-8387C4A5-475B-4206-8695-636EFC518096) | 24.1 | Einzelne Seiten lassen sich im lesbaren YAML-Format exportieren, und Original-IDs bleiben für saubere Diffs standardmäßig erhalten. Anwendungen können lesbare Exporte erzwingen und optional Exportdatum und Benutzer aufnehmen. |

### Release 23.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Application Working Copies](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-F178C70F-87BD-4829-B0C1-94B82074C07C) | 23.2 | Eine Anwendung lässt sich als Working Copy kopieren, dort ändern und die Änderungen per visuellem Diff in die Hauptanwendung (Main) zurückführen. Damit sind Feature-Entwicklung und Tests getrennt von Main möglich; für paralleles Arbeiten empfiehlt Oracle Absprachen zu Seitennummern und Komponentennamen. |
| [Improved Shared Component Subscriptions](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-272076C2-0F6F-42D6-B9B0-CBD077F315EB) | 23.2 | Zehn weitere Arten von Shared Components wie Application Items, Prozesse, Build Options oder Text Messages lassen sich abonnieren. Abonnierte Komponenten sind schreibgeschützt, Abhängigkeiten werden automatisch aufgelöst und es gibt eine Statusspalte sowie Massenaktualisierung. |
| [Quick SQL Updates](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-756088D0-CA53-472E-8E33-FD54D4363522) | 23.2 | Quick SQL hat einen Diagramm-Tab mit Entity-Relationship-Diagramm des Datenmodells. SQL und Diagramm aktualisieren sich beim Tippen; Voraussetzung ist ORDS 23.3.0 oder neuer. |
| [Simplified Create Application Wizard](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-3BD939A9-8373-47AD-8103-2CF3EE50B2EF) | 23.2 | Eine neue Anwendung lässt sich allein durch Eingabe eines Namens sofort anlegen, mit einer Seite und Standardeinstellungen. Der vollständige Assistent und Quick SQL stehen weiterhin als Optionen bereit. |
| [Simplified Application Export](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-3B88C62A-BAB6-4640-8F0D-2A08810076FC) | 23.2 | Der Export von Anwendungen, Seiten und Komponenten ist vereinheitlicht und zeigt nur noch die wesentlichen, anpassbaren Optionen. |
| [Simplified Application Import](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-505767AC-ED9A-4733-86DA-6DC2CD2E31F6) | 23.2 | Der Import-Assistent ist vereinfacht: Anwendungen lassen sich mit oder ohne Supporting Objects, Seiten und Komponenten in wenigen Schritten installieren. |
| [EMP/DEPT Dataset Support in Arabic and Italian](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-2971E820-4346-4A4C-A342-9ED858ADA3B9) | 23.2 | Der Beispieldatensatz EMP/DEPT ist auch auf Arabisch und Italienisch verfügbar. Installiert wird er in SQL Workshop unter Utilities, Sample Datasets. |
| [Utility Apps Available in Gallery](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-91B1E6CB-5F53-490D-837F-B3D9129EA1B9) | 23.2 | Die App Gallery enthält eine Kategorie mit Utility Apps. Diese fertigen Anwendungen erleichtern häufige Entwicklungsaufgaben. |

### Release 23.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Modernized Object Browser](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-0F8CDB25-2794-40A2-9F49-4B9C967876F3) | 23.1 | Der Object Browser zeigt alle Objekttypen in einem filterbaren Baum, merkt sich die Bearbeitungsposition und warnt vor ungespeicherten Änderungen. Objekte lassen sich über einen vereinfachten Assistenten anlegen, Tabellendaten werden als XLSX exportiert. |
| [SQL Developer Web Integration](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-554225E0-8F28-418E-8259-F947878CFD7B) | 23.1 | SQL Developer Web lässt sich direkt aus dem SQL-Workshop-Menü öffnen; nötig sind ORDS 23.1 und eine Konfiguration auf Instanzebene. Es kann immer nur ein Schema gleichzeitig angemeldet sein. |
| [Plug-In Attributes Updates](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-3424B670-9711-488E-8E0F-F41D98504F06) | 23.1 | Item-Plug-ins unterstützen 25 statt 15 Attribute, und Attribute lassen sich in eigenen Gruppen ordnen. Die View apex_application_page_items zeigt die zusätzlichen Attribute. |
| [Save and Run Page from Code Editor](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-49744DBC-F068-4273-A719-E705EF30590F) | 23.1 | Standardseiten lassen sich direkt aus dem Code-Editor-Dialog im Page Designer speichern und ausführen. Dafür gibt es einen Button und das Tastenkürzel Alt+F8. |
| [Context-Sensitive APEX Help](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-2423D8B3-1425-4C77-806D-02DFAA5FFD29) | 23.1 | Dokumentationslinks in den internen APEX-Anwendungen führen gezielt zum passenden Buch oder Kapitel. |

### Release 22.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Updated Global Search (Spotlight Search)](https://docs.oracle.com/en/database/oracle/apex/22.2/htmrn/new-features.html#GUID-ACCA7B5F-C528-4A49-962A-B5B9F02356CE) | 22.2 | Die globale Suche (Spotlight) findet Seiten auch über Name und Alias. Mit Anwendungs-ID oder -Alias plus Doppelpunkt oder Bindestrich lässt sich gezielt in einer Anwendung suchen. |

### Release 22.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Simplified Page Creation](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-ACFC0463-368C-4CA2-8DE2-7F5F44810EE5) | 22.1 | Der Create Page Wizard ist stark vereinfacht und setzt sinnvolle Standards für Seitenmodus, Breadcrumb, Navigation und Primärschlüssel. Für Fremdschlüsselspalten legt er passende Shared LOVs an. |
| [Export Application Metadata in JSON or YAML Format](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-620E7DC0-8DAC-4EFF-A303-47E727AD439E) | 22.1 | Anwendungsexporte können zusätzlich ein lesbares, vergleichbares Format in JSON oder YAML enthalten. Dafür gibt es neue Exporttypen in APEX_EXPORT.GET_APPLICATION, die auch SQLcl und APEXExport unterstützen. |
| [Data Generator](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-3BE695CC-8768-4A24-999B-4F1CCF9F6B61) | 22.1 | Der Data Generator erzeugt Testdaten anhand von Blueprints mit Tabellen, Spalten und eigenen Datenquellen. Daten lassen sich als CSV, JSON oder SQL-Inserts exportieren oder direkt in Tabellen einfügen. |
| [Effortless App Gallery Installs](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-9AC96132-8507-4475-A986-A00DEC968A20) | 22.1 | Starter- und Beispiel-Apps lassen sich wieder direkt aus der neu gestalteten Galerie installieren. Ein Hinweis zeigt an, wenn für eine installierte App ein Update verfügbar ist. |
| [Session Overrides](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-69F1D3F7-0792-4FFE-BF4D-8312AC9A256F) | 22.1 | Über „Session Overrides“ in der Developer Toolbar lassen sich Session-Werte wie Sprache und Zeitzone zur Laufzeit testen, ohne andere Benutzer zu beeinflussen. Dateipfade wie #APP_FILES# können auf lokale Dateien umgeleitet werden. |
| [File URL Enhancements](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-86856169-2D43-452C-958F-AD263E9BDD13) | 22.1 | File URLs für JavaScript unterstützen die Direktiven [module], [defer] und [async] sowie Kommentare. Der Editor bietet dafür Syntaxhervorhebung und Autovervollständigung; die IE-spezifische Direktive entfällt. |
| [Add Workspace Static Files to Component Export](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-CFBA1F10-CF6B-4709-80F1-73C955D22045) | 22.1 | Statische Workspace-Dateien lassen sich über den Component Export exportieren. |
| [Subscription Support for Lists](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-2A4A2CF9-EAE3-4F8D-9816-6DD51AE88CF4) | 22.1 | Listen unterstützen wie andere Shared Components das Abonnieren. Anlegen, Kopieren und Bearbeiten von Listen wurde vereinfacht. |
| [Code Editor Enhancements](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-023EDFE4-77AA-441D-921D-FEDF7604B301) | 22.1 | Der Code-Editor kann Klammerpaare farbig hervorheben und markiert ungewöhnliche unsichtbare Zeichen. JavaScript aus Funktions- und Variablendeklarationen der Seite steht in allen JavaScript-Editoren für die Autovervollständigung bereit. |

<details>
<summary>Ältere Releases 21.2 – 18.1 (23 Einträge)</summary>

### Release 21.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Improved Editors](https://docs.oracle.com/en/database/oracle/application-express/21.2/htmrn/index.html#GUID-F6AFB9CF-122A-4767-AC5A-D0F5E2BD1009) | 21.2 | Statische Dateien lassen sich direkt im Browser anlegen und bearbeiten, mit automatischer Minifizierung und LESS-Kompilierung. Der Breadcrumb-Editor wurde verbessert, und SQL Commands verarbeitet Anweisungen über 32 KB. |
| [Additional Features](https://docs.oracle.com/en/database/oracle/application-express/21.2/htmrn/index.html#GUID-82D6B172-9B19-4F46-BF92-E808E92ED6B7) | 21.2 | Ein Data Packager nimmt Tabellendaten in den Anwendungsexport auf, und Popup LOVs setzen beim Wertsetzen automatisch den Anzeigewert. Dazu kommen ein „Show On“-Attribut für den Date Picker, ein Dialog-Ereignis für Abbruch und neue PL/SQL- und JavaScript-APIs. |
| [Data Package](https://docs.oracle.com/en/database/oracle/application-express/21.2/htmrn/index.html#GUID-921D2F6F-61D5-4B32-A9DA-ED3401C4C272) | 21.2 | Supporting Objects können als „Data Package“ Tabellendaten enthalten, die mit der Anwendung exportiert werden. Sicherheitsfunktionen wie Data Redaction, RAS oder VPD bleiben dabei erhalten. |
| [New Copyright Banner for Application Export](https://docs.oracle.com/en/database/oracle/application-express/21.2/htmrn/index.html#GUID-40DFD71D-1CA7-41C6-9C3F-E573D443530C) | 21.2 | Anwendungsexporte können ein Copyright-Banner enthalten, mit Substitutionen für Anwendungsname und Jahr. Bei ZIP-Exporten steht es in einer eigenen Datei copyright.txt. |

### Release 21.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Import Application Export as ZIP](https://docs.oracle.com/en/database/oracle/application-express/21.1/htmrn/index.html#GUID-17A760EF-21E5-4192-8577-5520E7483540) | 21.1 | Der App Builder importiert Anwendungsexporte im ZIP-Format. Das gilt auch für entpackte und neu gepackte Exporte sowie für Verzeichnisse aus APEXExport mit -split. |
| [Developer Experience](https://docs.oracle.com/en/database/oracle/application-express/21.1/htmrn/index.html#GUID-9F3040FA-9185-48FD-B0D9-4142919D7EBD) | 21.1 | Der Monaco-Code-Editor hat neue Optionen wie Minimap, Zeilennummern und dauerhaften Barrierefreiheitsmodus und markiert Verweise auf nicht existierende Items. Der Kalender unterstützt Lazy Loading und Faceted Search. |
| [Application and Page Checksum](https://docs.oracle.com/en/database/oracle/application-express/21.1/htmrn/index.html#GUID-8685CB2F-C5DD-45AF-AD2E-3F9CE99F05CD) | 21.1 | Für Anwendungen und Seiten werden Prüfsummen angezeigt. Damit lässt sich schnell erkennen, ob sich Deployments unterscheiden. |
| [Miscellaneous](https://docs.oracle.com/en/database/oracle/application-express/21.1/htmrn/index.html#GUID-DAB28AC4-8031-4ED7-8C98-511528DE0E11) | 21.1 | Interactive Grids unterstützen Zeilen mit variabler Höhe, und Number Fields formatieren automatisch und prüfen clientseitig. Dazu kommen ein Assistent für Spatial-Indizes und GeoJSON-Unterstützung in APEX_JSON und APEX_EXEC. |

### Release 20.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Developer Experience Enhancements](https://docs.oracle.com/en/database/oracle/application-express/20.2/htmrn/index.html#GUID-1CFB493D-912B-4EAD-8D2A-ADDD57B2BE1F) | 20.2 | Der Property Editor hat mehrere Tabs, und ein neuer Code-Editor bringt Autovervollständigung und Syntaxhervorhebung. Das Werkzeug „Embedded Code“ zeigt SQL, PL/SQL und JavaScript einer Anwendung für Reviews, und Quick SQL kann Modelle speichern. |

### Release 20.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Friendly URL Syntax](https://docs.oracle.com/en/database/oracle/application-express/20.1/htmrn/index.html#GUID-CE66ED04-77D8-4C40-BB67-A2E2905BDA1E) | 20.1 | Anwendungen unterstützen lesbare „Friendly URLs“ neben der alten f?p-Syntax. Neue Anwendungen nutzen sie standardmäßig, bestehende lassen sich in der Anwendungsdefinition umstellen. |
| [Remote Application Deployment](https://docs.oracle.com/en/database/oracle/application-express/20.1/htmrn/index.html#GUID-3EAFE2F5-5F30-4AD8-945E-5C4F4C1998C8) | 20.1 | Anwendungen lassen sich über REST Enabled SQL direkt auf entfernte APEX-Instanzen ausrollen. |
| [Split Export Files into Separate Scripts](https://docs.oracle.com/en/database/oracle/application-express/20.1/htmrn/index.html#GUID-0D1C1072-50FA-4094-9D71-71FB97D32266) | 20.1 | Exporte von Anwendungen, Seiten und Komponenten lassen sich als ZIP mit getrennten Skriptdateien erzeugen. Das erleichtert die Ablage in der Versionsverwaltung. |
| [Application Backups](https://docs.oracle.com/en/database/oracle/application-express/20.1/htmrn/index.html#GUID-BCEABA60-3529-441E-A9E2-EE05AAFE4705) | 20.1 | APEX sichert geänderte Anwendungen automatisch im Rahmen der täglichen Wartung. |

### Release 19.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [New Team Development](https://docs.oracle.com/en/database/oracle/application-express/19.2/htmrn/index.html#GUID-AE60ED3B-5D26-47F3-BDBB-679D21B7E6CB) | 19.2 | Das neue Team Development verwaltet Issues mit Labels, Vorlagen und Meilensteinen an einem Ort. Benutzer können Issues beobachten und sich in der App oder per E-Mail benachrichtigen lassen. |
| [Specify Default Debug Level from Runtime Developer Toolbar](https://docs.oracle.com/en/database/oracle/application-express/19.2/htmrn/index.html#GUID-4D06146C-834A-4E44-904D-566E3B69DE18) | 19.2 | In der Runtime Developer Toolbar lässt sich ein Standard-Debug-Level festlegen: Info, App Trace oder Full Trace. |
| [Debug Level in Runtime Developer Toolbar](https://docs.oracle.com/en/database/oracle/application-express/19.2/htmrn/index.html#GUID-9D0B3299-1463-465F-BE91-0877CAB49D9C) | 19.2 | Die Runtime Developer Toolbar merkt sich den Standard-Debug-Level. Er bleibt erhalten, wenn die Anwendung erneut aus dem App Builder gestartet wird. |

### Release 19.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Dark Mode (Entwicklungsumgebung)](https://docs.oracle.com/en/database/oracle/application-express/19.1/htmrn/index.html#GUID-FD424ED9-4441-4703-8650-994143647344) | 19.1 | Die Entwicklungsumgebung lässt sich in einem dunklen Farbschema anzeigen. |
| [Other Features and Changes](https://docs.oracle.com/en/database/oracle/application-express/19.1/htmrn/index.html#GUID-F9C819B6-27F9-4B6C-8630-0F75FD707786) | 19.1 | Interactive Grids und JET-Charts erhalten weitere deklarative Attribute, und am App Builder kann man sich per Social Sign-In anmelden. Dazu kommen REST-Aktivierung von Objekten im Object Browser und Erweiterungen von APEX_STRING. |

### Release 18.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Side by Side Master Detail](https://docs.oracle.com/en/database/oracle/application-express/18.2/htmrn/index.html#GUID-1FADEA90-8388-4C2E-A324-6F6D9ABC309A) | 18.2 | Eine neue Master-Detail-Seite zeigt links eine Master-Liste und rechts den gewählten Datensatz mit bis zu vier Detailberichten. Bearbeitet wird in modalen Fenstern. |
| [New Dashboard Page](https://docs.oracle.com/en/database/oracle/application-express/18.2/htmrn/index.html#GUID-153E74A3-3328-454E-A3A8-9D4CE344A951) | 18.2 | Der Create Page Wizard kann eine Dashboard-Seite mit Beispieldiagrammen anlegen. Verschiedene Diagramm-Layouts dienen als Ausgangspunkt. |
| [Sample Dataset Enhancements](https://docs.oracle.com/en/database/oracle/application-express/18.2/htmrn/index.html#GUID-E83A9207-720F-4169-8CDB-D1DC6AB6A4A2) | 18.2 | Nach Installation eines Beispieldatensatzes startet „Create Application“ den Assistenten mit passenden Komponenten. Der Datensatz EMP/DEPT ist in weiteren Sprachen verfügbar. |

### Release 18.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [New Create App Wizard](https://docs.oracle.com/database/apex-18.1/HTMRN/toc.htm#GUID-D9A17BE0-9D53-4480-8840-B6CE6C567D89) | 18.1 | Der Create App Wizard ist neu gestaltet und erzeugt Anwendungen schneller. Er bietet zuschaltbare Features wie Zugriffskontrolle oder Aktivitätsberichte sowie Optionen für Theme Style und Icons. |
| [Application Express Global Search](https://docs.oracle.com/database/apex-18.1/HTMRN/toc.htm#GUID-C7B80A82-B93D-4ED9-AA1D-DACE13AF221F) | 18.1 | Eine globale Suche (Strg + ') navigiert schnell durch App Builder, Anwendungen und Seiten. Sie funktioniert auch im Page Designer für Komponenten der aktuellen Seite. |

</details>

<sub>[↑ Kategorien](#kategorien)</sub>

## Security und Authentifizierung

### Release 26.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Deep Data Security Integration](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-9EE8D812-B0EE-447A-B037-15FC56757888) | 26.2 | APEX-Anwendungen können Oracle Deep Data Security aus Database 26ai nutzen, um den Datenzugriff direkt in der Datenbank zu erzwingen. Die Identität des angemeldeten Benutzers wird an die Datenbank durchgereicht, wo Data Roles und Data Grants für jedes SQL greifen. |
| [Support for Resource Principal Authentication in Web Service Calls](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-D80FAD48-713B-47E4-8FC8-B1FE5883B93C) | 26.2 | Ausgehende Web-Service-Aufrufe können sich per OCI Resource Principal authentifizieren, etwa gegenüber OCI Generative AI. API-Schlüssel müssen dafür nicht mehr angelegt, gespeichert und verwaltet werden. |
| [Workspace-Level Network Access Control](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-7E3227C2-F18E-4725-8DC9-68071EA02FE3) | 26.2 | Netzwerkzugriffe können je Workspace bzw. Schema über eigene ACLs gesteuert werden statt einheitlich für die ganze Instanz. Aktiviert wird das mit dem Instanzparameter WEBSERVICE_USE_SCHEMA_ACL; Legacy-SOAP-Aufrufe werden dann nicht unterstützt. |

### Release 26.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Specify OAuth at Invocation Level](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-1D4590B3-7F26-46B9-AD24-42061CB07938) | 26.1 | Bei OAuth2 Client Credentials kann der Token-Scope erst beim Aufruf festgelegt werden; fehlende Tokens holt APEX dann automatisch. Der Scope am Web Credential gilt nur noch als Standard, REST Data Sources und PL/SQL-APIs erhalten dafür eigene Attribute. |
| [OAuth2 Enhancements](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-6597DEC9-CECF-41E8-A614-D97F68E6FD73) | 26.1 | Der Client-Credentials-Flow unterstützt Refresh Tokens, und mit „OAuth2 Password Flow“ gibt es einen neuen Credential-Typ. Über „Token Authentication Method“ wird festgelegt, wie Client-ID und Secret an den Token-Server gehen. |
| [Support for Client and User Assertions for Token Requests](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-5F3EE759-E997-41E7-9CE2-59B1A76FFA33) | 26.1 | Das OAuth-Authentifizierungsschema kann signierte Client- und User-Assertions erzeugen und damit Tokens anfordern. Der OAuth-Client muss dafür beim Identity Provider als „Trusted“ statt „Confidential“ eingerichtet sein. |
| [Content Security Policy Support](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-22F281C6-E4E5-4E36-A71A-BBEED4694C0E) | 26.1 | APEX benötigt in der Content Security Policy weder unsafe-hashes noch unsafe-inline für die eigenen Kern-Skripte. Inline-Stile und -Skripte wurden durch Klassen, externe Dateien oder Nonces ersetzt; einige Drittbibliotheken wie MapLibre und CKEditor sind noch nicht voll kompatibel. |
| [Fusion Extensions Security Enhancements](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-5726CF75-D84F-4788-9713-516432FC2CC1) | 26.1 | Die Integration mit Fusion Applications zeigt Authentifizierungsdaten dynamisch an und übernimmt Gruppen und Rollen automatisch. Neue Seiten machen Benutzerdetails und Berechtigungen sichtbar. |
| [Allow Configuration of SMTP Credentials at Workspace Level](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-6B3E63D0-0494-4BC6-A833-0E4A439363BE) | 26.1 | SMTP-Zugangsdaten für den E-Mail-Versand lassen sich je Workspace statt nur für die ganze Instanz konfigurieren. Die Einstellung liegt in den Workspace Preferences. |

### Release 24.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Improved Content-Security-Policy Support](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-E0C771FA-F772-48DF-B873-A831035055CB) | 24.2 | Die APEX-Laufzeit verzichtet weitgehend auf unsafe-inline in der Content Security Policy. Inline-JavaScript und -CSS wurden in externe Dateien verlagert oder werden mit einer Nonce ausgegeben. |

### Release 24.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Multi-Domain Support for SAML Authentication](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-B0F660CB-A36A-44D6-8B38-5894A50F3B98) | 24.1 | Die SAML-Authentifizierung unterstützt das Attribut AssertionConsumerServiceIndex. Damit lassen sich SAML-Callbacks für mehrere Domains einrichten. |
| [Support for Database Credentials](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-A3DA4DE1-EE9B-4BAB-B936-DED13B8D1631) | 24.1 | Web Credentials vom Typ Basic Authentication oder OAuth2 Client Credentials können ein Database Credential für Client-ID und Secret verwenden. Die Geheimnisse verwaltet dann allein die Datenbank; nötig ist Database 23ai oder Autonomous Database ab 19c. |

### Release 23.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Multi-Tenant Authentication](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-704B2C20-A9EA-4F80-85F5-A1F1E4F1FB68) | 23.1 | Über das Attribut „Configuration Procedure“ lässt sich die Authentifizierung zur Laufzeit dynamisch konfigurieren. Die Prozedur kann pro Session etwa Schema-Name, Substitutionen und Tenant-ID festlegen. |

### Release 22.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Persistent Authentication](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-708FE0BD-7BA5-4157-A501-7B13D69806F1) | 22.1 | Mit Persistent Authentication bleiben Benutzer angemeldet, angeboten über eine „Remember Me“-Checkbox auf der Login-Seite. Die Funktion wird auf Instanzebene aktiviert; dauerhafte Anmeldungen lassen sich per API einzeln oder gesammelt widerrufen. |

<details>
<summary>Ältere Releases 21.2 – 18.1 (2 Einträge)</summary>

### Release 20.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [New Web Credential Types](https://docs.oracle.com/en/database/oracle/application-express/20.2/htmrn/index.html#GUID-4C17B10F-865E-42CF-8AC1-ABE3B3C654F1) | 20.2 | Web Credentials können Schlüssel auch als URL-Parameter oder HTTP-Header übergeben, ohne dass diese in Logs erscheinen. Ein URL-Muster beschränkt, für welche Adressen ein Credential verwendet werden darf. |

### Release 18.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Social Login](https://docs.oracle.com/database/apex-18.1/HTMRN/toc.htm#GUID-34617927-2EDF-49A8-BD73-9704E8EB15E8) | 18.1 | Das neue Authentifizierungsschema Social Login unterstützt Google, Facebook, OpenID Connect und OAuth2. Schemata können per „Switch in Session“ in der laufenden Session umgeschaltet werden. |

</details>

<sub>[↑ Kategorien](#kategorien)</sub>

## Reports, Grids und Suche

### Release 26.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Search Interactive Reports Using Key Phrases](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-F58E038C-2D6A-4A69-B17F-941F9511A73E) | 26.2 | Die Suchleiste von Interactive Reports versteht feste Schlüsselphrasen wie „filter status by …“ oder „sort by … descending“ und führt sie lokal ohne LLM aus. Das funktioniert in allen Interactive Reports, auch ohne aktivierte Natural-Language-Funktion. |
| [Translating Default Reports for Interactive Reports and Interactive Grids](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-FE5BB388-17D7-469F-8251-DEE2C0A3A9D1) | 26.2 | Die Metadaten gespeicherter Berichte von Interactive Reports und Interactive Grids lassen sich über Text Messages übersetzen. |

### Release 26.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Data Reporter](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-368C32BA-B5BB-4175-A294-E422C3DF7F3D) | 26.1 | Data Reporter ist ein neues Werkzeug neben App Builder und SQL Workshop für Ad-hoc-Berichte auf vordefinierten Datensätzen. Administratoren legen die Datensätze aus Workspace-Objekten an; die Berichte sind exportierbar, aber nicht im Page Designer bearbeitbar. |
| [Interactive Report Enhancements](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-A73F205F-F7A7-4154-BD4B-A0E37E515062) | 26.1 | Interactive-Report-Spalten erhalten CSS-Klassen, und „Maximum Rows to Display“ begrenzt die angezeigten Zeilen nach Anwendung aller Filter. Neu sind außerdem zeilenbasierte Auswahl mit Kopieren in die Zwischenablage und eine dynamische Aktion, die IR-Dialoge direkt öffnet. |
| [Copy and Paste for Interactive Grid](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-75B16F2B-1494-4457-9598-48EFC1FF7E82) | 26.1 | Editierbare Interactive Grids unterstützen Kopieren, Ausschneiden, Einfügen und Einfügen als neue Zeilen über die Zwischenablage. Auch Zellbereiche aus Tabellenkalkulationen lassen sich hineinziehen; nötig ist eine HTTPS-Verbindung. |
| ["Exclude" for Faceted Search and Smart Filters](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-14794462-59A6-45A1-8639-374B5AC1BE1A) | 26.1 | Facetten und Smart Filters vom Typ Checkbox Group, Radio Group oder Range haben eine Option „Exclude“. Damit filtert man auf alle Werte außer den ausgewählten. |
| ["Maximize" for Faceted Search Charts](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-9F86CCC2-647F-41E8-B0AF-2069FD8E6CD7) | 26.1 | Diagramme in Faceted Search lassen sich per Template Option maximieren und auf die volle Browserfläche vergrößern. „Restore“ stellt die normale Größe wieder her. |
| [Document Generator Support for Password-Protected PDFs](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-6CF677AB-CBA9-45B5-9785-606CD12336B6) | 26.1 | Der Document Generator kann passwortgeschützte PDFs erzeugen, mit festem Passwort oder aus einem Seitenelement. Neue GENERATE_DOCUMENT-Overloads können Vorlagen aus OCI Object Storage verwenden. |

### Release 24.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Vector Search](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-F997C6B9-4F7D-4BD2-9E86-2A56AF81CBCF) | 24.2 | Search Configurations können auf Tabellen mit VECTOR-Spalten aufsetzen und liefern Treffer nach Ähnlichkeit sortiert. Dafür ist ein Vector Provider auf Workspace-Ebene nötig, der Suchbegriffe in Vektoren umwandelt; verfügbar ab Database 23ai. |
| [Document Generator Enhancements](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-C7FA180B-3636-4861-936F-BF2AF0079876) | 24.2 | Ist der Document Generator als Druckserver eingerichtet, können auch XLSX-Vorlagen hochgeladen werden. Neue Ausgabearten sind DOCX zu DOCX, XLSX zu PDF und XLSX zu XLSX. |

### Release 24.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Document Generator Service Integration](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-7CFDE2B4-1180-46D9-86DB-B4A55330FB39) | 24.1 | Der OCI Document Generator ist als Druckserver-Typ integriert: Vorlagen werden in Word gestaltet und mit Anwendungsdaten zu PDF gerendert. Er unterstützt Report Layouts für Classic und Interactive Reports sowie den neuen Prozess „Print Report“; nötig ist eine Datenbank mit DBMS_CLOUD. |
| [Built-In Oracle Text Search Functions](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-DBFCEFB6-F66A-4D74-9188-17BC89DAEB20) | 24.1 | APEX_SEARCH erhält die Oracle-Text-Funktionen „Search Engine“ und „Expert Search“ für unscharfe Suche und Suche nach Wortnähe. Sie sind auch programmatisch über QUERY_SEARCH_ENGINE und QUERY_EXPERT_SEARCH nutzbar. |
| [Date Picker Support in Faceted Search and Smart Filters](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-68A82B8E-3C95-45B2-8056-33F386C1C467) | 24.1 | Eingabe-Facetten und manuelle Bereichseingaben in Faceted Search und Smart Filters bieten einen Date Picker. Das Datumsformat lässt sich per Format Mask festlegen. |
| [Alternative Labels for Interactive Reports](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-C0B4FB0E-43D3-43E1-A14D-D9D64D102F0B) | 24.1 | Spaltenüberschriften in Interactive Reports können ein alternatives Label erhalten. APEX verwendet es in Dialogen, wenn die eigentliche Überschrift HTML enthält, das dort nicht richtig angezeigt wird. |

### Release 23.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Faceted Search Enhancements](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-A55C833A-EDBE-426C-9C9D-EF2543500553) | 23.2 | Für LOV-basierte Facetten lässt sich die Sortierrichtung festlegen. Eingabe-Facetten erhalten zusätzliche Vergleichsoperatoren wie „ungleich“, „beginnt nicht mit“ und „enthält nicht“. |
| [Translate Default Reports](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-F70AC277-66B8-4903-9BA4-9C6E333F49BF) | 23.2 | Standardberichte von Interactive Reports und Interactive Grids lassen sich übersetzen. Die XLIFF-Datei enthält dafür unter anderem Berichts-, Filter- und Highlight-Namen sowie Achsenbeschriftungen. |
| [Ubiquitous Search](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-EA12436C-420A-457B-BAC7-F8CF0BF25C5D) | 23.2 | Search Configurations unterstützen den Suchtyp „Oracle Ubiquitous Search“ für die gleichnamige Funktion von Database 23ai. Damit lassen sich mehrere Schemaobjekte über einen einzigen DBMS_SEARCH-Index durchsuchen. |

### Release 22.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Application Search](https://docs.oracle.com/en/database/oracle/apex/22.2/htmrn/new-features.html#GUID-A5D384A6-4895-4C50-A2E9-A2363192261A) | 22.2 | Mit Search Configurations lässt sich deklarative Suche über lokale Tabellen, REST Enabled SQL oder externe REST-Quellen aufbauen, inklusive Oracle Text für linguistische und unscharfe Suche. Optionen wie Paginierung, Suche beim Tippen, Lazy Loading und Sortierung sind konfigurierbar. |
| [Support for Template Directives in Classic and Interactive Reports](https://docs.oracle.com/en/database/oracle/apex/22.2/htmrn/new-features.html#GUID-3CC84101-F550-461E-9569-1466EAD805FB) | 22.2 | Spalten mit HTML Expression in Classic und Interactive Reports unterstützen Template Directives. |

### Release 22.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Natural Search on Row Search](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-5C461D0E-F978-4A5C-96DF-0FD3869C3356) | 22.1 | Mit „Tokenize Row Search“ werden Suchbegriffe in Wörter zerlegt, die einzeln in beliebigen Spalten vorkommen dürfen. Für eine exakte Phrase setzt man den Suchbegriff in Anführungszeichen. |
| [New JavaScript Initialization Code Attribute](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-02E2D205-7D40-4C4B-B2BD-4E267169195C) | 22.1 | Faceted Search, Smart Filters und Cards haben das Attribut „JavaScript Initialization Code“. Damit lassen sich diese Regionen bei der Initialisierung gezielt anpassen. |
| [Plug-In Support for Faceted Search/Smart Filters](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-C34AD7DF-D111-418E-9C89-13F675A4970F) | 22.1 | Region-Plug-ins können mit Faceted Search und Smart Filters zusammenarbeiten. Die Region wird dann automatisch gefiltert und bei Filteränderungen aktualisiert. |

<details>
<summary>Ältere Releases 21.2 – 18.1 (18 Einträge)</summary>

### Release 21.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Smart Filters](https://docs.oracle.com/en/database/oracle/application-express/21.2/htmrn/index.html#GUID-B6D5B570-AADE-40B9-B02F-C08F8C494633) | 21.2 | Smart Filters ist eine neue Suchkomponente mit einer Suchleiste, die Filter per Autovervollständigung vorschlägt. Häufige Filter erscheinen als Chips unter der Suchleiste und grenzen die Daten mit einem Klick ein. |
| [Faceted Search Enhancements](https://docs.oracle.com/en/database/oracle/application-express/21.2/htmrn/index.html#GUID-FF619F90-B3FA-4C12-911E-970C03E18C41) | 21.2 | Faceted Search unterstützt mehrwertige Spalten als getrennte Zeichenkette oder JSON-Array. Facetten-Labels und Icons sind besser steuerbar, und die Barrierefreiheit wurde verbessert. |
| [Improved Report Downloads, Subscriptions, and Printing](https://docs.oracle.com/en/database/oracle/application-express/21.2/htmrn/index.html#GUID-949F7C36-B264-4B48-A7B5-5F850354DAE6) | 21.2 | Bildspalten werden in PDF-, XLSX- und HTML-Downloads eingebettet, und der Download-Dialog kann Rich Text entfernen. Interactive-Report-Abos unterstützen alle Formate und verschicken keine Mail mehr ohne Daten. |

### Release 21.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Additional Lazy Loading Support](https://docs.oracle.com/en/database/oracle/application-express/21.1/htmrn/index.html#GUID-E553D7A0-CEE0-4BC8-A680-6769F77F50A8) | 21.1 | Classic und Interactive Reports unterstützen Lazy Loading. Das beschleunigt den Seitenaufbau bei Berichten mit langsamen Abfragen. |
| [Faceted Search Enhancements](https://docs.oracle.com/en/database/oracle/application-express/21.1/htmrn/index.html#GUID-FF619F90-B3FA-4C12-911E-970C03E18C41) | 21.1 | Facetten und Facettengruppen können von Endanwendern ein- und ausgeblendet werden. Selten genutzte Facetten lassen sich so standardmäßig verstecken und bei Bedarf einblenden. |
| [Report Printing](https://docs.oracle.com/en/database/oracle/application-express/21.1/htmrn/index.html#GUID-2E7CB144-9632-490B-896C-BDA58D0BDA90) | 21.1 | Der PDF-Export unterstützt Sprachen mit komplexem Textlayout sowie Hebräisch und Arabisch. |

### Release 20.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Cards Region](https://docs.oracle.com/en/database/oracle/application-express/20.2/htmrn/index.html#GUID-BC8E3C11-2D01-4147-9FE7-64A3B3D046E4) | 20.2 | Die neue Cards-Region ist ein leichtgewichtiger Bericht, dessen Layout, Icons, Badges, Medien und Aktionen deklarativ gestaltet werden. Medien können aus BLOB-Spalten, URLs oder eingebetteten Videos kommen. |
| [Faceted Search Enhancements](https://docs.oracle.com/en/database/oracle/application-express/20.2/htmrn/index.html#GUID-D344A29D-401A-42A7-B925-4F2D575B5EBD) | 20.2 | Faceted Search kann Facettenwerte als Balken- oder Tortendiagramm zeigen und bietet Checkbox-Facetten für Boolean-Spalten. Eingabefacetten vergleichen frei eingegebene Werte, und Facetten mit unterschiedlichen Werten sind schneller. |
| [Report Printing](https://docs.oracle.com/en/database/oracle/application-express/20.2/htmrn/index.html#GUID-FA9A0717-5305-41B9-998F-1B278A537815) | 20.2 | Interactive Reports, Interactive Grids und Classic Reports können eingebaut als PDF und Excel exportiert werden, auch mit Chinesisch, Japanisch und Koreanisch. Neue APIs wie APEX_DATA_EXPORT erzeugen PDF, CSV, Excel, HTML, JSON und XML programmatisch. |
| [Interactive Grid Enhancements](https://docs.oracle.com/en/database/oracle/application-express/20.2/htmrn/index.html#GUID-DED3953A-6B1F-42F4-ADE6-76D29F29427A) | 20.2 | Links auf gespeicherte Interactive-Grid-Berichte verwenden deren Static ID statt des Namens. Auch die APEX_IG-API verlangt jetzt die Static ID. |

### Release 20.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Faceted Search](https://docs.oracle.com/en/database/oracle/application-express/20.1/htmrn/index.html#GUID-C061FD57-9E4F-4280-A134-CD80016E9874) | 20.1 | Faceted Search unterstützt kaskadierende LOVs, bedingte Facetten und kompakte Zählerangaben wie 1K. Dazu kommen eine Gesamtzeile und die Sortierung nach Trefferzahl. |
| [New Interactive Grid Editing with Control Breaks](https://docs.oracle.com/en/database/oracle/application-express/20.1/htmrn/index.html#GUID-2DD2204E-F1A4-431B-AE1A-7E0C7AB6D7B6) | 20.1 | Neue Datensätze in einem Interactive Grid mit Gruppenwechsel übernehmen die Werte der jeweiligen Gruppe. So landet die Zeile in der richtigen Gruppe, auch wenn die Gruppenspalte Pflicht ist. |
| [Interactive Grid Support for URL Filtering](https://docs.oracle.com/en/database/oracle/application-express/20.1/htmrn/index.html#GUID-65D71CA9-A71D-4F5A-AEDD-D7A54406ED6D) | 20.1 | Interactive Grids unterstützen das Filtern über URL-Parameter. |
| [Native PDF Printing for Interactive Grid](https://docs.oracle.com/en/database/oracle/application-express/20.1/htmrn/index.html#GUID-DFE49F55-9A5F-4A57-A617-8975856D810F) | 20.1 | Interactive Grids können direkt als PDF gedruckt werden. Die PDF-Datei übernimmt Formatierungen wie Hervorhebungen, Spaltengruppen und Gruppenwechsel. |

### Release 19.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Faceted Search](https://docs.oracle.com/en/database/oracle/application-express/19.2/htmrn/index.html#GUID-C061FD57-9E4F-4280-A134-CD80016E9874) | 19.2 | Eine neue Faceted-Search-Seite filtert Daten über Facetten und zeigt das Ergebnis als Bericht oder Karten. |
| [Interactive Grid Support of External Data Sources](https://docs.oracle.com/en/database/oracle/application-express/19.2/htmrn/index.html#GUID-D6EFED91-7CFB-4439-B9C3-FB83B1B6C471) | 19.2 | Interactive Grids können neben der lokalen Datenbank auch REST Enabled SQL oder Web Source Modules als Datenquelle nutzen. |
| [Report Supplemental Text Attribute](https://docs.oracle.com/en/database/oracle/application-express/19.2/htmrn/index.html#GUID-D72B1608-EAE4-4E68-8E98-5E10C78442B8) | 19.2 | Interactive Grids, Interactive Reports und Classic Reports haben ein Attribut „Supplemental Text“. Der Text erscheint oben in Downloads, etwa für Datenklassifizierung oder rechtliche Hinweise. |
| [Interactive Report supports Oracle Text indexes](https://docs.oracle.com/en/database/oracle/application-express/19.2/htmrn/index.html#GUID-1CEC5382-3745-44AE-894E-87F2CF1F4E05) | 19.2 | Die Zeilensuche in Interactive Reports nutzt Oracle-Text-Indizes, wenn eine entsprechende Indexspalte angegeben ist. Damit sind unscharfe oder linguistische Suchen möglich. |

</details>

<sub>[↑ Kategorien](#kategorien)</sub>

## Items, Formulare und Dynamic Actions

### Release 26.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Page Item Session State Data Type - BOOLEAN](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-3FEDC338-745A-4CE9-82C9-C539E088287E) | 26.1 | Checkbox-, Switch- und Hidden-Items können den Session-State-Datentyp BOOLEAN verwenden, passend zum SQL-Datentyp BOOLEAN ab Database 26ai. In PL/SQL und JavaScript werden dann echte Boolean-Werte verarbeitet; Assistenten bilden BOOLEAN-Spalten automatisch passend ab. |
| [New Dynamic Actions](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-647FF5DD-5B2A-4EA6-8986-6AD2FFD7243C) | 26.1 | Neue dynamische Aktionen zeigen Erfolgs- und Fehlermeldungen an oder entfernen angezeigte Fehler. JavaScript ist dafür nicht mehr nötig. |
| [Declarative Dynamic Action Support for Actions, Buttons, Cards, and Menus](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-6A0FA352-53BD-4858-BC22-E92A970C71DF) | 26.1 | Aktionen, Buttons, Cards und Menüs können über „Trigger Actions“ direkt im Page-Designer-Baum dynamische Aktionen auslösen. In mehrzeiligen Regionen sind dabei Spaltenwerte der jeweiligen Zeile verfügbar. |
| [Infinite Scroll for Select One, Select Many, Combobox, and Autocomplete](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-2221EFA4-30FA-4744-B183-0A4E2AFAB4E8) | 26.1 | Select One, Select Many, Combobox und Autocomplete laden weitere Ergebnisse beim Scrollen nach. So sind alle Treffer erreichbar, ohne an „Maximum Values in List“ gebunden zu sein. |
| [Copy and Paste for File Upload and Image Upload](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-BEA4162F-0345-44F9-884E-18BD17520082) | 26.1 | File-Upload- und Image-Upload-Items haben die Einstellung „Allow Copy and Paste“. Ist sie aktiv, können Dateien per Strg+V bzw. Cmd+V eingefügt werden. |
| [Quick Pick Enhancements](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-EEF248E2-7C8C-4972-B4A2-BACD2EBCC851) | 26.1 | Quick Picks von listenbasierten Items können statisch, dynamisch oder per SQL-Abfrage konfiguriert werden. Damit lassen sich die Schnellauswahlen dynamisch anzeigen. |
| [Declarative Menu Buttons](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-A10C26DB-1BB9-49F2-A8D4-2D1A74E6D4EB) | 26.1 | Buttons haben die Eigenschaften „Show as Disabled“ und „Type“. Damit werden Buttons bei falscher Bedingung deaktiviert statt ausgeblendet, und der Typ „Menu“ legt automatisch einen Menüeintrag im Rendering-Baum an. |
| [Show Processing for Execute Server-side Code](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-1972AE64-BB5C-48B6-99DC-13A11106F148) | 26.1 | Die dynamische Aktion „Execute Server-side Code“ hat die Option „Show Processing“. Bei lang laufendem PL/SQL zeigt APEX dann automatisch einen Lade-Spinner pro Item oder für die Seite. |

### Release 24.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Improved Popup LOV Functionality](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-674230EB-1B29-43D4-A03C-23DEC97F429E) | 24.2 | Popup LOVs verhalten sich wie andere durchsuchbare LOV-Items wie Select One oder Combobox. Neu sind die Optionen „Match Type“ (Contains oder Starts With) und Groß-/Kleinschreibung bei der Suche. |
| [Select Many Improvements](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-55A4A343-0845-459E-9290-E8839B842616) | 24.2 | Zeigt Select Many die Werte als kommagetrennte Liste, erscheint ein Zähler mit der Anzahl gewählter Werte. Ein Klick darauf öffnet die Auswahl mit nur den gewählten Werten. |

### Release 24.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [New Select One and Select Many Item Types](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-0A93BF0D-3304-4F8F-9B84-8003B28214A8) | 24.1 | Die neuen Item-Typen Select One und Select Many erlauben nur Werte aus der LOV, ähnlich wie Select Lists. Sie unterstützen eigenes HTML per Template Directives, Icons, Gruppen und mehrspaltige Suche; Select Many zusätzlich Chips und JSON-Session-State. |
| [Multi-Value Item Type JSON and Custom Separator Support](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-3365CA7B-6832-4600-82D4-D02028D3BC51) | 24.1 | Mehrwertige Items wie Shuttle, Select Many, Combobox oder Popup LOV können ihren Wert mit eigenem Trennzeichen oder als JSON-Array speichern. Plug-in-Entwickler können dieselbe Funktion in eigene Items einbauen. |
| [Declarative BLOB/CLOB File Download Support](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-8368AD40-3471-41F7-8991-37A86CC6EE0D) | 24.1 | Eine neue dynamische Aktion und ein Prozesstyp „Download“ laden BLOB- oder CLOB-Inhalte deklarativ herunter, mehrere Dateien auch als ZIP. Dateien können als Anhang oder direkt im Browser angezeigt werden. |
| [Dynamic Action Enhancements](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-A0A9BBF8-1239-42E9-923B-F4C08807C6CE) | 24.1 | Das neue Ereignis „Input“ feuert bei jeder Wertänderung, anders als „Change“, das erst beim Bestätigen auslöst. „Execute JavaScript Code“ und „Execute Server-side Code“ sind als Quick Picks verfügbar. |

### Release 23.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [New Combobox Item](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-80496973-A7B8-45A2-837B-A2C3D3F5222F) | 23.2 | Das neue Item Combobox erlaubt Einzel- oder Mehrfachauswahl, zeigt Mehrfachwerte als Chips und kann neue Einträge frei anlegen. Es unterstützt Template Directives, Icons, Gruppen und mehrspaltige Suche, aber noch nicht in Interactive Grids. |
| [New Image Upload Item](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-7B8E72C8-2128-41BF-B1EA-2E8FC56DE6A3) | 23.2 | Das neue Item Image Upload schneidet Bilder zu, verkleinert sie direkt auf dem Gerät und lädt sie hoch. Auf Mobilgeräten lässt sich die Haupt- oder Frontkamera wählen. |
| [New QR Code Item](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-7C624628-626C-48C6-A815-F0EC38908344) | 23.2 | Das neue Item QR Code erzeugt scannbare Codes mit Text, URL, Telefonnummer, E-Mail, SMS oder Standort. Über eine zugehörige API lassen sich QR-Codes auch in Berichte oder E-Mails einbetten. |
| [Improvements to Background Page Processing](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-B0BC4DBE-9A17-49EC-A4D3-20DCF588CBC9) | 23.2 | Hintergrundverarbeitung von Seitenprozessen erhält einen Kontextwert zur Serialisierung mehrerer Instanzen und eine bessere Fehlerbehandlung. Hintergrundausführungen können außerdem Teil der Haupttransaktion sein. |

### Release 23.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Page Processing Improvements](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-A034398A-140D-480E-B5EA-E481B817EBC3) | 23.1 | Der neue Prozesstyp „Execution Chain“ bündelt Seitenprozesse und führt sie nacheinander aus, im Vorder- oder Hintergrund. Hintergrundprozesse lassen sich in Active Sessions überwachen und per APEX_BACKGROUND_PROCESS mit Status und Fortschritt melden. |
| [New Color Picker](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-CD03EBDC-1E83-493C-8B9E-CDDFD2B23D7E) | 23.1 | Ein neuer Color Picker auf Web-Component-Basis lässt sich dynamisch erzeugen und zur Laufzeit umkonfigurieren. Er ersetzt den alten in Theme Roller, Page Designer und den Highlight-Dialogen von IR und IG. |

### Release 22.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Invoke API Process Type](https://docs.oracle.com/en/database/oracle/apex/22.2/htmrn/new-features.html#GUID-EE4860EB-5064-48FB-B4ED-CC35825E80D2) | 22.2 | Der Prozesstyp „Invoke API“ ruft Prozeduren und Funktionen ohne PL/SQL-Code auf. Parameter werden automatisch passenden Seitenelementen oder Grid-Spalten zugeordnet, alle PL/SQL-Datentypen einschließlich Records werden unterstützt. |
| [Page Item Session State Data Type - CLOB](https://docs.oracle.com/en/database/oracle/apex/22.2/htmrn/new-features.html#GUID-6C9F520F-6DF7-4425-B964-676268D49D05) | 22.2 | Page Items können neben VARCHAR2 den Session-State-Datentyp CLOB verwenden, etwa bei Textarea, Display Only, Hidden, Rich Text und Markdown Editor. Bestehende Items bleiben VARCHAR2 und müssen manuell umgestellt werden; es gelten einige Einschränkungen. |
| [Date Picker](https://docs.oracle.com/en/database/oracle/apex/22.2/htmrn/new-features.html#GUID-05555BB0-3894-4AD5-8F8B-258A27BDA001) | 22.2 | Der Date Picker ist von Grund auf neu für APEX gebaut und dadurch schneller, leichter und barrierearm. Neu sind ein Heute-Button und die Steuerung des Verhaltens über HTML-Attribute statt JavaScript. |
| [Number Page Item Enhancement](https://docs.oracle.com/en/database/oracle/apex/22.2/htmrn/new-features.html#GUID-8AFDF442-77B0-4190-9BDF-6B7F24485149) | 22.2 | Number-Items haben das Attribut „Virtual Keyboard“, das auf Mobilgeräten eine Text-, Ziffern- oder Dezimaltastatur einblendet. Neue Zahlenfelder sind standardmäßig linksbündig. |
| [Naming Actions of Dynamic Actions](https://docs.oracle.com/en/database/oracle/apex/22.2/htmrn/new-features.html#GUID-FC8E5836-DBE0-45DF-A520-0098B23348BC) | 22.2 | Aktionen innerhalb dynamischer Aktionen können eine eigene Beschreibung erhalten. Das verbessert die Selbstdokumentation im Page Designer. |
| [Debounce and Throttle Dynamic Actions](https://docs.oracle.com/en/database/oracle/apex/22.2/htmrn/new-features.html#GUID-0699A189-E092-419E-A414-354197DE5F56) | 22.2 | Dynamische Aktionen lassen sich entprellen (einmal nach einer Pause ausführen) oder drosseln (sofort und dann in Intervallen). Gesteuert wird das über Execution Type, Time und Immediate. |
| [Updated Rich Text Editor](https://docs.oracle.com/en/database/oracle/apex/22.2/htmrn/new-features.html#GUID-CCF92C24-1134-4BE6-8383-8ABABE8FAC95) | 22.2 | Der Rich Text Editor hat die Optionen „Toolbar Style“ (Overflow-Menü oder mehrzeilig) und „Allow Custom HTML“. Letztere erlaubt eigenes HTML wie in CKEditor4, Oracle empfiehlt sie aber nur bei Bedarf. |

### Release 22.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Region Sort Page Item](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-577FB0BC-10AE-4F37-833E-D1A7135856D3) | 22.1 | Der neue Item-Typ „Sort Order“ bietet Sortieroptionen für Regionen, die selbst keine Sortierung haben, etwa Cards. Die Region wird bei Änderung automatisch aktualisiert; der Create Page Wizard legt das Item oft gleich mit an. |
| [Markdown and Rich Text Enhancements](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-424F8D04-F2CF-4FB4-9E7C-A0C93C5A3CF7) | 22.1 | Markdown und Rich Text werden in allen Komponenten einheitlich dargestellt, und Interactive Grids können Rich Text auch schreibgeschützt anzeigen. Der Rich Text Editor nutzt CKEditor5 v32 mit HTML-Embed, apex_markdown.to_html akzeptiert CLOBs. |

<details>
<summary>Ältere Releases 21.2 – 18.1 (9 Einträge)</summary>

### Release 21.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Native Markdown Support](https://docs.oracle.com/en/database/oracle/application-express/21.1/htmrn/index.html#GUID-B1A8E8B9-DF08-47DC-8C72-9CDD5B98756D) | 21.1 | Die neue PL/SQL-API APEX_MARKDOWN wandelt Markdown nach CommonMark serverseitig in HTML um. Display-Only-Items und Berichtsspalten können Markdown formatiert anzeigen, die Spaltenart „Markdown“ heißt jetzt „Rich Text“. |
| [New Date Picker Item Type](https://docs.oracle.com/en/database/oracle/application-express/21.1/htmrn/index.html#GUID-9AC341C1-42BF-4FD1-8322-153A6187DF85) | 21.1 | Der neue Date Picker basiert auf Oracle JET und bietet Popup-, Inline- und native HTML-Darstellung, jeweils mit optionaler Uhrzeit. Minimal- und Maximaldaten können dynamisch sein, etwa für Von-bis-Bereiche. |
| [New Color Picker Item Type](https://docs.oracle.com/en/database/oracle/application-express/21.1/htmrn/index.html#GUID-6C75483D-3770-4E4E-B66A-8608F81B0836) | 21.1 | Der neue Color Picker auf Basis von Oracle JET bietet mehrere Darstellungsarten, Farbvorgaben aus dem Theme und eine optionale Kontrastprüfung. Der Wert kann als Hex, RGB(A), HSL(A) oder beliebiger CSS-Farbwert gespeichert werden. |

### Release 20.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Item Enhancements](https://docs.oracle.com/en/database/oracle/application-express/20.2/htmrn/index.html#GUID-A882E53A-B926-47E9-AEA1-0A65EB28FC91) | 20.2 | Ein neuer Typ Checkbox bildet einzelne Boolean-Werte ab, die bisherige Checkbox heißt jetzt Checkbox Group. File Browse unterstützt Drag-and-drop, der Rich Text Editor nutzt CKEditor 5 mit Markdown, und Text Field kann Groß-/Kleinschreibung umwandeln. |

### Release 19.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Expanded Shared LOVs](https://docs.oracle.com/en/database/oracle/application-express/19.2/htmrn/index.html#GUID-EF9CCF08-FEA1-4DC1-90AD-869E089FC1BF) | 19.2 | Shared LOVs unterstützen weitere Datenquellen, deklarative Spaltenzuordnung und mehrere Anzeigespalten. |
| [Enhanced Popup LOV](https://docs.oracle.com/en/database/oracle/application-express/19.2/htmrn/index.html#GUID-5F7ACB3A-E337-4099-AA18-B8394DC40508) | 19.2 | Popup LOVs zeigen mehrere Spalten, suchen beim Tippen und bieten eine bessere Mehrfachauswahl in vereinfachter Oberfläche. |

### Release 19.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Open Region and Close Region Dynamic Actions](https://docs.oracle.com/en/database/oracle/application-express/19.1/htmrn/index.html#GUID-4232A8A2-83FF-4D5E-90CB-35C5FE033B13) | 19.1 | Die neuen dynamischen Aktionen „Open Region“ und „Close Region“ öffnen und schließen Inline Popups, Inline Dialogs und einklappbare Regionen. |
| [New Form Region](https://docs.oracle.com/en/database/oracle/application-express/19.1/htmrn/index.html#GUID-088FFA60-EBA0-469F-91EA-3B6C2D29C935) | 19.1 | Die neue Form-Region hält ihre Datenquelle auf Regionsebene und unterstützt lokale, entfernte und REST-Quellen sowie mehr als zwei Primärschlüsselspalten. Alte Formularseiten lassen sich über „Upgrade Application“ automatisch migrieren. |

### Release 18.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Declarative Static List of Values](https://docs.oracle.com/en/database/oracle/application-express/18.2/htmrn/index.html#GUID-D3E13976-1CEC-4EFD-85BC-86626006D436) | 18.2 | Statische Listen von Werten (LOVs) lassen sich deklarativ im Page Designer anlegen. |

</details>

<sub>[↑ Kategorien](#kategorien)</sub>

## Charts, Maps und Kalender

### Release 26.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Lazy Loading for JET Charts](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-B06C63DA-FBD5-4DDC-A852-11061C46266E) | 26.2 | Eine neue Eigenschaft „Lazy Loading“ legt fest, ob Chart-Daten beim serverseitigen Rendern oder erst beim Sichtbarwerden der Region geladen werden. Für bestehende Anwendungen bleibt Lazy Loading aktiv; bei eigenen Sichtbarkeitssteuerungen kann sich die erste Anzeige verzögern. |
| [Improved Refreshes and Accessibility Improvements](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-1454D8F0-2EF7-42B7-97F8-D7D754950DE5) | 26.2 | Neue APIs starten, stoppen und setzen Refresh-Intervalle von Charts, und unnötige Verarbeitung bei Größen- und Sichtbarkeitsänderungen entfällt. Animationen bei Datenänderungen respektieren die Einstellung des Betriebssystems für reduzierte Bewegung. |

### Release 26.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Map Region Enhancements](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-CBD310DC-ED7B-4546-BB77-8D5F66C295D0) | 26.1 | Map-Regionen unterstützen dynamische Substitutionen für Füllung und Linien, eine begrenzende Bounding Box und eigene Legenden-Templates. Layer lassen sich per JavaScript ein- und ausblenden oder umsortieren, und Vector-Tile-Layer verbessern die Leistung bei großen Datenmengen. |

### Release 24.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Server Side Geocoding](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-434DAEA1-50C9-47DE-9E7C-2BF6041B2840) | 24.1 | Ein neuer Prozesstyp wandelt Postadressen serverseitig in Koordinaten um, unabhängig von der Oberfläche. Er ist auf Autonomous-Database-Instanzen verfügbar und in Seitenprozessen, Automations, Tasks und Workflows nutzbar. |

### Release 23.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Custom Map Backgrounds](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-18579B1A-748D-49F2-B6DE-0EB68C59979F) | 23.2 | Eigene Kartenhintergründe lassen sich als Shared Component anlegen, als Raster-, Vector- oder OGC-WMS-Tile-Layer. Sie sind in Map-Regionen und Karten-Items nutzbar und können wie andere Komponenten abonniert und veröffentlicht werden. |

### Release 22.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Vector-Based Map Support](https://docs.oracle.com/en/database/oracle/apex/22.2/htmrn/new-features.html#GUID-FDAB3A97-30FC-4F3E-BE39-D6E6FA89798C) | 22.2 | Map-Regionen unterstützen vektorbasierte Kartenkacheln mit drei OpenStreetMap-Stilen. Neue Anwendungen nutzen standardmäßig Vector Layer, bestehende können in den Component Settings umgestellt werden. |

<details>
<summary>Ältere Releases 21.2 – 18.1 (9 Einträge)</summary>

### Release 21.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Geocoding and Map Items](https://docs.oracle.com/en/database/oracle/application-express/21.2/htmrn/index.html#GUID-0FE8C1A9-1FCD-41D9-B266-F5B994948050) | 21.2 | Ein neues Item wandelt eingegebene Adressen per Geocoding in Koordinaten und normalisierte Adressen um, ohne API-Schlüssel. Das Item „Display Map“ zeigt einen einzelnen Punkt als kleine Karte. |

### Release 21.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Native Map Region Type](https://docs.oracle.com/en/database/oracle/application-express/21.1/htmrn/index.html#GUID-06E81168-001D-4B13-A6F1-4E0AF9AF775B) | 21.1 | Die native Map-Region zeigt Standortdaten als Punkte, Linien, Polygone, Heatmaps oder 3D-Polygone auf Hintergrundkarten ohne API-Schlüssel. Sie nutzt Oracle Spatial, GeoJSON oder Zahlenspalten aus lokalen oder REST-Quellen und unterstützt Faceted Search, Dynamic Actions und eine JavaScript-API. |
| [FullCalendar Upgraded to v5](https://docs.oracle.com/en/database/oracle/application-express/21.1/htmrn/index.html#GUID-093EFEAB-B0FF-465C-80B1-849093FD0531) | 21.1 | Die Kalender-Region unterstützt FullCalendar v5 neben v3, mit passenden Einstellungen im Page Designer. Google-Calendar-ID und REST-Webservice (JSON) sind in v5 nicht mehr verfügbar. |

### Release 19.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Charts and Library Upgrades](https://docs.oracle.com/en/database/oracle/application-express/19.1/htmrn/index.html#GUID-E8648DD9-C7C8-47EB-BC78-155BF9E99EC4) | 19.1 | Status-Gauge- und Gantt-Diagramme wurden verbessert, Gantt nutzt JET 6.1. Auch jQuery und jQuery Mobile wurden aktualisiert, und es gibt mehr Schriftoptionen. |
| [JET Chart Enhancements](https://docs.oracle.com/en/database/oracle/application-express/19.1/htmrn/index.html#GUID-8E21DE19-DCBF-4668-B2D1-3C2A31BA304F) | 19.1 | JET-Charts lassen sich bei Schriftart, -stil, -größe und -farbe für Titel, Legende und Achsen deklarativ gestalten. Gestapelte Diagramme unterstützen mehrere Stapel und die Anzeige von Summen. |

### Release 18.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Oracle JET Chart Types](https://docs.oracle.com/database/apex-18.1/HTMRN/toc.htm#GUID-3D0E0D99-99E9-484B-8923-4BEDB2A86EBE) | 18.1 | Neue JET-Diagrammtypen sind Pyramid, Box Plot und Gantt. Box Plots berechnen Quartile und Ausreißer automatisch aus Label- und Wertspalte. |
| [Interactive Report Charts](https://docs.oracle.com/database/apex-18.1/HTMRN/toc.htm#GUID-5072B362-FFDC-4D03-8D8A-10EB8801676E) | 18.1 | Diagramme in Interactive Reports basieren auf Oracle JET, mit Balken-, Linien-, Flächen- und Tortendiagrammen. Bestehende Diagramme werden automatisch umgestellt. |
| [Websheet Charts](https://docs.oracle.com/database/apex-18.1/HTMRN/toc.htm#GUID-C168FBEB-54F1-4A13-B6E4-A89B04CFD77E) | 18.1 | Diagramme in Websheets basieren auf Oracle JET, mit Balken-, Linien-, Flächen- und Tortendiagrammen. Bestehende Diagramme werden automatisch umgestellt. |
| [Oracle JET Chart Sorting](https://docs.oracle.com/database/apex-18.1/HTMRN/toc.htm#GUID-C1192771-A585-4E27-91C0-2ABFFED12357) | 18.1 | Das neue Chart-Attribut „Sort Order“ sortiert Diagrammdaten nach Wert oder Achsenbeschriftung, auf- oder absteigend. |

</details>

<sub>[↑ Kategorien](#kategorien)</sub>

## Universal Theme, UI und PWA

### Release 26.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Universal Theme Enhancements](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-846F567C-E003-4772-8808-DD0B08CCD74B) | 26.2 | Universal Theme 26.2 erweitert die Iris-Optionen in Theme Roller und benennt Redwood Light in „Redwood Light [Legacy]“ um. Dazu kommen mehr Design-Tokens, logische CSS-Eigenschaften für RTL sowie Verbesserungen an Layout, Barrierefreiheit und Ladeanimationen. |
| [APEX Utility CSS Framework Reference](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-9D8C53DD-6735-4D11-992C-7DA81E2836A0) | 26.2 | Ein neues tokenbasiertes Set von Utility-Klassen für Layout, Abstände und Größen wie u-flex oder u-padding-4 steht auf jeder Seite automatisch bereit. Es gibt Entwicklern und KI-Werkzeugen ein einheitliches Styling-Vokabular und reduziert individuelles CSS. |

### Release 26.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [List Entry Custom Link Attributes](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-8C20B6E3-1DCD-48B0-9A94-1F27145101D0) | 26.1 | Listeneinträge können eigene HTML-Attribute für ihre Links speichern und ausgeben. Statische Listen erhalten dafür ein Feld, dynamische Listen eine Spalte link_attributes. |
| [PWA Manifest Property Support](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-3F434F6C-0B3D-46DE-9A0F-172F2C17BC33) | 26.1 | APEX unterstützt zusätzliche PWA-Manifest-Eigenschaften wie short_name, handle_links, sizes und form_factor. Das verbessert die Installation in aktuellen Browsern. |
| [Template Directive Support for Theme Templates](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-3A8F5EF2-3740-4A2C-BEC1-F33A23001C5A) | 26.1 | Template Directives sind auch in Button-, Listen-, Item-, Regions- und Seiten-Templates von Themes nutzbar. Das vereinfacht die Pflege und erlaubt wiederverwendbare Partials. |
| [Client-side Template Component Partials](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-FA1DEE56-05B5-4791-868C-A3BAE8EEB5D7) | 26.1 | Template-Component-Partials lassen sich auch in clientseitig gerenderten Komponenten wie Combobox, Maps oder Interactive-Grid-Spalten verwenden. Benötigte CSS- und JavaScript-Dateien lädt APEX dabei automatisch nach. |
| [Universal Theme Enhancements](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-7627C002-63DE-4A4E-867E-93EA0B0ED84E) | 26.1 | Universal Theme bringt den neuen Standard-Theme-Style „Iris“ sowie neue Template Components wie Metric Card und Blank Page. Dazu kommen Gruppen für Avatar, Timeline, Comments und Media List, erweiterte Drawer und Dialoge sowie Font APEX 2.5 mit über 66 neuen Icons. |

### Release 24.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Control Breaks for Template Components](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-3FB702B3-C631-4957-AB15-9550682DF827) | 24.2 | Template-Component-Berichte unterstützen deklarative Gruppenwechsel im Page Designer. Gruppierung ist auch über APEX_EXEC und in der Content-Row-Komponente möglich. |
| [Default RTL Direction Based on Language](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-18ABA462-51C6-479A-A7FB-1969D3E906E8) | 24.2 | Die Schreibrichtung einer Anwendung steht standardmäßig auf „Language Default“ und wird damit aus der Sprache abgeleitet. Bestehende Anwendungen verhalten sich unverändert. |
| [Theme Metadata Decoupled from Application Metadata](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-F1E153BA-51E9-45D5-A93F-6323D03575DE) | 24.2 | Ab Universal Theme 24.2 liegen Theme-Metadaten zentral in einem Workspace statt in jeder Anwendung. Exporte werden dadurch kleiner und schneller; nach einem Theme-Refresh müssen Übersetzungen neu veröffentlicht werden. |
| [Universal Theme Enhancements](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-7627C002-63DE-4A4E-867E-93EA0B0ED84E) | 24.2 | Font APEX 2.4 bringt 244 Länderflaggen-Icons, und Passwortfelder haben standardmäßig einen Button zum Ein- und Ausblenden. Dazu kommen neue Utility-Klassen, Gruppierung in Content Row und mehrere Avatare. |

### Release 24.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Template Component Enhancements](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-014EFCED-A898-4160-8FC8-FB2085722131) | 24.1 | Positionen heißen jetzt Slots, und Regionen, Items und Buttons lassen sich auch in Slots von Template Components platzieren. Neu sind außerdem Auswahl in Template-Component-Berichten, Komponenten mit statischen Werten und schnelleres Rendern. |
| [Accessibility Improvements](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-EF1BA272-1D35-4A2D-8F1C-E52265AB05B6) | 24.1 | Die Hilfe im Page Designer enthält Hinweise zur Barrierefreiheit, etwa zu Alternativtexten, Kontrasten und Beschriftungen. Auch die Entwicklungsumgebung selbst wurde zugänglicher, und schreibgeschützte Items können als fokussierbare Felder dargestellt werden. |
| [Universal Theme Enhancements](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-7627C002-63DE-4A4E-867E-93EA0B0ED84E) | 24.1 | Universal Theme 24.1 unterstützt Content Security Policy besser: Inline-Event-Handler entfallen, und es gibt Substitutionen für Nonces und display:none. Klick-Handler von Buttons werden seitenweit registriert, das onclick-Attribut entfällt. |
| [Translation of Runtime Messages into Ukrainian and Vietnamese](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-03CC37FD-2BD7-42F0-88C7-B299AF8BD2ED) | 24.1 | Laufzeitmeldungen von APEX gibt es auch auf Ukrainisch und Vietnamesisch. Damit werden 34 Sprachen unterstützt. |
| [Automatic Dismissal of Success Messages](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-AF8BA5A4-7D98-465B-9FCA-6FF1406B5395) | 24.1 | Erfolgsmeldungen einer Anwendung lassen sich automatisch ausblenden. Steuerbar über ein Attribut in den UI-Einstellungen oder per apex.message.setDismissPreferences. |

### Release 23.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [More Attributes for Template Components](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-6C43044A-0464-4657-A293-D84F68FFB846) | 23.2 | Template-Component-Plug-ins sind nicht mehr auf 25 Attribute begrenzt. Die Attributwerte stehen in Dictionary Views in einer JSON-Spalte ATTRIBUTES statt in ATTRIBUTE_01 bis ATTRIBUTE_25. |
| [Populate List Item Subentries with List Reference](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-49A877C4-BDEC-40E2-ABB0-1B41161FE753) | 23.2 | Untereinträge einer statischen Liste können auf eine andere statische oder dynamische Liste verweisen, verschachtelt bis zu zehn Ebenen. Solche Verweise werden beim Kopieren, Abonnieren, Export und Import mitgeführt. |

### Release 23.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Template Components](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-8965DD94-D103-4203-A74B-4E1B8D59E86F) | 23.1 | Template Components sind ein neuer Plug-in-Typ für wiederverwendbare UI-Bausteine mit deklarativen Attributen, Aktionen und Menüs. Sie werden als eigene Region oder als Partial in Berichtsspalten dargestellt; Universal Theme liefert unter anderem Avatar, Badge, Comments und Timeline mit. |
| [PWA Push Notifications](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-C3BEC5DB-6345-4C03-96C9-F1C37A76E89F) | 23.1 | Push-Benachrichtigungen lassen sich per Schalter aktivieren, und Benutzer auf Desktop und Mobilgerät können sie abonnieren. Ein neuer Prozess und die API apex_pwa senden Nachrichten, die zurück in die Anwendung oder auf eine bestimmte Seite führen. |
| [Import and Export in Theme Roller](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-5160FD4B-3621-4B3A-8936-4E2CC67D9AE3) | 23.1 | Theme Styles lassen sich in Theme Roller als JSON importieren, exportieren oder zurücksetzen. Zwischen den Themes Vita und Redwood Light ist das nicht kompatibel. |
| [Region Display Selector Enhancements](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-29A3C228-5BFF-4C8B-A207-A87F95DB9335) | 23.1 | Der Region Display Selector kann Icons neben den Tab-Titeln zeigen und sich die letzte Auswahl merken. Mit APEX_REGION.RESET lässt sich die gespeicherte Auswahl zurücksetzen. |
| [Improved App Icon Fidelity](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-3A2FFCEE-21C9-4D9B-8CC1-F74A057C2958) | 23.1 | APEX erzeugt zusätzliche Icon-Dateien, damit PWAs auf Windows, macOS, Android und iOS gut aussehen. Ältere Anwendungen können die Icons über „Change Icon“ neu erzeugen. |
| [Translation of Runtime Messages into Icelandic](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-622939A5-8C31-4BD4-B78C-DA3F1DD3F4CF) | 23.1 | Laufzeitmeldungen von APEX gibt es auch auf Isländisch. Damit werden 32 Sprachen unterstützt. |

### Release 22.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [New Dynamic Content Region](https://docs.oracle.com/en/database/oracle/apex/22.2/htmrn/new-features.html#GUID-B55FE5BA-0F87-4A0D-A621-46817B1CFE78) | 22.2 | Die neue Region „Dynamic Content“ liefert HTML als CLOB statt über das HTP-Paket, ist aktualisierbar und unterstützt Lazy Loading sowie PL/SQL und JavaScript (MLE). Die alte PL/SQL-Dynamic-Content-Region gilt als Legacy und muss manuell umgestellt werden. |
| [Progressive Web App Enhancements](https://docs.oracle.com/en/database/oracle/apex/22.2/htmrn/new-features.html#GUID-CC29DE90-3004-4389-AD65-EB7917581593) | 22.2 | PWAs zeigen den Installations-Button nur noch, wenn Browser bzw. Gerät PWAs unterstützen. Neu sind Screenshots für den Installationsdialog, Shortcuts auf bestimmte Seiten sowie dynamische Aktionen für Standortabfrage und Teilen. |
| [Landmark Support for Regions](https://docs.oracle.com/en/database/oracle/apex/22.2/htmrn/new-features.html#GUID-98CFD3D3-8D02-4C16-A380-72DC4023014B) | 22.2 | Regionen steuern vollständig, wie sie für Screenreader als Landmark erscheinen, per Template-Standard oder seitenweitem Override. Die Developer Toolbar kann Landmarks und Überschriften anzeigen. |
| [Drawer Modal Dialog Template](https://docs.oracle.com/en/database/oracle/apex/22.2/htmrn/new-features.html#GUID-E2D7BC4E-931D-4170-8C59-5483D3372DD5) | 22.2 | Universal Theme bietet ein Drawer-Template für Modal-Dialog-Seiten, das von der Bildschirmseite einfährt. Neue Formularseiten aus den Assistenten werden standardmäßig als Drawer angelegt. |

### Release 22.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Customizing the PWA Service Worker](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-7AE4D7D7-8E9C-4A30-A2B8-6A9D1BCE66D5) | 22.1 | Der Service Worker von PWAs lässt sich mit eigenem Code erweitern, etwa für Push-Benachrichtigungen, Offline-Modus oder Hintergrundsynchronisation. PWA-Einstellungen haben eine eigene Seite in den Shared Components. |
| [Improved Region Images](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-0197F618-7FF7-49EC-8473-40E559994F77) | 22.1 | Ein neues Region-Template „Image“ zeigt reine Bildregionen mit Optionen für Filter, Seitenverhältnis und Skalierung ohne eigenes CSS. Die bisherigen Attribute Region Image und Image Tag Attributes sind veraltet. |
| [Application Icons](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-36C5A5FD-0215-45CB-B619-27DA78EB4EAE) | 22.1 | Anwendungs-Icons sind neu gestaltet: Ein eigenes Icon wird einmal hochgeladen und von APEX zur Laufzeit verwendet. Es lässt sich im Icon-Editor zuschneiden und auch über die Runtime Developer Toolbar bearbeiten. |

<details>
<summary>Ältere Releases 21.2 – 18.1 (18 Einträge)</summary>

### Release 21.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Progressive Web Apps](https://docs.oracle.com/en/database/oracle/application-express/21.2/htmrn/index.html#GUID-D5FD5B6E-53BF-48A3-A6CD-9114094B0D70) | 21.2 | Anwendungen lassen sich als Progressive Web App definieren, mit besserem Caching und schnelleren Ladezeiten. Sie können auf Smartphones installiert werden und haben eine anpassbare Offline-Seite. |
| [Universal Theme & UI Updates](https://docs.oracle.com/en/database/oracle/application-express/21.2/htmrn/index.html#GUID-377BC025-9373-48A2-AFCF-A31F188E57A2) | 21.2 | Page Templates bieten mehr Positionen für Komponenten, und Modal Dialogs können als seitlich einfahrende Drawer erscheinen. Dazu kommen bessere Barrierefreiheit, schnelleres Rendern und eine erweiterte Referenz-App mit Template-Option-Vorschau. |
| [Updated Alert and Confirm Dialogs](https://docs.oracle.com/en/database/oracle/application-express/21.2/htmrn/index.html#GUID-6417C65F-C7B1-4294-A6F8-EDB0638E4C26) | 21.2 | Alert- und Confirm-Dialoge haben ein neues Aussehen und lassen Stil, Titel, Icon und Button-Beschriftungen anpassen. Meldungen unterstützen Template Directives, und jeder Button kann per Schalter eine Bestätigung verlangen. |
| [Font APEX Enhancements](https://docs.oracle.com/en/database/oracle/application-express/21.2/htmrn/index.html#GUID-3517FC73-7CDF-4B61-91FD-9717F5A9DF8E) | 21.2 | Einige Font-APEX-Icons wurden umbenannt, etwa Varianten von file-json, location-arrow und map-marker. Außerdem wurden Tippfehler in Icon-Namen korrigiert. |

### Release 21.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Universal Theme Enhancements](https://docs.oracle.com/en/database/oracle/application-express/21.1/htmrn/index.html#GUID-B14943C7-18EC-4B4A-8CF7-AE582143F09E) | 21.1 | Der Theme Style Redwood Light ist näher am Redwood Design System. Regionen, Items und Buttons erhalten ein Attribut für Zeilen-CSS-Klassen, Theme Styles eines für Seiten-CSS-Klassen. |
| [Font APEX Icons](https://docs.oracle.com/en/database/oracle/application-express/21.1/htmrn/index.html#GUID-79FDC7EC-9120-47A6-8347-21463312E86E) | 21.1 | Font-APEX-Icons lassen sich auf einer eigenen Seite suchen und ansehen. |

### Release 20.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Redwood UI (Redwood Light Theme Style)](https://docs.oracle.com/en/database/oracle/application-express/20.2/htmrn/index.html#GUID-7BFDB1FE-D102-4881-ABCA-EA9835089134) | 20.2 | Universal Theme bietet den Theme Style „Redwood Light“ über Theme Roller. Bestehende Anwendungen erhalten ihn durch einen Theme-Refresh. |
| [Tree Region Enhancements](https://docs.oracle.com/en/database/oracle/application-express/20.2/htmrn/index.html#GUID-3433185C-223D-418A-B3D4-CC0DB421FCEE) | 20.2 | Tree-Regionen unterstützen Lazy Loading und lassen sich ohne Neuladen der Seite aktualisieren. |
| [Template Directives](https://docs.oracle.com/en/database/oracle/application-express/20.2/htmrn/index.html#GUID-97A9B666-C4BA-4515-84B8-9C4BEEF4B126) | 20.2 | Bestimmte Attribute, etwa in Cards und Interactive Grids, unterstützen Template Directives mit Bedingungen und Schleifen. Clientseitige Substitutionen können auch Eigenschaften von Spalten und Items wie Label oder Anzeigewert referenzieren. |

### Release 20.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Redwood UI](https://docs.oracle.com/en/database/oracle/application-express/20.1/htmrn/index.html#GUID-7BFDB1FE-D102-4881-ABCA-EA9835089134) | 20.1 | Die Oberfläche von APEX und App Builder ist an Redwood, Oracles neue Designsprache, angepasst. |
| [Universal Theme (Link Target Attribute)](https://docs.oracle.com/en/database/oracle/application-express/20.1/htmrn/index.html#GUID-6CFF2E68-0D2B-4D9F-A8D7-85873209D5B8) | 20.1 | Navigations-Listentemplates erhalten das Attribut Link Target. Damit lassen sich Links der oberen und seitlichen Navigation in einem neuen Fenster öffnen. |
| [Mega Menu Navigation](https://docs.oracle.com/en/database/oracle/application-express/20.1/htmrn/index.html#GUID-EC6F3E46-61B2-49D8-864E-CEB6973A9F50) | 20.1 | Universal Theme unterstützt Mega-Menü-Navigation als einklappbares Panel mit allen Navigationspunkten. Sie lässt sich im Create Application Wizard auswählen. |

### Release 19.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Universal Theme](https://docs.oracle.com/en/database/oracle/application-express/19.2/htmrn/index.html#GUID-6CFF2E68-0D2B-4D9F-A8D7-85873209D5B8) | 19.2 | Universal Theme bietet einen Dark Mode über den Theme Style „Vita - Dark“, eine vollständig einklappbare Navigation und neue Login-Layouts. Dazu kommen ein Content-Row-Template für Classic Reports und ein Logo-Editor in Theme Roller. |
| [Enhanced Application Logo](https://docs.oracle.com/en/database/oracle/application-express/19.2/htmrn/index.html#GUID-AF02817D-2736-4ED0-9304-B1F11D96DDAA) | 19.2 | Das Anwendungslogo kann ein Bild, Text, eine Kombination aus beidem oder eigenes HTML sein. |

### Release 19.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Region template Inline Pop-up](https://docs.oracle.com/en/database/oracle/application-express/19.1/htmrn/index.html#GUID-DFD8376D-7597-4193-B7C2-CAA60A06D590) | 19.1 | Universal Theme bietet ein Region-Template „Inline Popup“. Es zeigt Inhalte in einem Popup, das per dynamischer Aktion geöffnet wird. |
| [Universal Theme](https://docs.oracle.com/en/database/oracle/application-express/19.1/htmrn/index.html#GUID-6CFF2E68-0D2B-4D9F-A8D7-85873209D5B8) | 19.1 | Universal Theme bringt Verbesserungen bei Barrierefreiheit wie einen „Skip to Main Content“-Link, zwei neue Stile für das Navigationsmenü und ein Inline-Popup-Template. Dazu kommen optische Feinarbeiten und besseres Verhalten auf Mobilgeräten. |

### Release 18.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Updated Font APEX](https://docs.oracle.com/en/database/oracle/application-express/18.2/htmrn/index.html#GUID-DC878484-9B2C-491E-B39F-7FB735485639) | 18.2 | APEX nutzt Font APEX 2.1 mit Fehlerkorrekturen und neuen Icons in kleinen und großen Varianten. Marken-Icons sind nicht enthalten. |

### Release 18.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Updated Font APEX](https://docs.oracle.com/database/apex-18.1/HTMRN/toc.htm#GUID-DC878484-9B2C-491E-B39F-7FB735485639) | 18.1 | APEX nutzt Font APEX 2 mit kleinen (16×16) und großen (32×32) Icons und ersetzt damit Font Awesome 4.2.0. |

</details>

<sub>[↑ Kategorien](#kategorien)</sub>

## REST, Datenquellen und Daten-Import

### Release 26.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Enhanced Fusion Applications Starter App](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-B63CEBF2-3D22-49F5-9126-F1BDB2CF224C) | 26.2 | Die Starter-App für Fusion Applications unterstützt sowohl ADF- als auch BOSS-Scopes. Angepasst wurden dafür Authentifizierungsschema, Web Credentials, REST Data Sources und Anmeldelogik. |

### Release 26.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [REST Data Sources Dynamic Values](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-2DF885BE-C596-4E58-94F3-D8013C99C508) | 26.1 | Parameter von REST Data Sources können ihren Wert dynamisch erhalten. Zur Wahl stehen statische Werte, Seitenelemente, SQL-Abfragen sowie Ausdrücke oder Funktionen in PL/SQL oder JavaScript. |
| [Template Directive Support for REST Data Sources](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-746E6A85-D853-4A72-9351-6254C3AC1507) | 26.1 | Request-Body-Templates von REST-Operationen unterstützen Template Directives. Damit lassen sich JSON-Payloads mit bedingten Eigenschaften flexibel aufbauen; bestehende Templates funktionieren unverändert. |

### Release 24.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [JSON Sources](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-96526B18-0C95-408D-A398-C7E57E3C2CAB) | 24.2 | JSON Sources beschreiben eine Datenbanktabelle mit JSON-Spalten oder eine JSON Collection Table als Datenquelle. APEX leitet das Datenprofil aus den Daten oder einem JSON Schema ab; nutzbar in Berichten, Charts, Formularen, LOVs und Automations ab Database 19c. |
| [JSON Duality Views](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-FA70141F-6219-4AAB-91B7-39DC58AEB7C3) | 24.2 | JSON Duality Views lassen sich lokal oder über REST Enabled SQL als Datenquelle verwenden. APEX liest dafür das JSON Schema aus der Datenbank und bildet die Attribute auf Spalten ab; Voraussetzung ist Database 23ai. |
| [REST Source Enhancements](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-922C01C8-8B50-4BFB-86D9-0D416DC79995) | 24.2 | Simple-HTTP-REST-Data-Sources unterstützen tokenbasierte Paginierung. Remote Server können Platzhalter wie #tenant# in URL und Attributen verwenden, deren Werte eine PL/SQL-Konfigurationsprozedur zur Laufzeit liefert. |
| [Support for Fusion Integration](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-EFCDD231-7B9B-4D12-9155-851EFBF41F26) | 24.2 | Der Create Application Wizard kann eine Anwendung mit fertig eingerichteter Integration zu Oracle Fusion Applications erzeugen. Er legt Remote Server, Web Credential, Authentifizierungsschema und eine Beispiel-REST-Data-Source an; nötig ist eine OCI Database Tools Connection. |
| [BOSS REST Service Support](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-27F0B964-3132-4D1A-AE66-DFD3D6195416) | 24.2 | Fusion-Apps-REST-APIs mit /api/boss-URLs lassen sich in allen APEX-Regionen nutzen. APEX erkennt Operationen und Attribute automatisch, delegiert Filter und Sortierung an den Dienst und lädt nur benötigte Attribute. |

### Release 24.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Hierarchical JSON Support for REST Sources](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-9D347C71-B9E1-4BBF-858E-7F61BAD1293B) | 24.1 | REST-Source-Datenprofile können hierarchisches JSON über Array-Spalten abbilden. Komponenten können damit Daten auf jeder Ebene einer REST-Antwort nutzen, auch per APEX_EXEC. |
| [Improvements to REST Source Infrastructure](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-1DB10FAB-2423-4DB5-9F50-8A30D078CEB1) | 24.1 | Das neue Attribut „Is Common“ in Datenprofilen hilft dem Seitenassistenten, wichtige Attribute auszuwählen. Ein Detail-Interactive-Grid kann über den Parametertyp „Parent Column“ den Primärschlüssel des Master-Grids an eine REST-Quelle übergeben. |

### Release 23.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Improvements to REST Source Infrastructure](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-58B37AE0-5340-47CD-9AFB-54C230C798E5) | 23.2 | Parameter von REST Data Sources haben Datentypen und Prüfung per regulärem Ausdruck. Erkannte Spalten des Datenprofils lassen sich löschen, und ein Tab „Response Body“ zeigt die Struktur der Antwort. |
| [REST Source Catalogs from OpenAPI Documents](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-DEBD6DD5-5A79-4F2E-BD45-63C3F643ED2A) | 23.2 | APEX kann REST Source Catalogs aus OpenAPI-Dokumenten erzeugen. |
| [OData Connector as a Native REST Source Type](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-6DB03D89-3709-41C3-8356-152BFC2C76CE) | 23.2 | OData-REST-APIs, wie sie etwa SAP und Microsoft nutzen, werden als eigener REST-Source-Typ unterstützt. Derzeit nur lesend, schreibender Zugriff für Formulare und editierbare Grids ist geplant. |
| [Support for Fusion Apps Extensions](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-9E83467A-CEC5-40A1-A00A-067735D6CCF2) | 23.2 | REST Data Sources können Daten aus Fusion-Apps-REST-APIs lesen, anlegen, ändern und löschen. Sie nutzen Synchronisation, lokale SQL-Nachbearbeitung und übernehmen Filterung, Sortierung und Massenoperationen automatisch. |

### Release 23.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [REST Data Source Enhancements](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-877611CD-31D1-4E51-A2F8-216C46B27F64) | 23.1 | Der Prozess „Invoke API“ kann auch REST Data Sources aufrufen, mit neuen Parametertypen für Statuscode, Reason Phrase und Werte aus dem Datenprofil. REST-Quellen lassen sich zudem anhand von Swagger/OpenAPI-Beschreibungen erkennen. |
| [Property Graph Support](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-5370C60E-482E-4BB6-8342-BD24AE653F3F) | 23.1 | APEX-Komponenten, LOVs, Automations und Search Configurations können auf Property-Graph-Abfragen von Database 23ai aufsetzen. |

### Release 22.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [REST Sources (REST Enabled SQL Query)](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-1D9E3439-B5DD-41BF-8F04-33D96453460E) | 22.1 | Der neue REST-Source-Typ „REST Enabled SQL Query“ legt REST Sources über REST Enabled SQL an. Sie lassen sich für REST-Kataloge, Synchronisation oder zur Kapselung der SQL-Abfrage nutzen. |

<details>
<summary>Ältere Releases 21.2 – 18.1 (12 Einträge)</summary>

### Release 21.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [REST Catalogs and Improvements](https://docs.oracle.com/en/database/oracle/application-express/21.2/htmrn/index.html#GUID-C528F3EB-3887-4941-9FC5-BED7D146D3B6) | 21.2 | REST-Service-Kataloge enthalten Metadaten zu REST-Diensten, aus denen sich REST Data Sources anlegen lassen. Kataloge sind workspaceweit nutzbar, exportierbar und per URL aktualisierbar; Simple-HTTP-Quellen unterstützen Paginierung. |

### Release 21.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [New Application Data Loading](https://docs.oracle.com/en/database/oracle/application-express/21.1/htmrn/index.html#GUID-D2FE9163-AEE6-4C4D-A074-A1AA600BF3A6) | 21.1 | Eine neue Datenladefunktion importiert CSV, XLSX, XML und JSON in Tabellen oder Collections, mit Spaltenzuordnung zur Entwurfszeit. Es gibt Transformationsregeln, Append/Merge/Replace mit Fehlerbehandlung, einen Prozesstyp und die API APEX_DATA_LOADING. |
| [REST Data Sources (CSV Support)](https://docs.oracle.com/en/database/oracle/application-express/21.1/htmrn/index.html#GUID-AE1635EA-7E65-46F3-AA5C-95B107D2B59E) | 21.1 | REST Data Sources unterstützen CSV-Daten, auch per Synchronisation in lokale Tabellen. Daten lassen sich mit Transformationsregeln umwandeln, und ein Übersichtsbericht zeigt alle Synchronisationen. |

### Release 20.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [REST Data Source Synchronization](https://docs.oracle.com/en/database/oracle/application-express/20.2/htmrn/index.html#GUID-FF0E8042-AD6A-485B-822E-2B018CA3F2F4) | 20.2 | Daten aus REST Data Sources lassen sich nach Zeitplan oder auf Abruf in lokale Tabellen synchronisieren. APEX kann die Zieltabelle anlegen, Daten anhängen, zusammenführen oder ersetzen, und Komponenten können die lokale Tabelle nutzen. |
| [REST Data Source Connector Plug-Ins](https://docs.oracle.com/en/database/oracle/application-express/20.2/htmrn/index.html#GUID-694962A3-CC6E-4EC5-B16D-20FF92C4430B) | 20.2 | REST Data Sources können über Connector-Plug-ins an beliebige REST-APIs angebunden werden. Das Plug-in übernimmt dienstspezifische Details wie Paginierung und Filterübergabe. |
| [New Name for Web Source Modules](https://docs.oracle.com/en/database/oracle/application-express/20.2/htmrn/index.html#GUID-9D807CDC-118E-48E2-B973-F3A148466066) | 20.2 | Web Source Modules heißen jetzt REST Data Sources. |

### Release 19.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Data Loading into Existing Tables](https://docs.oracle.com/en/database/oracle/application-express/19.2/htmrn/index.html#GUID-6CF98529-6DBB-4C32-A177-6FF9273D9B6A) | 19.2 | Der Daten-Upload lädt Excel, CSV, XML und JSON auch in bestehende Tabellen. |
| [Interactive Report, Interactive Grid and Popup LOV searches can be passed to a REST service](https://docs.oracle.com/en/database/oracle/application-express/19.2/htmrn/index.html#GUID-AC045B74-D32A-41C2-A3A2-BBC0DB1CD05D) | 19.2 | Suchbegriffe aus Interactive Reports, Interactive Grids und Popup LOVs lassen sich an einen REST-Dienst weitergeben. Dafür wird bei einem Web-Source-Parameter „Use for Row Search“ aktiviert. |
| [Clob Column support in SQL Workshop Data Loading and APEX_DATA_PARSER](https://docs.oracle.com/en/database/oracle/application-express/19.2/htmrn/index.html#GUID-26998347-93B6-4DD7-808A-E1FC7B91E5BD) | 19.2 | Data Loading in SQL Workshop und das Paket APEX_DATA_PARSER unterstützen bis zu 20 CLOB-Spalten. |

### Release 19.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Data Loading](https://docs.oracle.com/en/database/oracle/application-express/19.1/htmrn/index.html#GUID-CE064C54-F237-421F-A8FC-6C957CCAA325) | 19.1 | Der Daten-Upload in SQL Workshop hat eine Drag-and-drop-Oberfläche und lädt Excel, CSV, XML und JSON, große Dateien im Hintergrund. Die neue API APEX_DATA_PARSER bietet erweiterte Parsing-Funktionen. |

### Release 18.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [REST Enabled SQL Support](https://docs.oracle.com/database/apex-18.1/HTMRN/toc.htm#GUID-331ADF9F-D798-48A1-8AB6-E543C6EEF8C5) | 18.1 | Über REST Enabled SQL lassen sich SQL und PL/SQL von APEX-Komponenten auf einer entfernten Oracle-Datenbank ausführen. Berichte, Charts und Kalender können entfernte Daten nutzen, auch per APEX_EXEC. |
| [REST Service Consumption](https://docs.oracle.com/database/apex-18.1/HTMRN/toc.htm#GUID-52FA8FCC-D1EF-4A23-AC28-FFFF32D2F1D7) | 18.1 | REST-Dienste lassen sich als Web Source Modules in den Shared Components einbinden, mit automatischer Erkennung des Datenprofils. Sie dienen als Datenquelle für Berichte, Charts und Kalender und sind per APEX_EXEC aufrufbar. |

</details>

<sub>[↑ Kategorien](#kategorien)</sub>

## Administration und Betrieb

### Release 26.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Enhanced Mail Queue Reporting](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-098369DE-A6EE-4758-96B9-4C9DCEEC2207) | 26.2 | Instanzadministratoren erhalten neue Kennzahlen zur Mail Queue, etwa zu Zustellstatus, Leistung, Fehlern und Nutzung je Workspace. Damit lassen sich Zustellprobleme schneller finden. |
| [Enhanced Manage Service Wizard](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-4C0962C4-B7B2-4636-B558-5C34FB1379D1) | 26.2 | Workspace-Administratoren können eine Erhöhung des Web-Service-Limits direkt im Manage-Service-Assistenten beantragen. Das vereinfacht und vereinheitlicht den Antragsweg. |

### Release 26.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Oracle BI Publisher Credentials Support](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-0FF7323E-84CF-4485-8C4C-852090994A98) | 26.1 | Für den Druckserver Oracle BI Publisher können Benutzername und Passwort hinterlegt werden. Die Einstellung erfolgt in der Instanzadministration unter Report Printing. |
| [Disabling External Links for an Instance](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-4C7F9230-EBE2-46DB-8636-795B236C1807) | 26.1 | Administratoren können Links von App Builder, SQL Workshop und anderen internen Anwendungen auf externe Seiten wie Doku oder Foren deaktivieren. Das ist vor allem für Umgebungen ohne Internetzugang gedacht. |
| [UI for APEX Install/Upgrade Logs](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-4CBA78BF-0046-4B99-89B9-5F2988B55F5A) | 26.1 | Ein neuer Bericht „Install / Upgrade Logs“ in den Administration Services zeigt Installation und Upgrade der APEX-Instanz. Er enthält alle Phasen, Warnungen und Fehler mit Drill-down bis zu einzelnen Schritten. |

### Release 24.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Application User Experience Data (OpenTelemetry)](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-8037EB13-18AE-4709-8A2E-4CDB2DC579E7) | 24.2 | Über OpenTelemetry lassen sich Nutzungsdaten wie Ladezeiten und Benutzerinteraktionen erfassen. Konfiguriert wird das in den Workspace Utilities und dann je Anwendung; nötig ist die aktuelle Universal-Theme-Version. |

### Release 24.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Define Maximum Emails Processed](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-AF89580D-C298-4614-A086-4E9664DF64F8) | 24.1 | Das Attribut „Maximum Emails Processed per Workspace“ begrenzt, wie viele E-Mails je Workspace pro Lauf des Mail-Queue-Jobs verarbeitet werden. |
| [Unified Privilege Management](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-828DBB65-B4FB-49AC-91DE-9869C0D01D44) | 24.1 | Beim Zuweisen eines Schemas zu einem Workspace kann man der Rolle APEX_GRANTS_FOR_NEW_USERS_ROLE entsprechende Rechte direkt mitvergeben. Dasselbe geht über einen Parameter von APEX_INSTANCE_ADMIN.ADD_SCHEMA. |

### Release 23.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [New Instance Parameters for APEX_INSTANCE_ADMIN](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-61CD2D9F-CEB9-40F6-A654-D04CD0665216) | 23.2 | APEX_INSTANCE_ADMIN erhält die Parameter RESTRICT_APPS_HEADER und DISABLE_APPS_LOGIN. Damit lässt sich der Zugriff auf Anwendungen über einen HTTP-Header einschränken oder die Anmeldung an allen bzw. bestimmten Anwendungen sperren. |
| [Store Static Resources in Oracle Cloud Object Storage](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-70B5D9C1-A2DF-4981-8C10-B69727267AA6) | 23.2 | Statische Anwendungsdateien wie Bilder, CSS und JavaScript können in Oracle Cloud Object Storage abgelegt werden. |

### Release 23.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Capture ECID in APEX Webservice Log](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-25199462-9DEC-4B4C-969C-DE397B172688) | 23.1 | Mit „Pass ECID“ wird die Execution Context ID an externe Web Services übergeben, um Aufrufe Ende-zu-Ende nachzuverfolgen. Die Einstellung lässt sich pro REST Data Source, per API oder bei der Installation überschreiben. |
| [Application Continuity](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-823C04C6-9E79-40C9-A805-719BE137BFCC) | 23.1 | Das Sicherheitsattribut „Session State Commit“ legt fest, ob Änderungen am Session State sofort oder erst am Ende des Requests festgeschrieben werden. Neue Anwendungen nutzen „End of Request“, bestehende „Immediate“. |
| [APEX Administrator Digest](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-210B2A99-C8D1-4B06-B934-C83271DCD728) | 23.1 | Das APEX Administrator Digest zeigt tägliche Kennzahlen und Trends zu Instanz, Workspaces und Schemas. Dazu gehören etwa angelegte Workspaces, Anmeldungen, Web-Service-Aufrufe, Scheduler-Jobs und Speicherbelegung. |
| [Auto-Provisioning Restrictions](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-07C0D72A-FCAE-42AC-8CCC-97F63728F2F5) | 23.1 | Instanzadministratoren können eine Sperrliste mit E-Mail-Mustern für die automatische Workspace-Bereitstellung pflegen. Passende Adressen werden dann abgewiesen; APEX_INSTANCE_ADMIN erhält dafür zwei neue Prozeduren. |
| [New Application Administration API Package](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-CF7439F0-3852-4CA9-A405-31B3B2054061) | 23.1 | Das neue Paket APEX_APPLICATION_ADMIN bündelt administrative APIs, teils aus APEX_UTIL übernommen. Es liest und setzt etwa Alias, Name, Status, Version, Authentifizierungsschema und Proxy-Server einer Anwendung. |

### Release 22.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Email Template Updates](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-DD330082-E598-418F-906F-60F6C032E586) | 22.1 | Bestimmte Attribute von E-Mail-Templates unterstützen Template Directives. |

<details>
<summary>Ältere Releases 21.2 – 18.1 (2 Einträge)</summary>

### Release 21.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Environment Setup (Environment Banner, SAML)](https://docs.oracle.com/en/database/oracle/application-express/21.2/htmrn/index.html#GUID-A9FE2F6F-429B-4704-AE39-54D3A28FD1E1) | 21.2 | Ein Environment Banner unterscheidet APEX-Umgebungen auf Instanz- oder Workspace-Ebene optisch. SAML wird als Authentifizierungsschema für die Entwicklungsumgebung und eigene Anwendungen unterstützt. |
| [Email and Email Template Enhancements](https://docs.oracle.com/en/database/oracle/application-express/21.2/htmrn/index.html#GUID-B96C92AF-F16B-4331-B8BC-73BB9506C8B1) | 21.2 | Der Prozess „Send Email“ unterstützt E-Mail-Templates und ist auch in Automations nutzbar. Templates lassen sich kopieren, und Bilder können als Inline-Anhang eingebettet werden. |

</details>

<sub>[↑ Kategorien](#kategorien)</sub>

## APIs und JavaScript-Bibliotheken

### Release 26.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [PL/SQL API Updates](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-39BC930D-5B8A-450D-AFEB-24E89BE1CF6C) | 26.2 | APEX_APPLICATION_ADMIN und APEX_APPLICATION_INSTALL erhalten Prozeduren für Deep Data Security, Supporting Objects, das Sperren von Anwendungen und Working Copies. Dazu kommen GROUPS_FROM_TOKEN in APEX_AUTHENTICATION, SET_TASK_OUTCOME in APEX_HUMAN_TASK, Data Roles in APEX_SESSION und MIGRATE_INSTANCE in APEX_WORKFLOW. |
| [JavaScript API Updates](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-5E4F1950-DACE-4D55-9505-C4570FC30C38) | 26.2 | Mit apex.region.multipleRefresh lassen sich Cards, Charts, Interactive Grids und Template-Component-Regionen in einem einzigen Ajax-Request aktualisieren. Neu sind außerdem die Klasse ForegroundTimer und eine eigene chartRegion-Schnittstelle, dazu kleinere Korrekturen an bestehenden APIs. |
| [JavaScript Library Upgrades](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-175489FB-CC24-40F6-89EF-A4A7AAFD7770) | 26.2 | Mitgelieferte Bibliotheken wurden aktualisiert, darunter JET 20.1.4, MapLibre GL 6.7.0, Monaco 0.56.0, FullCalendar 6.1.21 und DOMPurify 3.4.14. Auch die OpenTelemetry-Pakete, MarkedJS, Terser und Turndown sind auf neuen Versionen. |

### Release 26.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [PL/SQL API Updates](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-39BC930D-5B8A-450D-AFEB-24E89BE1CF6C) | 26.1 | Neu sind unter anderem APEX_HUMAN_TASK.REFRESH_BUSINESS_ADMINS, DELETE_TASKS für Workflows und Tasks sowie SET_TOOL_RESULT in APEX_AI. Die neuen Pakete APEX_INSTANCE_DEBUG und APEX_DB_DICTIONARY ergänzen Debug-Logs ohne SYS-Rechte und LLM-taugliche Tabellenbeschreibungen; APEX_SHARED_COMPONENT kann nun auch Themes aktualisieren. |
| [JavaScript API Updates](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-5E4F1950-DACE-4D55-9505-C4570FC30C38) | 26.1 | Neu ist die Schnittstelle interactiveReportRegion mit Auswahl- und Zeilenverwaltung, dazu Template-Funktionen in apex.util und Layer-Methoden für mapRegion. Das grid-Widget erhält erweiterte Funktionen für Zwischenablage und Bereichsauswahl, außerdem gibt es zahlreiche Verbesserungen für Barrierefreiheit. |
| [JavaScript Library Upgrades](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-175489FB-CC24-40F6-89EF-A4A7AAFD7770) | 26.1 | Mitgelieferte Bibliotheken wurden aktualisiert, darunter JET 20.0.2, jQuery 3.7.1, jQuery UI 1.14.1, MapLibre 5.6.1 und monaco-editor 0.55.1. Neu dabei sind die Schnittstellen-Spezifikationen für Anthropic, Google Gemini, Mistral AI und Ollama. |

### Release 24.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [PL/SQL API Updates](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-39BC930D-5B8A-450D-AFEB-24E89BE1CF6C) | 24.2 | Neu sind unter anderem APEX_APPLICATION_ADMIN.SET_REMOTE_SERVER, APEX_CREDENTIAL.SET_SCOPE und APEX_LANG.UPDATE_MESSAGE. APEX_PAGE.GET_URL kann absolute URLs erzeugen, APEX_REGION erhält GET_ID, und das neue Paket APEX_SHARED_COMPONENT bietet REFRESH und PUBLISH. |
| [JavaScript API Updates](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-5E4F1950-DACE-4D55-9505-C4570FC30C38) | 24.2 | Neue apex.message-Funktionen für Screenreader-Meldungen und eine neue Syntax für Text Messages in apex.util.applyTemplate (ab Compatibility Mode 24.2). facetsRegion, model und tableModelView wurden für den neuen Faceted-Search-Filter und verzögertes Leeren von Daten angepasst. |
| [JavaScript Library Upgrades](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-175489FB-CC24-40F6-89EF-A4A7AAFD7770) | 24.2 | Mitgelieferte Bibliotheken wurden aktualisiert, darunter JET 17.0.2, MapLibre GL 4.6.0, Monaco Editor 0.51.0, FullCalendar 6.1.15 und DOMPurify 3.1.6. Neu dabei sind die OpenTelemetry-Pakete sowie API-Spezifikationen für Cohere und OpenAI. |

### Release 24.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [PL/SQL API Updates](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-39BC930D-5B8A-450D-AFEB-24E89BE1CF6C) | 24.1 | APEX_AUTOMATION.TERMINATE ersetzt das veraltete ABORT, und APEX_EXEC.DESCRIBE_QUERY beschreibt Spalten einer Datenquelle. APEX_INSTANCE_ADMIN erhält Parameter zur Kontosperrung auf Runtime-Instanzen, und APEX_PLUGIN_UTIL.PRINT_READ_ONLY löst print_display_only ab. |
| [JavaScript API Updates](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-5E4F1950-DACE-4D55-9505-C4570FC30C38) | 24.1 | Neue Schnittstellen cardsRegion und templateReportRegion sowie Events für aktuelle Zeile und Auswahländerung. tableModelView und grid erhalten umfangreiche Auswahl-Optionen, und apex.message.setDismissPreferences steuert das Ausblenden von Meldungen. |
| [JavaScript Library Upgrades](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-175489FB-CC24-40F6-89EF-A4A7AAFD7770) | 24.1 | Mitgelieferte Bibliotheken wurden aktualisiert, darunter Oracle JET 16.0.1, Monaco Editor 0.47.0, TinyMCE 6.8.3, FullCalendar 6.1.11 und MapLibre 4.0.1. Auch DOMPurify, Marked.js, Less.js und Terser sind auf neuen Versionen. |

### Release 23.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [JavaScript API Updates](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-5E4F1950-DACE-4D55-9505-C4570FC30C38) | 23.2 | apex.util.escapeHTML liefert bei NULL einen Leerstring, und die Option lovValuesOptimization wurde entfernt. mapRegion erhält neue tileLayer-Eigenschaften, model.walkTree einen postNode-Callback, und das Löschen in Baummodellen verhält sich strenger. |
| [JavaScript Library Upgrades](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-175489FB-CC24-40F6-89EF-A4A7AAFD7770) | 23.2 | Mitgelieferte Bibliotheken wurden aktualisiert, darunter Oracle JET 15.0.7, TinyMCE 6.7.1, FullCalendar 6.1.8, DOMPurify 3.0.5 und Marked.js 5.1.2. Ab APEX 23.2.9 ist die Oracle Rich Text Library 1.0.2 enthalten. |

### Release 23.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [JavaScript API Updates](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-5E4F1950-DACE-4D55-9505-C4570FC30C38) | 23.1 | Neu sind die actions-Methode ariaKeyshortcut, Push-Subscription-Funktionen in apex.pwa und die model-Methode getDataOverflow. apex.message.alert und confirm erhalten Optionen der gleichnamigen dynamischen Aktionen, und apex.page.isChanged protokolliert geänderte Elemente. |
| [JavaScript Library Upgrades](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-175489FB-CC24-40F6-89EF-A4A7AAFD7770) | 23.1 | Mitgelieferte Bibliotheken wurden aktualisiert, darunter CKEditor5 36.0.0, JET 14.0.0, jQuery 3.6.4, MapLibre 2.4.0 und FullCalendar 5.11.3. Auch DOMPurify, MarkedJS, prism.js und Terser sind auf neuen Versionen. |

### Release 22.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [JavaScript API Updates](https://docs.oracle.com/en/database/oracle/apex/22.2/htmrn/new-features.html#GUID-5E4F1950-DACE-4D55-9505-C4570FC30C38) | 22.2 | Neu sind apex.util.throttle, der Parameter pImmediate für apex.util.debounce und pIgnoreUnsavedChanges für apex.navigation.redirect. Dazu kommen neue model-Events und die mapRegion-Eigenschaft useVectorTileLayers. |
| [PL/SQL API Updates](https://docs.oracle.com/en/database/oracle/apex/22.2/htmrn/new-features.html#GUID-39BC930D-5B8A-450D-AFEB-24E89BE1CF6C) | 22.2 | APEX_ESCAPE erhält die Funktionen csv und striphtml und unterstützt CLOB durchgängig. APEX_LDAP kann Zugangsdaten aus Web Credentials verwenden, statt sie im Code zu hinterlegen. |
| [JavaScript Library Upgrades](https://docs.oracle.com/en/database/oracle/apex/22.2/htmrn/new-features.html#GUID-175489FB-CC24-40F6-89EF-A4A7AAFD7770) | 22.2 | Mitgelieferte Bibliotheken wurden aktualisiert, darunter CKEditor 5.35.x, JET 12.1.3, jQuery UI 1.13.2, FullCalendar 5.11.2 und MapLibre 2.1.9. Auch DOMPurify, MarkedJS, prism.js und Terser sind auf neuen Versionen. |

### Release 22.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [JavaScript Library Upgrades](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-175489FB-CC24-40F6-89EF-A4A7AAFD7770) | 22.1 | Mitgelieferte Bibliotheken wurden aktualisiert, darunter Oracle JET 12.0.0, jQuery UI 1.13.1, CKEditor5 32.0.0, MarkedJS 4.0.12 und DOMPurify 2.3.1. Maps nutzen jetzt MapLibre 1.15.2 statt Mapbox. |
| [JavaScript API Updates](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-5E4F1950-DACE-4D55-9505-C4570FC30C38) | 22.1 | Actions lassen sich an Links binden und mit Kontext-ID und Argumenten aufrufen, auch aus menu und treeView. Neu sind unter anderem apex.model.multipleFetch, Methoden für ausgeblendete und deaktivierte Datensätze im model sowie apex.locale-Funktionen für Tages- und Monatsnamen. |
| [PL/SQL API Updates](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-39BC930D-5B8A-450D-AFEB-24E89BE1CF6C) | 22.1 | APEX_WEB_SERVICE erhält CLEAR_REQUEST_HEADERS und CLEAR_REQUEST_COOKIES zum Zurücksetzen von Headern und Cookies. APEX_STRING unterstützt CLOB-Arrays mit PUSH, SPLIT_CLOBS und JOIN_CLOBS. |

<details>
<summary>Ältere Releases 21.2 – 18.1 (14 Einträge)</summary>

### Release 21.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [JavaScript Library Upgrades](https://docs.oracle.com/en/database/oracle/application-express/21.2/htmrn/index.html#GUID-175489FB-CC24-40F6-89EF-A4A7AAFD7770) | 21.2 | Mitgelieferte Bibliotheken wurden aktualisiert: jQuery 3.6.0, MarkedJS 3.0.0, Oracle JET 11.0.0 und PrismJS 1.24.1. |
| [JavaScript (jsDoc) Updates](https://docs.oracle.com/en/database/oracle/application-express/21.2/htmrn/index.html#GUID-5E4F1950-DACE-4D55-9505-C4570FC30C38) | 21.2 | Neu sind die Namespaces apex.date und apex.pwa sowie Schnittstellen für colorPickerItem, facetsRegion, mapRegion und numberFieldItem. apex.util.applyTemplate erhält eine verbesserte if-Direktive, dazu kommen apex.items, apex.regions, apex.env und die Item-Methoden isReady und whenReady. |

### Release 21.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [JavaScript Library Upgrades](https://docs.oracle.com/en/database/oracle/application-express/21.1/htmrn/index.html#GUID-175489FB-CC24-40F6-89EF-A4A7AAFD7770) | 21.1 | Mitgelieferte Bibliotheken wurden aktualisiert, darunter Oracle JET 10.0.0, FullCalendar 5.5.1, CKEditor5 27.1.0 und Monaco Editor 0.22.3. Dazu kommen jQuery 3.5.1 und jQuery Migrate 3.3.2. |
| [New JavaScript APIs](https://docs.oracle.com/en/database/oracle/application-express/21.1/htmrn/index.html#GUID-9D3CA38B-3FDA-446E-9D73-15D141F09394) | 21.1 | Neu sind unter anderem apex.item.isItem, apex.locale.toNumber und getModel für mehrere Widgets. grid und tableModelView erhalten Optionen wie fixedRowHeight und virtuelle Paginierung, und apex.util.applyTemplate bevorzugt bei Ersetzungen Model-Spalten. |

### Release 20.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [JavaScript Library Upgrades](https://docs.oracle.com/en/database/oracle/application-express/20.2/htmrn/index.html#GUID-A5C02F23-1A64-4F2C-A18B-09612D995B2A) | 20.2 | Mitgelieferte Bibliotheken wurden aktualisiert: Oracle JET 9.1.0, jQuery 3.5.1, CKEditor 5 und Monaco Editor 0.20.0. |
| [New JavaScript APIs](https://docs.oracle.com/en/database/oracle/application-express/20.2/htmrn/index.html#GUID-9D3CA38B-3FDA-446E-9D73-15D141F09394) | 20.2 | Neu sind apex.item.addAttachHandler für Item-Plug-ins sowie apex.lang.loadMessages und loadMessagesIfNeeded. Model-Felder erhalten Metadaten wie dataType, calcValue und aggregates, tableModelView und grid neue Optionen für leere Footer und Paginierung. |

### Release 20.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [Oracle JET and Third Party Library Updates](https://docs.oracle.com/en/database/oracle/application-express/20.1/htmrn/index.html#GUID-D1915738-4EEB-42A0-99B0-4C7FAD4CA174) | 20.1 | Mitgelieferte Bibliotheken wurden aktualisiert: Oracle JET 8.0.0, jQuery 3.4.1, jQuery UI 1.12.1 und FullCalendar 3.10.0. |
| [New JavaScript APIs](https://docs.oracle.com/en/database/oracle/application-express/20.1/htmrn/index.html#GUID-9D3CA38B-3FDA-446E-9D73-15D141F09394) | 20.1 | Neu sind der Namespace apex.locale und die Funktionen apex.da.cancel und apex.theme.mq. Actions, menu und treeView können Links in einem neuen Fenster öffnen, und model.create erhält die Option requestOptions. |

### Release 19.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [New JavaScript APIs](https://docs.oracle.com/en/database/oracle/application-express/19.2/htmrn/index.html#GUID-9D3CA38B-3FDA-446E-9D73-15D141F09394) | 19.2 | Neue Tastennamen sowie apex.actions.getKeyCaps und setKeyCaps erweitern die Tastaturkürzel. grid, iconList, interactiveGridView, recordView und tableModelView erhalten neue Optionen und Methoden wie finishEditing. |
| [Oracle JET and jQuery Library Updates](https://docs.oracle.com/en/database/oracle/application-express/19.2/htmrn/index.html#GUID-D1915738-4EEB-42A0-99B0-4C7FAD4CA174) | 19.2 | Mitgelieferte Bibliotheken wurden aktualisiert: Oracle JET 7.2.0, jQuery 3.4.1, jQuery UI 1.12.1 und FullCalendar 3.3.10. |
| [New Callout and Popup Template Option APIs](https://docs.oracle.com/en/database/oracle/application-express/19.2/htmrn/index.html#GUID-801202D3-2367-4587-B69F-EB366BA7DEC7) | 19.2 | Zwei neue APIs für Template Options: die callout-Option und das popup-Widget. |

### Release 19.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [JavaScript API Documentation](https://docs.oracle.com/en/database/oracle/application-express/19.1/htmrn/index.html#GUID-9D3CA38B-3FDA-446E-9D73-15D141F09394) | 19.1 | Die JavaScript-API-Dokumentation zieht weiter in eine eigene Referenz um. Neu sind unter anderem apex.util.getNestedObject, Toolbar-Funktionen für interactiveGrid und die grid-Option cellCssClassesColumn. |

### Release 18.2

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [JavaScript API Documentation](https://docs.oracle.com/en/database/oracle/application-express/18.2/htmrn/index.html#GUID-9D3CA38B-3FDA-446E-9D73-15D141F09394) | 18.2 | Die JavaScript-APIs werden in eine eigene Referenz ausgelagert. Neu dokumentiert sind unter anderem die Widgets grid, interactiveGrid, menu, recordView und treeView. |

### Release 18.1

| Feature | Release | Zusammenfassung |
|:--|:-:|:--|
| [JavaScript API Documentation](https://docs.oracle.com/database/apex-18.1/HTMRN/toc.htm#GUID-9D3CA38B-3FDA-446E-9D73-15D141F09394) | 18.1 | Die JavaScript-APIs ziehen in eine eigene JavaScript API Reference um. Neu dokumentiert sind unter anderem menu, treeView, grid sowie apex.actions und apex.model. |

</details>

<sub>[↑ Kategorien](#kategorien)</sub>

## Quellen

| Release | New-Features-Seite der Release Notes | Einträge |
|:--|:--|--:|
| 26.2 | <https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html> | 30 |
| 26.1 | <https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html> | 65 |
| 24.2 | <https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html> | 31 |
| 24.1 | <https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html> | 34 |
| 23.2 | <https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html> | 29 |
| 23.1 | <https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html> | 24 |
| 22.2 | <https://docs.oracle.com/en/database/oracle/apex/22.2/htmrn/new-features.html> | 19 |
| 22.1 | <https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html> | 24 |
| 21.2 | <https://docs.oracle.com/en/database/oracle/application-express/21.2/htmrn/index.html> | 17 |
| 21.1 | <https://docs.oracle.com/en/database/oracle/application-express/21.1/htmrn/index.html> | 18 |
| 20.2 | <https://docs.oracle.com/en/database/oracle/application-express/20.2/htmrn/index.html> | 16 |
| 20.1 | <https://docs.oracle.com/en/database/oracle/application-express/20.1/htmrn/index.html> | 13 |
| 19.2 | <https://docs.oracle.com/en/database/oracle/application-express/19.2/htmrn/index.html> | 17 |
| 19.1 | <https://docs.oracle.com/en/database/oracle/application-express/19.1/htmrn/index.html#GUID-D6D545CB-3ECD-468A-9E7F-8CC09F7F478B> | 10 |
| 18.2 | <https://docs.oracle.com/en/database/oracle/application-express/18.2/htmrn/index.html#GUID-D6D545CB-3ECD-468A-9E7F-8CC09F7F478B> | 6 |
| 18.1 | <https://docs.oracle.com/database/apex-18.1/HTMRN/toc.htm#GUID-D6D545CB-3ECD-468A-9E7F-8CC09F7F478B> | 11 |

Bis 22.1 stehen die Release Notes auf einer einzigen Seite; ab 22.2 hat das Kapitel *New Features* eine eigene Seite. Die Zuordnung zu Kategorien ist eine eigene Einteilung und nicht Teil der Oracle-Doku.
