# Oracle APEX – New Features 18.1 bis 26.2

Übersicht aller Abschnitte aus den *New Features*-Kapiteln der Oracle APEX Release Notes, gruppiert nach Themen. Featurenamen stehen im englischen Original, damit die Browser-Suche (Strg+F / Cmd+F) dieselben Begriffe findet wie die Oracle-Doku. Jeder Name verlinkt direkt auf seinen Abschnitt in den Release Notes.

- **Stand:** 27.10.2026 · **Einträge:** 364 · **Releases:** 16 (ein Release 25.x gibt es nicht; auf 24.2 folgt 26.1)
- **Sichtbar:** Releases der letzten fünf Jahre (22.1 – 26.2), absteigend sortiert
- **Eingeklappt:** 18.1 – 21.2 je Kategorie unter *Ältere Releases*. Ob die Browser-Suche Treffer in eingeklappten Bereichen findet, hängt vom Browser ab – im Zweifel aufklappen.
- **Legende:** ✔ = neu in diesem Release · Kleingedruckt: Release und Abschnittsnummer in den Release Notes
- **Routine-Abschnitte** (PL/SQL API, JavaScript API, Bibliotheks-Upgrades) sind in 1–3 Sätzen zusammengefasst.

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

| Feature | 26.2 | 26.1 | 24.2 | 24.1 | 23.2 | 23.1 | 22.2 | 22.1 |
|:--|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| [Reasoning Effort for AI Agents](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-E3EC1EE4-8A4E-4CBE-9303-D5C170FA6DC9) <sub>26.2 · AI</sub> | ✔ |  |  |  |  |  |  |  |
| [New Provider API Setting for Generative AI Services](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-31C88C7A-697C-46D6-AA1B-8C61D73A3607) <sub>26.2 · AI</sub> | ✔ |  |  |  |  |  |  |  |
| [OCI Generative AI Service Settings](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-112154A3-8209-4129-A363-DCF87183818D) <sub>26.2 · AI</sub> | ✔ |  |  |  |  |  |  |  |
| [AI-Generated Navigation in Show AI Assistant](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-6AAA6EDC-D109-40FF-AFE4-B3BFEF064105) <sub>26.2 · AI</sub> | ✔ |  |  |  |  |  |  |  |
| [Computed Columns with Natural Language in Interactive Reports](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-4B21AEBB-7A81-4DB8-9ECD-9728E64C0AA8) <sub>26.2 · AI</sub> | ✔ |  |  |  |  |  |  |  |
| [Natural Language Support for Interactive Report](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-97FD585A-B2FE-4D83-8EC9-B014CFA94A4F) <sub>26.1 · 2.2.1</sub> |  | ✔ |  |  |  |  |  |  |
| [Create Page Using Natural Language](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-65875D64-78DE-48CF-B9AE-1AD535FBC62A) <sub>26.1 · 2.2.2</sub> |  | ✔ |  |  |  |  |  |  |
| [AI Agent Tools](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-D8D70E73-BF6C-4CF3-8B3A-B20C2463AA92) <sub>26.1 · 2.2.3</sub> |  | ✔ |  |  |  |  |  |  |
| [AI Tool Guardrails](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-D4DFB073-9A1D-4819-89BB-E223189FA7EA) <sub>26.1 · 2.2.4</sub> |  | ✔ |  |  |  |  |  |  |
| [Generate Text with AI Page Process](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-64E68A65-83E3-4E27-BB9B-6A93491E3360) <sub>26.1 · 2.2.5</sub> |  | ✔ |  |  |  |  |  |  |
| [AI-Generated Structured Outputs (JSON)](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-32B7FD4E-822A-4F31-995A-49629F46D05E) <sub>26.1 · 2.2.6</sub> |  | ✔ |  |  |  |  |  |  |
| [Generative AI Token Usage Limits](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-90A11DF5-356B-498D-8305-C0F4358265FA) <sub>26.1 · 2.2.7</sub> |  | ✔ |  |  |  |  |  |  |
| [Additional AI Provider Support](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-2BBD7696-4F50-4DEF-834A-0DA80D26DF57) <sub>26.1 · 2.2.8</sub> |  | ✔ |  |  |  |  |  |  |
| [AI Dynamic Action Enhancements](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-4378479C-E9E8-4D00-9B77-5894E56BDFB8) <sub>26.1 · 2.15.2</sub> |  | ✔ |  |  |  |  |  |  |
| [Blueprints](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-4DEE6D63-8818-419B-9111-769AF8661AD2) <sub>26.1 · 2.32</sub> |  | ✔ |  |  |  |  |  |  |
| [File Attachment Support for APEX_AI](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-D44EA632-F671-46CB-9AF7-B364E8843351) <sub>26.1 · 2.37.2</sub> |  | ✔ |  |  |  |  |  |  |
| [Dynamic Action: Generate Text with AI](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-3E6CC92E-A56C-4002-BC68-072A14D66D86) <sub>24.2 · 2.11</sub> |  |  | ✔ |  |  |  |  |  |
| [Create Custom Data Models Using AI](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-9BE115BE-5CFA-4A68-8FBB-3AFDCAD752FB) <sub>24.2 · 2.12</sub> |  |  | ✔ |  |  |  |  |  |
| [AI Configurations and RAG Sources](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-53C1F273-1F73-4E3F-BFC2-EDA2B1DABA93) <sub>24.2 · 2.13</sub> |  |  | ✔ |  |  |  |  |  |
| [Generative AI Configuration Screen Enhancements](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-3E75A967-82A2-42D5-8950-4B050B47507D) <sub>24.2 · 2.22</sub> |  |  | ✔ |  |  |  |  |  |
| [Generative AI Support](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-58986BEB-A222-4976-A48E-E364DAD38406) <sub>24.1 · 2.1</sub> |  |  |  | ✔ |  |  |  |  |

<sub>[↑ Kategorien](#kategorien)</sub>

## Workflow, Tasks und Automations

| Feature | 26.2 | 26.1 | 24.2 | 24.1 | 23.2 | 23.1 | 22.2 | 22.1 |
|:--|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| [Custom Outcomes for Action Tasks](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-6AB2FA91-A557-4F45-BB24-66A4C2955A42) <sub>26.2 · Workflow</sub> | ✔ |  |  |  |  |  |  |  |
| [Improved Task Error Handling](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-2AD4490E-4772-49FA-A2F6-E5C0F184E4D7) <sub>26.2 · Workflow</sub> | ✔ |  |  |  |  |  |  |  |
| [Draft Workflow Activities](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-F11BE282-E667-454E-A5D6-28364E325446) <sub>26.2 · Workflow</sub> | ✔ |  |  |  |  |  |  |  |
| [Workflow Diagram Export](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-6FDD8FBE-AA28-4A86-A6DC-87CBE303863F) <sub>26.2 · Workflow</sub> | ✔ |  |  |  |  |  |  |  |
| [Migrate Workflow Instances](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-B6648905-23B9-4C6F-9C3A-1F121C59C08F) <sub>26.2 · Workflow</sub> | ✔ |  |  |  |  |  |  |  |
| [Parallel Flow Support](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-CC52A11F-62F6-4264-B087-3EC84D39A202) <sub>26.1 · 2.4.1</sub> |  | ✔ |  |  |  |  |  |  |
| [Multi-Tenancy and Data Segregation](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-BA7BB84C-C72D-40B3-A008-73110585B77A) <sub>26.1 · 2.4.2</sub> |  | ✔ |  |  |  |  |  |  |
| [Other Workflow Enhancements](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-2ABE31DC-2B86-4EE3-B87F-4765F4FF208A) <sub>26.1 · 2.4.3</sub> |  | ✔ |  |  |  |  |  |  |
| [Other Task Enhancements](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-B30648E7-A783-4881-8E87-7AC3F8627BAC) <sub>26.1 · 2.4.4</sub> |  | ✔ |  |  |  |  |  |  |
| [Workflow Enhancements](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-2ABE31DC-2B86-4EE3-B87F-4765F4FF208A) <sub>24.2 · 2.5</sub> |  |  | ✔ |  |  |  |  |  |
| [Accessibility Improvements (Workflow Designer)](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-EF1BA272-1D35-4A2D-8F1C-E52265AB05B6) <sub>24.2 · 2.25</sub> |  |  | ✔ |  |  |  |  |  |
| [Workflow Enhancements](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-2ABE31DC-2B86-4EE3-B87F-4765F4FF208A) <sub>24.1 · 2.7</sub> |  |  |  | ✔ |  |  |  |  |
| [Human Task Enhancements](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-B30648E7-A783-4881-8E87-7AC3F8627BAC) <sub>24.1 · 2.8</sub> |  |  |  | ✔ |  |  |  |  |
| [New Workflow Feature](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-2CE1ABC5-2788-4118-BDF3-E48051A44DA4) <sub>23.2 · 2.2</sub> |  |  |  |  | ✔ |  |  |  |
| [Approvals Component Enhancements](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-99DA3745-2057-4E2B-92DD-9E22DA9D48C4) <sub>23.2 · 2.15</sub> |  |  |  |  | ✔ |  |  |  |
| [Action Tasks](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-89A4F2EE-7351-446D-BF88-CC99AA633EC9) <sub>23.2 · 2.16</sub> |  |  |  |  | ✔ |  |  |  |
| [Approvals Component Enhancements](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-99DA3745-2057-4E2B-92DD-9E22DA9D48C4) <sub>23.1 · 2.22</sub> |  |  |  |  |  | ✔ |  |  |
| [Approvals Functionality Updated](https://docs.oracle.com/en/database/oracle/apex/22.2/htmrn/new-features.html#GUID-08623B76-54F2-477E-BE45-DE466387EFAD) <sub>22.2 · 3.4</sub> |  |  |  |  |  |  | ✔ |  |
| [Approvals and Unified Task List](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-D427B40D-FB12-43F0-B311-6791913EE7EC) <sub>22.1 · 3.1.1</sub> |  |  |  |  |  |  |  | ✔ |

<details>
<summary>Ältere Releases 21.2 – 18.1 (1 Einträge)</summary>

| Feature | 21.2 | 21.1 | 20.2 | 20.1 | 19.2 | 19.1 | 18.2 | 18.1 |
|:--|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| [Automations](https://docs.oracle.com/en/database/oracle/application-express/20.2/htmrn/index.html#GUID-13F8ABFF-C240-49B1-B6E9-2EFA1512070D) <sub>20.2 · 3.1.2</sub> |  |  | ✔ |  |  |  |  |  |

</details>

<sub>[↑ Kategorien](#kategorien)</sub>

## Entwicklung und Lifecycle

| Feature | 26.2 | 26.1 | 24.2 | 24.1 | 23.2 | 23.1 | 22.2 | 22.1 |
|:--|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| [APEXlang Deployment Files](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-2B1C0CA8-EE71-4E99-B48C-16C56BB38E7A) <sub>26.2 · APEXlang</sub> | ✔ |  |  |  |  |  |  |  |
| [APEXlang APEX Upgrade Process](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-480F96D8-3AB4-4866-AA72-27A39EFC83FC) <sub>26.2 · APEXlang</sub> | ✔ |  |  |  |  |  |  |  |
| [File-Level Import with APEXlang](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-49ABFCF7-51D3-4E40-A8C6-5416C44DB1BE) <sub>26.2 · APEXlang</sub> | ✔ |  |  |  |  |  |  |  |
| [Subscription Mapping](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-9C5BCE28-1EF6-4E8C-A9DB-0E7AD8D01E56) <sub>26.2 · APEXlang</sub> | ✔ |  |  |  |  |  |  |  |
| [Application Locking and Working Copy APIs](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-3F6CCAA3-7694-4FCB-8500-9362F76056CE) <sub>26.2</sub> | ✔ |  |  |  |  |  |  |  |
| [APEXlang Features](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-C8176BD4-296C-4CAB-901E-A187DD964EAF) <sub>26.1 · 2.1.1</sub> |  | ✔ |  |  |  |  |  |  |
| [APEXlang Export and Import](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-6448C9B9-9CED-42D5-BD79-4025BE5CF9C5) <sub>26.1 · 2.1.2</sub> |  | ✔ |  |  |  |  |  |  |
| [APEXlang Name for Plug-ins](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-18187087-D740-4C95-8D63-C5916B1031BA) <sub>26.1 · 2.1.3</sub> |  | ✔ |  |  |  |  |  |  |
| [Static ID Added](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-CA0162F5-B44C-417F-9CE9-E4FA5C2CE6CB) <sub>26.1 · 2.1.4</sub> |  | ✔ |  |  |  |  |  |  |
| [New Application Types](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-CE2FFDE2-5C6B-4D6C-8AF2-BBEC16899828) <sub>26.1 · 2.9</sub> |  | ✔ |  |  |  |  |  |  |
| [Extension Menu Changes](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-12E44A23-1A63-4FC1-9BA8-9B0D0FEC559F) <sub>26.1 · 2.13</sub> |  | ✔ |  |  |  |  |  |  |
| [Unlimited Attributes: Authorization, Authentication, and REST Source Plug-ins](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-F9096BBD-9D3D-4399-9897-4242C77CAF92) <sub>26.1 · 2.16.1</sub> |  | ✔ |  |  |  |  |  |  |
| [Unlimited Attributes: Dynamic Action Plug-ins](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-7DDF76D4-0D86-4122-82AC-A41431DDC31C) <sub>26.1 · 2.16.2</sub> |  | ✔ |  |  |  |  |  |  |
| [Unlimited Attributes: Process Plug-ins](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-3F4C34F5-EE1A-4873-B5A9-DD4FD28209F2) <sub>26.1 · 2.16.3</sub> |  | ✔ |  |  |  |  |  |  |
| [Run Applications from Modal Dialog](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-72F64CF5-865E-4E8B-AB93-DE3A3E472EEC) <sub>26.1 · 2.19</sub> |  | ✔ |  |  |  |  |  |  |
| [Application Lock](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-81CE3725-46DE-41F0-BB1F-2183977ADCEC) <sub>26.1 · 2.20</sub> |  | ✔ |  |  |  |  |  |  |
| [Improved Authoring of Template Directives](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-DE4F720E-F028-470F-BCE4-C5EE5858F963) <sub>26.1 · 2.22.1</sub> |  | ✔ |  |  |  |  |  |  |
| [Sample Data Source](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-C3D0ED96-F60C-441B-9A9E-E8A0B0735BB9) <sub>26.1 · 2.23</sub> |  | ✔ |  |  |  |  |  |  |
| [New "Describe Tables" Feature](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-CBDA84FB-DCA8-4756-9CB7-EFB01D55C6D4) <sub>26.1 · 2.29</sub> |  | ✔ |  |  |  |  |  |  |
| [Text Message-Based Application Translations](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-6E5BC077-B6EF-448F-AA4D-3501387DC419) <sub>26.1 · 2.36</sub> |  | ✔ |  |  |  |  |  |  |
| [Subscription Mode](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-83B073E4-0805-4947-83F3-7C11164EC989) <sub>26.1 · 2.37.1</sub> |  | ✔ |  |  |  |  |  |  |
| [Database Object Dependencies](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-00978EEB-46D7-4212-96F9-F896DBB599A9) <sub>24.2 · 2.6</sub> |  |  | ✔ |  |  |  |  |  |
| [Shared Component Utilization Reports](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-18FA9E57-D095-430F-A49A-6F1103BECD94) <sub>24.2 · 2.7</sub> |  |  | ✔ |  |  |  |  |  |
| [Unlimited Attributes for Item Plug-ins](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-D165A54A-FA88-4BDD-B948-B9BB235FA1D6) <sub>24.2 · 2.15</sub> |  |  | ✔ |  |  |  |  |  |
| [Export App Enhancements](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-BD646581-6AFF-4906-AED7-DAF6EA5C1230) <sub>24.2 · 2.16</sub> |  |  | ✔ |  |  |  |  |  |
| [Builder Extension Auto-Subscribe](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-75F1FF14-3228-49EF-9DBC-C4943787580A) <sub>24.2 · 2.18</sub> |  |  | ✔ |  |  |  |  |  |
| [Text Messages Enhancements](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-734007F5-2156-464A-9CB6-F8EA1F108B66) <sub>24.2 · 2.19</sub> |  |  | ✔ |  |  |  |  |  |
| [New Substitution String (MAIN_APP_ID)](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-D3E8A453-C6B7-44DE-BC6C-3B09F1EEE4AB) <sub>24.2 · 2.20</sub> |  |  | ✔ |  |  |  |  |  |
| [Component Groups](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-D9726828-B633-4835-82AF-CD1181DE08AA) <sub>24.1 · 2.5</sub> |  |  |  | ✔ |  |  |  |  |
| [Unlimited Attributes for Regions](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-56A901E6-C321-4DC1-8C18-8CF99CB1C87C) <sub>24.1 · 2.6</sub> |  |  |  | ✔ |  |  |  |  |
| [Application Working Copy Enhancements](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-472AD1B8-AAA9-4826-B4D2-7EA3CF0157AC) <sub>24.1 · 2.9</sub> |  |  |  | ✔ |  |  |  |  |
| [App and Page Database Object Dependencies API](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-5937329A-2314-41FB-86DD-6C52566EBC95) <sub>24.1 · 2.16</sub> |  |  |  | ✔ |  |  |  |  |
| [Builder Extensions Enhancements](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-2ABC757F-F8D0-4A5A-9D75-2BA18F23E3A5) <sub>24.1 · 2.17</sub> |  |  |  | ✔ |  |  |  |  |
| [Improved Shared Component Subscriptions](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-C9C9F957-38FD-4152-8F9D-88E052B1FCDF) <sub>24.1 · 2.18</sub> |  |  |  | ✔ |  |  |  |  |
| [App Builder Enhancements](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-CC9BE1A7-1E8E-43D3-AA86-5A0C16F31035) <sub>24.1 · 2.19</sub> |  |  |  | ✔ |  |  |  |  |
| [Readable Export Enhancements](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-8387C4A5-475B-4206-8695-636EFC518096) <sub>24.1 · 2.24</sub> |  |  |  | ✔ |  |  |  |  |
| [Application Working Copies](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-F178C70F-87BD-4829-B0C1-94B82074C07C) <sub>23.2 · 2.1</sub> |  |  |  |  | ✔ |  |  |  |
| [Improved Shared Component Subscriptions](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-272076C2-0F6F-42D6-B9B0-CBD077F315EB) <sub>23.2 · 2.9</sub> |  |  |  |  | ✔ |  |  |  |
| [Quick SQL Updates](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-756088D0-CA53-472E-8E33-FD54D4363522) <sub>23.2 · 2.10</sub> |  |  |  |  | ✔ |  |  |  |
| [Simplified Create Application Wizard](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-3BD939A9-8373-47AD-8103-2CF3EE50B2EF) <sub>23.2 · 2.17</sub> |  |  |  |  | ✔ |  |  |  |
| [Simplified Application Export](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-3B88C62A-BAB6-4640-8F0D-2A08810076FC) <sub>23.2 · 2.18</sub> |  |  |  |  | ✔ |  |  |  |
| [Simplified Application Import](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-505767AC-ED9A-4733-86DA-6DC2CD2E31F6) <sub>23.2 · 2.19</sub> |  |  |  |  | ✔ |  |  |  |
| [EMP/DEPT Dataset Support in Arabic and Italian](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-2971E820-4346-4A4C-A342-9ED858ADA3B9) <sub>23.2 · 2.25</sub> |  |  |  |  | ✔ |  |  |  |
| [Utility Apps Available in Gallery](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-91B1E6CB-5F53-490D-837F-B3D9129EA1B9) <sub>23.2 · 2.27</sub> |  |  |  |  | ✔ |  |  |  |
| [Modernized Object Browser](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-0F8CDB25-2794-40A2-9F49-4B9C967876F3) <sub>23.1 · 2.3</sub> |  |  |  |  |  | ✔ |  |  |
| [SQL Developer Web Integration](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-554225E0-8F28-418E-8259-F947878CFD7B) <sub>23.1 · 2.7</sub> |  |  |  |  |  | ✔ |  |  |
| [Plug-In Attributes Updates](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-3424B670-9711-488E-8E0F-F41D98504F06) <sub>23.1 · 2.16</sub> |  |  |  |  |  | ✔ |  |  |
| [Save and Run Page from Code Editor](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-49744DBC-F068-4273-A719-E705EF30590F) <sub>23.1 · 2.19</sub> |  |  |  |  |  | ✔ |  |  |
| [Context-Sensitive APEX Help](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-2423D8B3-1425-4C77-806D-02DFAA5FFD29) <sub>23.1 · 2.20</sub> |  |  |  |  |  | ✔ |  |  |
| [Updated Global Search (Spotlight Search)](https://docs.oracle.com/en/database/oracle/apex/22.2/htmrn/new-features.html#GUID-ACCA7B5F-C528-4A49-962A-B5B9F02356CE) <sub>22.2 · 3.16</sub> |  |  |  |  |  |  | ✔ |  |
| [Simplified Page Creation](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-ACFC0463-368C-4CA2-8DE2-7F5F44810EE5) <sub>22.1 · 3.1.2</sub> |  |  |  |  |  |  |  | ✔ |
| [Export Application Metadata in JSON or YAML Format](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-620E7DC0-8DAC-4EFF-A303-47E727AD439E) <sub>22.1 · 3.1.3</sub> |  |  |  |  |  |  |  | ✔ |
| [Data Generator](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-3BE695CC-8768-4A24-999B-4F1CCF9F6B61) <sub>22.1 · 3.1.10</sub> |  |  |  |  |  |  |  | ✔ |
| [Effortless App Gallery Installs](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-9AC96132-8507-4475-A986-A00DEC968A20) <sub>22.1 · 3.1.12</sub> |  |  |  |  |  |  |  | ✔ |
| [Session Overrides](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-69F1D3F7-0792-4FFE-BF4D-8312AC9A256F) <sub>22.1 · 3.1.13</sub> |  |  |  |  |  |  |  | ✔ |
| [File URL Enhancements](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-86856169-2D43-452C-958F-AD263E9BDD13) <sub>22.1 · 3.1.14</sub> |  |  |  |  |  |  |  | ✔ |
| [Add Workspace Static Files to Component Export](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-CFBA1F10-CF6B-4709-80F1-73C955D22045) <sub>22.1 · 3.1.15</sub> |  |  |  |  |  |  |  | ✔ |
| [Subscription Support for Lists](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-2A4A2CF9-EAE3-4F8D-9816-6DD51AE88CF4) <sub>22.1 · 3.1.16</sub> |  |  |  |  |  |  |  | ✔ |
| [Code Editor Enhancements](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-023EDFE4-77AA-441D-921D-FEDF7604B301) <sub>22.1 · 3.1.18</sub> |  |  |  |  |  |  |  | ✔ |

<details>
<summary>Ältere Releases 21.2 – 18.1 (23 Einträge)</summary>

| Feature | 21.2 | 21.1 | 20.2 | 20.1 | 19.2 | 19.1 | 18.2 | 18.1 |
|:--|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| [Improved Editors](https://docs.oracle.com/en/database/oracle/application-express/21.2/htmrn/index.html#GUID-F6AFB9CF-122A-4767-AC5A-D0F5E2BD1009) <sub>21.2 · 3.1.9</sub> | ✔ |  |  |  |  |  |  |  |
| [Additional Features](https://docs.oracle.com/en/database/oracle/application-express/21.2/htmrn/index.html#GUID-82D6B172-9B19-4F46-BF92-E808E92ED6B7) <sub>21.2 · 3.1.12</sub> | ✔ |  |  |  |  |  |  |  |
| [Data Package](https://docs.oracle.com/en/database/oracle/application-express/21.2/htmrn/index.html#GUID-921D2F6F-61D5-4B32-A9DA-ED3401C4C272) <sub>21.2 · 3.1.15</sub> | ✔ |  |  |  |  |  |  |  |
| [New Copyright Banner for Application Export](https://docs.oracle.com/en/database/oracle/application-express/21.2/htmrn/index.html#GUID-40DFD71D-1CA7-41C6-9C3F-E573D443530C) <sub>21.2 · 3.1.17</sub> | ✔ |  |  |  |  |  |  |  |
| [Import Application Export as ZIP](https://docs.oracle.com/en/database/oracle/application-express/21.1/htmrn/index.html#GUID-17A760EF-21E5-4192-8577-5520E7483540) <sub>21.1 · 3.1.4</sub> |  | ✔ |  |  |  |  |  |  |
| [Developer Experience](https://docs.oracle.com/en/database/oracle/application-express/21.1/htmrn/index.html#GUID-9F3040FA-9185-48FD-B0D9-4142919D7EBD) <sub>21.1 · 3.1.12</sub> |  | ✔ |  |  |  |  |  |  |
| [Application and Page Checksum](https://docs.oracle.com/en/database/oracle/application-express/21.1/htmrn/index.html#GUID-8685CB2F-C5DD-45AF-AD2E-3F9CE99F05CD) <sub>21.1 · 3.1.14</sub> |  | ✔ |  |  |  |  |  |  |
| [Miscellaneous](https://docs.oracle.com/en/database/oracle/application-express/21.1/htmrn/index.html#GUID-DAB28AC4-8031-4ED7-8C98-511528DE0E11) <sub>21.1 · 3.1.18</sub> |  | ✔ |  |  |  |  |  |  |
| [Developer Experience Enhancements](https://docs.oracle.com/en/database/oracle/application-express/20.2/htmrn/index.html#GUID-1CFB493D-912B-4EAD-8D2A-ADDD57B2BE1F) <sub>20.2 · 3.1.9</sub> |  |  | ✔ |  |  |  |  |  |
| [Friendly URL Syntax](https://docs.oracle.com/en/database/oracle/application-express/20.1/htmrn/index.html#GUID-CE66ED04-77D8-4C40-BB67-A2E2905BDA1E) <sub>20.1 · 4.1.7</sub> |  |  |  | ✔ |  |  |  |  |
| [Remote Application Deployment](https://docs.oracle.com/en/database/oracle/application-express/20.1/htmrn/index.html#GUID-3EAFE2F5-5F30-4AD8-945E-5C4F4C1998C8) <sub>20.1 · 4.1.9</sub> |  |  |  | ✔ |  |  |  |  |
| [Split Export Files into Separate Scripts](https://docs.oracle.com/en/database/oracle/application-express/20.1/htmrn/index.html#GUID-0D1C1072-50FA-4094-9D71-71FB97D32266) <sub>20.1 · 4.1.10</sub> |  |  |  | ✔ |  |  |  |  |
| [Application Backups](https://docs.oracle.com/en/database/oracle/application-express/20.1/htmrn/index.html#GUID-BCEABA60-3529-441E-A9E2-EE05AAFE4705) <sub>20.1 · 4.1.12</sub> |  |  |  | ✔ |  |  |  |  |
| [New Team Development](https://docs.oracle.com/en/database/oracle/application-express/19.2/htmrn/index.html#GUID-AE60ED3B-5D26-47F3-BDBB-679D21B7E6CB) <sub>19.2 · 4.1.4</sub> |  |  |  |  | ✔ |  |  |  |
| [Specify Default Debug Level from Runtime Developer Toolbar](https://docs.oracle.com/en/database/oracle/application-express/19.2/htmrn/index.html#GUID-4D06146C-834A-4E44-904D-566E3B69DE18) <sub>19.2 · 4.1.7</sub> |  |  |  |  | ✔ |  |  |  |
| [Debug Level in Runtime Developer Toolbar](https://docs.oracle.com/en/database/oracle/application-express/19.2/htmrn/index.html#GUID-9D0B3299-1463-465F-BE91-0877CAB49D9C) <sub>19.2 · 4.1.16</sub> |  |  |  |  | ✔ |  |  |  |
| [Dark Mode (Entwicklungsumgebung)](https://docs.oracle.com/en/database/oracle/application-express/19.1/htmrn/index.html#GUID-FD424ED9-4441-4703-8650-994143647344) <sub>19.1 · 4.1.4</sub> |  |  |  |  |  | ✔ |  |  |
| [Other Features and Changes](https://docs.oracle.com/en/database/oracle/application-express/19.1/htmrn/index.html#GUID-F9C819B6-27F9-4B6C-8630-0F75FD707786) <sub>19.1 · 4.1.10</sub> |  |  |  |  |  | ✔ |  |  |
| [Side by Side Master Detail](https://docs.oracle.com/en/database/oracle/application-express/18.2/htmrn/index.html#GUID-1FADEA90-8388-4C2E-A324-6F6D9ABC309A) <sub>18.2 · 4.1.3</sub> |  |  |  |  |  |  | ✔ |  |
| [New Dashboard Page](https://docs.oracle.com/en/database/oracle/application-express/18.2/htmrn/index.html#GUID-153E74A3-3328-454E-A3A8-9D4CE344A951) <sub>18.2 · 4.1.4</sub> |  |  |  |  |  |  | ✔ |  |
| [Sample Dataset Enhancements](https://docs.oracle.com/en/database/oracle/application-express/18.2/htmrn/index.html#GUID-E83A9207-720F-4169-8CDB-D1DC6AB6A4A2) <sub>18.2 · 4.1.6</sub> |  |  |  |  |  |  | ✔ |  |
| [New Create App Wizard](https://docs.oracle.com/database/apex-18.1/HTMRN/toc.htm#GUID-D9A17BE0-9D53-4480-8840-B6CE6C567D89) <sub>18.1 · 4.1.5</sub> |  |  |  |  |  |  |  | ✔ |
| [Application Express Global Search](https://docs.oracle.com/database/apex-18.1/HTMRN/toc.htm#GUID-C7B80A82-B93D-4ED9-AA1D-DACE13AF221F) <sub>18.1 · 4.1.7</sub> |  |  |  |  |  |  |  | ✔ |

</details>

<sub>[↑ Kategorien](#kategorien)</sub>

## Security und Authentifizierung

| Feature | 26.2 | 26.1 | 24.2 | 24.1 | 23.2 | 23.1 | 22.2 | 22.1 |
|:--|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| [Deep Data Security Integration](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-9EE8D812-B0EE-447A-B037-15FC56757888) <sub>26.2 · Security</sub> | ✔ |  |  |  |  |  |  |  |
| [Support for Resource Principal Authentication in Web Service Calls](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-D80FAD48-713B-47E4-8FC8-B1FE5883B93C) <sub>26.2 · Security</sub> | ✔ |  |  |  |  |  |  |  |
| [Workspace-Level Network Access Control](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-7E3227C2-F18E-4725-8DC9-68071EA02FE3) <sub>26.2 · Security</sub> | ✔ |  |  |  |  |  |  |  |
| [Specify OAuth at Invocation Level](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-1D4590B3-7F26-46B9-AD24-42061CB07938) <sub>26.1 · 2.5.1</sub> |  | ✔ |  |  |  |  |  |  |
| [OAuth2 Enhancements](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-6597DEC9-CECF-41E8-A614-D97F68E6FD73) <sub>26.1 · 2.5.2</sub> |  | ✔ |  |  |  |  |  |  |
| [Support for Client and User Assertions for Token Requests](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-5F3EE759-E997-41E7-9CE2-59B1A76FFA33) <sub>26.1 · 2.5.3</sub> |  | ✔ |  |  |  |  |  |  |
| [Content Security Policy Support](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-22F281C6-E4E5-4E36-A71A-BBEED4694C0E) <sub>26.1 · 2.7.1</sub> |  | ✔ |  |  |  |  |  |  |
| [Fusion Extensions Security Enhancements](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-5726CF75-D84F-4788-9713-516432FC2CC1) <sub>26.1 · 2.7.2</sub> |  | ✔ |  |  |  |  |  |  |
| [Allow Configuration of SMTP Credentials at Workspace Level](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-6B3E63D0-0494-4BC6-A833-0E4A439363BE) <sub>26.1 · 2.7.3</sub> |  | ✔ |  |  |  |  |  |  |
| [Improved Content-Security-Policy Support](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-E0C771FA-F772-48DF-B873-A831035055CB) <sub>24.2 · 2.23</sub> |  |  | ✔ |  |  |  |  |  |
| [Multi-Domain Support for SAML Authentication](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-B0F660CB-A36A-44D6-8B38-5894A50F3B98) <sub>24.1 · 2.15</sub> |  |  |  | ✔ |  |  |  |  |
| [Support for Database Credentials](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-A3DA4DE1-EE9B-4BAB-B936-DED13B8D1631) <sub>24.1 · 2.23</sub> |  |  |  | ✔ |  |  |  |  |
| [Multi-Tenant Authentication](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-704B2C20-A9EA-4F80-85F5-A1F1E4F1FB68) <sub>23.1 · 2.21</sub> |  |  |  |  |  | ✔ |  |  |
| [Persistent Authentication](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-708FE0BD-7BA5-4157-A501-7B13D69806F1) <sub>22.1 · 3.1.8</sub> |  |  |  |  |  |  |  | ✔ |

<details>
<summary>Ältere Releases 21.2 – 18.1 (2 Einträge)</summary>

| Feature | 21.2 | 21.1 | 20.2 | 20.1 | 19.2 | 19.1 | 18.2 | 18.1 |
|:--|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| [New Web Credential Types](https://docs.oracle.com/en/database/oracle/application-express/20.2/htmrn/index.html#GUID-4C17B10F-865E-42CF-8AC1-ABE3B3C654F1) <sub>20.2 · 3.1.7</sub> |  |  | ✔ |  |  |  |  |  |
| [Social Login](https://docs.oracle.com/database/apex-18.1/HTMRN/toc.htm#GUID-34617927-2EDF-49A8-BD73-9704E8EB15E8) <sub>18.1 · 4.1.11</sub> |  |  |  |  |  |  |  | ✔ |

</details>

<sub>[↑ Kategorien](#kategorien)</sub>

## Reports, Grids und Suche

| Feature | 26.2 | 26.1 | 24.2 | 24.1 | 23.2 | 23.1 | 22.2 | 22.1 |
|:--|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| [Search Interactive Reports Using Key Phrases](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-F58E038C-2D6A-4A69-B17F-941F9511A73E) <sub>26.2 · AI</sub> | ✔ |  |  |  |  |  |  |  |
| [Translating Default Reports for Interactive Reports and Interactive Grids](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-FE5BB388-17D7-469F-8251-DEE2C0A3A9D1) <sub>26.2</sub> | ✔ |  |  |  |  |  |  |  |
| [Data Reporter](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-368C32BA-B5BB-4175-A294-E422C3DF7F3D) <sub>26.1 · 2.3</sub> |  | ✔ |  |  |  |  |  |  |
| [Interactive Report Enhancements](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-A73F205F-F7A7-4154-BD4B-A0E37E515062) <sub>26.1 · 2.8</sub> |  | ✔ |  |  |  |  |  |  |
| [Copy and Paste for Interactive Grid](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-75B16F2B-1494-4457-9598-48EFC1FF7E82) <sub>26.1 · 2.24</sub> |  | ✔ |  |  |  |  |  |  |
| ["Exclude" for Faceted Search and Smart Filters](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-14794462-59A6-45A1-8639-374B5AC1BE1A) <sub>26.1 · 2.26</sub> |  | ✔ |  |  |  |  |  |  |
| ["Maximize" for Faceted Search Charts](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-9F86CCC2-647F-41E8-B0AF-2069FD8E6CD7) <sub>26.1 · 2.27</sub> |  | ✔ |  |  |  |  |  |  |
| [Document Generator Support for Password-Protected PDFs](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-6CF677AB-CBA9-45B5-9785-606CD12336B6) <sub>26.1 · 2.31</sub> |  | ✔ |  |  |  |  |  |  |
| [Vector Search](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-F997C6B9-4F7D-4BD2-9E86-2A56AF81CBCF) <sub>24.2 · 2.3</sub> |  |  | ✔ |  |  |  |  |  |
| [Document Generator Enhancements](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-C7FA180B-3636-4861-936F-BF2AF0079876) <sub>24.2 · 2.10</sub> |  |  | ✔ |  |  |  |  |  |
| [Document Generator Service Integration](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-7CFDE2B4-1180-46D9-86DB-B4A55330FB39) <sub>24.1 · 2.2</sub> |  |  |  | ✔ |  |  |  |  |
| [Built-In Oracle Text Search Functions](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-DBFCEFB6-F66A-4D74-9188-17BC89DAEB20) <sub>24.1 · 2.11</sub> |  |  |  | ✔ |  |  |  |  |
| [Date Picker Support in Faceted Search and Smart Filters](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-68A82B8E-3C95-45B2-8056-33F386C1C467) <sub>24.1 · 2.13</sub> |  |  |  | ✔ |  |  |  |  |
| [Alternative Labels for Interactive Reports](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-C0B4FB0E-43D3-43E1-A14D-D9D64D102F0B) <sub>24.1 · 2.29</sub> |  |  |  | ✔ |  |  |  |  |
| [Faceted Search Enhancements](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-A55C833A-EDBE-426C-9C9D-EF2543500553) <sub>23.2 · 2.7</sub> |  |  |  |  | ✔ |  |  |  |
| [Translate Default Reports](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-F70AC277-66B8-4903-9BA4-9C6E333F49BF) <sub>23.2 · 2.22</sub> |  |  |  |  | ✔ |  |  |  |
| [Ubiquitous Search](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-EA12436C-420A-457B-BAC7-F8CF0BF25C5D) <sub>23.2 · 2.23</sub> |  |  |  |  | ✔ |  |  |  |
| [Application Search](https://docs.oracle.com/en/database/oracle/apex/22.2/htmrn/new-features.html#GUID-A5D384A6-4895-4C50-A2E9-A2363192261A) <sub>22.2 · 3.1</sub> |  |  |  |  |  |  | ✔ |  |
| [Support for Template Directives in Classic and Interactive Reports](https://docs.oracle.com/en/database/oracle/apex/22.2/htmrn/new-features.html#GUID-3CC84101-F550-461E-9569-1466EAD805FB) <sub>22.2 · 3.7</sub> |  |  |  |  |  |  | ✔ |  |
| [Natural Search on Row Search](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-5C461D0E-F978-4A5C-96DF-0FD3869C3356) <sub>22.1 · 3.1.4</sub> |  |  |  |  |  |  |  | ✔ |
| [New JavaScript Initialization Code Attribute](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-02E2D205-7D40-4C4B-B2BD-4E267169195C) <sub>22.1 · 3.1.19</sub> |  |  |  |  |  |  |  | ✔ |
| [Plug-In Support for Faceted Search/Smart Filters](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-C34AD7DF-D111-418E-9C89-13F675A4970F) <sub>22.1 · 3.1.20</sub> |  |  |  |  |  |  |  | ✔ |

<details>
<summary>Ältere Releases 21.2 – 18.1 (18 Einträge)</summary>

| Feature | 21.2 | 21.1 | 20.2 | 20.1 | 19.2 | 19.1 | 18.2 | 18.1 |
|:--|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| [Smart Filters](https://docs.oracle.com/en/database/oracle/application-express/21.2/htmrn/index.html#GUID-B6D5B570-AADE-40B9-B02F-C08F8C494633) <sub>21.2 · 3.1.1</sub> | ✔ |  |  |  |  |  |  |  |
| [Faceted Search Enhancements](https://docs.oracle.com/en/database/oracle/application-express/21.2/htmrn/index.html#GUID-FF619F90-B3FA-4C12-911E-970C03E18C41) <sub>21.2 · 3.1.4</sub> | ✔ |  |  |  |  |  |  |  |
| [Improved Report Downloads, Subscriptions, and Printing](https://docs.oracle.com/en/database/oracle/application-express/21.2/htmrn/index.html#GUID-949F7C36-B264-4B48-A7B5-5F850354DAE6) <sub>21.2 · 3.1.8</sub> | ✔ |  |  |  |  |  |  |  |
| [Additional Lazy Loading Support](https://docs.oracle.com/en/database/oracle/application-express/21.1/htmrn/index.html#GUID-E553D7A0-CEE0-4BC8-A680-6769F77F50A8) <sub>21.1 · 3.1.5</sub> |  | ✔ |  |  |  |  |  |  |
| [Faceted Search Enhancements](https://docs.oracle.com/en/database/oracle/application-express/21.1/htmrn/index.html#GUID-FF619F90-B3FA-4C12-911E-970C03E18C41) <sub>21.1 · 3.1.7</sub> |  | ✔ |  |  |  |  |  |  |
| [Report Printing](https://docs.oracle.com/en/database/oracle/application-express/21.1/htmrn/index.html#GUID-2E7CB144-9632-490B-896C-BDA58D0BDA90) <sub>21.1 · 3.1.11</sub> |  | ✔ |  |  |  |  |  |  |
| [Cards Region](https://docs.oracle.com/en/database/oracle/application-express/20.2/htmrn/index.html#GUID-BC8E3C11-2D01-4147-9FE7-64A3B3D046E4) <sub>20.2 · 3.1.1</sub> |  |  | ✔ |  |  |  |  |  |
| [Faceted Search Enhancements](https://docs.oracle.com/en/database/oracle/application-express/20.2/htmrn/index.html#GUID-D344A29D-401A-42A7-B925-4F2D575B5EBD) <sub>20.2 · 3.1.3</sub> |  |  | ✔ |  |  |  |  |  |
| [Report Printing](https://docs.oracle.com/en/database/oracle/application-express/20.2/htmrn/index.html#GUID-FA9A0717-5305-41B9-998F-1B278A537815) <sub>20.2 · 3.1.4</sub> |  |  | ✔ |  |  |  |  |  |
| [Interactive Grid Enhancements](https://docs.oracle.com/en/database/oracle/application-express/20.2/htmrn/index.html#GUID-DED3953A-6B1F-42F4-ADE6-76D29F29427A) <sub>20.2 · 3.1.12</sub> |  |  | ✔ |  |  |  |  |  |
| [Faceted Search](https://docs.oracle.com/en/database/oracle/application-express/20.1/htmrn/index.html#GUID-C061FD57-9E4F-4280-A134-CD80016E9874) <sub>20.1 · 4.1.2</sub> |  |  |  | ✔ |  |  |  |  |
| [New Interactive Grid Editing with Control Breaks](https://docs.oracle.com/en/database/oracle/application-express/20.1/htmrn/index.html#GUID-2DD2204E-F1A4-431B-AE1A-7E0C7AB6D7B6) <sub>20.1 · 4.1.6</sub> |  |  |  | ✔ |  |  |  |  |
| [Interactive Grid Support for URL Filtering](https://docs.oracle.com/en/database/oracle/application-express/20.1/htmrn/index.html#GUID-65D71CA9-A71D-4F5A-AEDD-D7A54406ED6D) <sub>20.1 · 4.1.11</sub> |  |  |  | ✔ |  |  |  |  |
| [Native PDF Printing for Interactive Grid](https://docs.oracle.com/en/database/oracle/application-express/20.1/htmrn/index.html#GUID-DFE49F55-9A5F-4A57-A617-8975856D810F) <sub>20.1 · 4.1.13</sub> |  |  |  | ✔ |  |  |  |  |
| [Faceted Search](https://docs.oracle.com/en/database/oracle/application-express/19.2/htmrn/index.html#GUID-C061FD57-9E4F-4280-A134-CD80016E9874) <sub>19.2 · 4.1.3</sub> |  |  |  |  | ✔ |  |  |  |
| [Interactive Grid Support of External Data Sources](https://docs.oracle.com/en/database/oracle/application-express/19.2/htmrn/index.html#GUID-D6EFED91-7CFB-4439-B9C3-FB83B1B6C471) <sub>19.2 · 4.1.5</sub> |  |  |  |  | ✔ |  |  |  |
| [Report Supplemental Text Attribute](https://docs.oracle.com/en/database/oracle/application-express/19.2/htmrn/index.html#GUID-D72B1608-EAE4-4E68-8E98-5E10C78442B8) <sub>19.2 · 4.1.8</sub> |  |  |  |  | ✔ |  |  |  |
| [Interactive Report supports Oracle Text indexes](https://docs.oracle.com/en/database/oracle/application-express/19.2/htmrn/index.html#GUID-1CEC5382-3745-44AE-894E-87F2CF1F4E05) <sub>19.2 · 4.1.13</sub> |  |  |  |  | ✔ |  |  |  |

</details>

<sub>[↑ Kategorien](#kategorien)</sub>

## Items, Formulare und Dynamic Actions

| Feature | 26.2 | 26.1 | 24.2 | 24.1 | 23.2 | 23.1 | 22.2 | 22.1 |
|:--|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| [Page Item Session State Data Type - BOOLEAN](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-3FEDC338-745A-4CE9-82C9-C539E088287E) <sub>26.1 · 2.10</sub> |  | ✔ |  |  |  |  |  |  |
| [New Dynamic Actions](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-647FF5DD-5B2A-4EA6-8986-6AD2FFD7243C) <sub>26.1 · 2.15.1</sub> |  | ✔ |  |  |  |  |  |  |
| [Declarative Dynamic Action Support for Actions, Buttons, Cards, and Menus](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-6A0FA352-53BD-4858-BC22-E92A970C71DF) <sub>26.1 · 2.15.3</sub> |  | ✔ |  |  |  |  |  |  |
| [Infinite Scroll for Select One, Select Many, Combobox, and Autocomplete](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-2221EFA4-30FA-4744-B183-0A4E2AFAB4E8) <sub>26.1 · 2.21</sub> |  | ✔ |  |  |  |  |  |  |
| [Copy and Paste for File Upload and Image Upload](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-BEA4162F-0345-44F9-884E-18BD17520082) <sub>26.1 · 2.28</sub> |  | ✔ |  |  |  |  |  |  |
| [Quick Pick Enhancements](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-EEF248E2-7C8C-4972-B4A2-BACD2EBCC851) <sub>26.1 · 2.30</sub> |  | ✔ |  |  |  |  |  |  |
| [Declarative Menu Buttons](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-A10C26DB-1BB9-49F2-A8D4-2D1A74E6D4EB) <sub>26.1 · 2.34</sub> |  | ✔ |  |  |  |  |  |  |
| [Show Processing for Execute Server-side Code](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-1972AE64-BB5C-48B6-99DC-13A11106F148) <sub>26.1 · 2.35</sub> |  | ✔ |  |  |  |  |  |  |
| [Improved Popup LOV Functionality](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-674230EB-1B29-43D4-A03C-23DEC97F429E) <sub>24.2 · 2.24</sub> |  |  | ✔ |  |  |  |  |  |
| [Select Many Improvements](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-55A4A343-0845-459E-9290-E8839B842616) <sub>24.2 · 2.27</sub> |  |  | ✔ |  |  |  |  |  |
| [New Select One and Select Many Item Types](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-0A93BF0D-3304-4F8F-9B84-8003B28214A8) <sub>24.1 · 2.3</sub> |  |  |  | ✔ |  |  |  |  |
| [Multi-Value Item Type JSON and Custom Separator Support](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-3365CA7B-6832-4600-82D4-D02028D3BC51) <sub>24.1 · 2.12</sub> |  |  |  | ✔ |  |  |  |  |
| [Declarative BLOB/CLOB File Download Support](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-8368AD40-3471-41F7-8991-37A86CC6EE0D) <sub>24.1 · 2.14</sub> |  |  |  | ✔ |  |  |  |  |
| [Dynamic Action Enhancements](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-A0A9BBF8-1239-42E9-923B-F4C08807C6CE) <sub>24.1 · 2.26</sub> |  |  |  | ✔ |  |  |  |  |
| [New Combobox Item](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-80496973-A7B8-45A2-837B-A2C3D3F5222F) <sub>23.2 · 2.3</sub> |  |  |  |  | ✔ |  |  |  |
| [New Image Upload Item](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-7B8E72C8-2128-41BF-B1EA-2E8FC56DE6A3) <sub>23.2 · 2.4</sub> |  |  |  |  | ✔ |  |  |  |
| [New QR Code Item](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-7C624628-626C-48C6-A815-F0EC38908344) <sub>23.2 · 2.5</sub> |  |  |  |  | ✔ |  |  |  |
| [Improvements to Background Page Processing](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-B0BC4DBE-9A17-49EC-A4D3-20DCF588CBC9) <sub>23.2 · 2.20</sub> |  |  |  |  | ✔ |  |  |  |
| [Page Processing Improvements](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-A034398A-140D-480E-B5EA-E481B817EBC3) <sub>23.1 · 2.4</sub> |  |  |  |  |  | ✔ |  |  |
| [New Color Picker](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-CD03EBDC-1E83-493C-8B9E-CDDFD2B23D7E) <sub>23.1 · 2.13</sub> |  |  |  |  |  | ✔ |  |  |
| [Invoke API Process Type](https://docs.oracle.com/en/database/oracle/apex/22.2/htmrn/new-features.html#GUID-EE4860EB-5064-48FB-B4ED-CC35825E80D2) <sub>22.2 · 3.2</sub> |  |  |  |  |  |  | ✔ |  |
| [Page Item Session State Data Type - CLOB](https://docs.oracle.com/en/database/oracle/apex/22.2/htmrn/new-features.html#GUID-6C9F520F-6DF7-4425-B964-676268D49D05) <sub>22.2 · 3.5</sub> |  |  |  |  |  |  | ✔ |  |
| [Date Picker](https://docs.oracle.com/en/database/oracle/apex/22.2/htmrn/new-features.html#GUID-05555BB0-3894-4AD5-8F8B-258A27BDA001) <sub>22.2 · 3.6</sub> |  |  |  |  |  |  | ✔ |  |
| [Number Page Item Enhancement](https://docs.oracle.com/en/database/oracle/apex/22.2/htmrn/new-features.html#GUID-8AFDF442-77B0-4190-9BDF-6B7F24485149) <sub>22.2 · 3.8</sub> |  |  |  |  |  |  | ✔ |  |
| [Naming Actions of Dynamic Actions](https://docs.oracle.com/en/database/oracle/apex/22.2/htmrn/new-features.html#GUID-FC8E5836-DBE0-45DF-A520-0098B23348BC) <sub>22.2 · 3.11</sub> |  |  |  |  |  |  | ✔ |  |
| [Debounce and Throttle Dynamic Actions](https://docs.oracle.com/en/database/oracle/apex/22.2/htmrn/new-features.html#GUID-0699A189-E092-419E-A414-354197DE5F56) <sub>22.2 · 3.13</sub> |  |  |  |  |  |  | ✔ |  |
| [Updated Rich Text Editor](https://docs.oracle.com/en/database/oracle/apex/22.2/htmrn/new-features.html#GUID-CCF92C24-1134-4BE6-8383-8ABABE8FAC95) <sub>22.2 · 3.14</sub> |  |  |  |  |  |  | ✔ |  |
| [Region Sort Page Item](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-577FB0BC-10AE-4F37-833E-D1A7135856D3) <sub>22.1 · 3.1.5</sub> |  |  |  |  |  |  |  | ✔ |
| [Markdown and Rich Text Enhancements](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-424F8D04-F2CF-4FB4-9E7C-A0C93C5A3CF7) <sub>22.1 · 3.1.6</sub> |  |  |  |  |  |  |  | ✔ |

<details>
<summary>Ältere Releases 21.2 – 18.1 (9 Einträge)</summary>

| Feature | 21.2 | 21.1 | 20.2 | 20.1 | 19.2 | 19.1 | 18.2 | 18.1 |
|:--|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| [Native Markdown Support](https://docs.oracle.com/en/database/oracle/application-express/21.1/htmrn/index.html#GUID-B1A8E8B9-DF08-47DC-8C72-9CDD5B98756D) <sub>21.1 · 3.1.2</sub> |  | ✔ |  |  |  |  |  |  |
| [New Date Picker Item Type](https://docs.oracle.com/en/database/oracle/application-express/21.1/htmrn/index.html#GUID-9AC341C1-42BF-4FD1-8322-153A6187DF85) <sub>21.1 · 3.1.8</sub> |  | ✔ |  |  |  |  |  |  |
| [New Color Picker Item Type](https://docs.oracle.com/en/database/oracle/application-express/21.1/htmrn/index.html#GUID-6C75483D-3770-4E4E-B66A-8608F81B0836) <sub>21.1 · 3.1.10</sub> |  | ✔ |  |  |  |  |  |  |
| [Item Enhancements](https://docs.oracle.com/en/database/oracle/application-express/20.2/htmrn/index.html#GUID-A882E53A-B926-47E9-AEA1-0A65EB28FC91) <sub>20.2 · 3.1.10</sub> |  |  | ✔ |  |  |  |  |  |
| [Expanded Shared LOVs](https://docs.oracle.com/en/database/oracle/application-express/19.2/htmrn/index.html#GUID-EF9CCF08-FEA1-4DC1-90AD-869E089FC1BF) <sub>19.2 · 4.1.10</sub> |  |  |  |  | ✔ |  |  |  |
| [Enhanced Popup LOV](https://docs.oracle.com/en/database/oracle/application-express/19.2/htmrn/index.html#GUID-5F7ACB3A-E337-4099-AA18-B8394DC40508) <sub>19.2 · 4.1.11</sub> |  |  |  |  | ✔ |  |  |  |
| [Open Region and Close Region Dynamic Actions](https://docs.oracle.com/en/database/oracle/application-express/19.1/htmrn/index.html#GUID-4232A8A2-83FF-4D5E-90CB-35C5FE033B13) <sub>19.1 · 4.1.3</sub> |  |  |  |  |  | ✔ |  |  |
| [New Form Region](https://docs.oracle.com/en/database/oracle/application-express/19.1/htmrn/index.html#GUID-088FFA60-EBA0-469F-91EA-3B6C2D29C935) <sub>19.1 · 4.1.5</sub> |  |  |  |  |  | ✔ |  |  |
| [Declarative Static List of Values](https://docs.oracle.com/en/database/oracle/application-express/18.2/htmrn/index.html#GUID-D3E13976-1CEC-4EFD-85BC-86626006D436) <sub>18.2 · 4.1.5</sub> |  |  |  |  |  |  | ✔ |  |

</details>

<sub>[↑ Kategorien](#kategorien)</sub>

## Charts, Maps und Kalender

| Feature | 26.2 | 26.1 | 24.2 | 24.1 | 23.2 | 23.1 | 22.2 | 22.1 |
|:--|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| [Lazy Loading for JET Charts](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-B06C63DA-FBD5-4DDC-A852-11061C46266E) <sub>26.2 · Charts</sub> | ✔ |  |  |  |  |  |  |  |
| [Improved Refreshes and Accessibility Improvements](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-1454D8F0-2EF7-42B7-97F8-D7D754950DE5) <sub>26.2 · Charts</sub> | ✔ |  |  |  |  |  |  |  |
| [Map Region Enhancements](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-CBD310DC-ED7B-4546-BB77-8D5F66C295D0) <sub>26.1 · 2.6</sub> |  | ✔ |  |  |  |  |  |  |
| [Server Side Geocoding](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-434DAEA1-50C9-47DE-9E7C-2BF6041B2840) <sub>24.1 · 2.20</sub> |  |  |  | ✔ |  |  |  |  |
| [Custom Map Backgrounds](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-18579B1A-748D-49F2-B6DE-0EB68C59979F) <sub>23.2 · 2.6</sub> |  |  |  |  | ✔ |  |  |  |
| [Vector-Based Map Support](https://docs.oracle.com/en/database/oracle/apex/22.2/htmrn/new-features.html#GUID-FDAB3A97-30FC-4F3E-BE39-D6E6FA89798C) <sub>22.2 · 3.9</sub> |  |  |  |  |  |  | ✔ |  |

<details>
<summary>Ältere Releases 21.2 – 18.1 (9 Einträge)</summary>

| Feature | 21.2 | 21.1 | 20.2 | 20.1 | 19.2 | 19.1 | 18.2 | 18.1 |
|:--|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| [Geocoding and Map Items](https://docs.oracle.com/en/database/oracle/application-express/21.2/htmrn/index.html#GUID-0FE8C1A9-1FCD-41D9-B266-F5B994948050) <sub>21.2 · 3.1.6</sub> | ✔ |  |  |  |  |  |  |  |
| [Native Map Region Type](https://docs.oracle.com/en/database/oracle/application-express/21.1/htmrn/index.html#GUID-06E81168-001D-4B13-A6F1-4E0AF9AF775B) <sub>21.1 · 3.1.1</sub> |  | ✔ |  |  |  |  |  |  |
| [FullCalendar Upgraded to v5](https://docs.oracle.com/en/database/oracle/application-express/21.1/htmrn/index.html#GUID-093EFEAB-B0FF-465C-80B1-849093FD0531) <sub>21.1 · 3.1.16</sub> |  | ✔ |  |  |  |  |  |  |
| [Charts and Library Upgrades](https://docs.oracle.com/en/database/oracle/application-express/19.1/htmrn/index.html#GUID-E8648DD9-C7C8-47EB-BC78-155BF9E99EC4) <sub>19.1 · 4.1.7</sub> |  |  |  |  |  | ✔ |  |  |
| [JET Chart Enhancements](https://docs.oracle.com/en/database/oracle/application-express/19.1/htmrn/index.html#GUID-8E21DE19-DCBF-4668-B2D1-3C2A31BA304F) <sub>19.1 · 4.1.9</sub> |  |  |  |  |  | ✔ |  |  |
| [Oracle JET Chart Types](https://docs.oracle.com/database/apex-18.1/HTMRN/toc.htm#GUID-3D0E0D99-99E9-484B-8923-4BEDB2A86EBE) <sub>18.1 · 4.1.1</sub> |  |  |  |  |  |  |  | ✔ |
| [Interactive Report Charts](https://docs.oracle.com/database/apex-18.1/HTMRN/toc.htm#GUID-5072B362-FFDC-4D03-8D8A-10EB8801676E) <sub>18.1 · 4.1.8</sub> |  |  |  |  |  |  |  | ✔ |
| [Websheet Charts](https://docs.oracle.com/database/apex-18.1/HTMRN/toc.htm#GUID-C168FBEB-54F1-4A13-B6E4-A89B04CFD77E) <sub>18.1 · 4.1.9</sub> |  |  |  |  |  |  |  | ✔ |
| [Oracle JET Chart Sorting](https://docs.oracle.com/database/apex-18.1/HTMRN/toc.htm#GUID-C1192771-A585-4E27-91C0-2ABFFED12357) <sub>18.1 · 4.1.10</sub> |  |  |  |  |  |  |  | ✔ |

</details>

<sub>[↑ Kategorien](#kategorien)</sub>

## Universal Theme, UI und PWA

| Feature | 26.2 | 26.1 | 24.2 | 24.1 | 23.2 | 23.1 | 22.2 | 22.1 |
|:--|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| [Universal Theme Enhancements](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-846F567C-E003-4772-8808-DD0B08CCD74B) <sub>26.2</sub> | ✔ |  |  |  |  |  |  |  |
| [APEX Utility CSS Framework Reference](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-9D8C53DD-6735-4D11-992C-7DA81E2836A0) <sub>26.2</sub> | ✔ |  |  |  |  |  |  |  |
| [List Entry Custom Link Attributes](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-8C20B6E3-1DCD-48B0-9A94-1F27145101D0) <sub>26.1 · 2.12</sub> |  | ✔ |  |  |  |  |  |  |
| [PWA Manifest Property Support](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-3F434F6C-0B3D-46DE-9A0F-172F2C17BC33) <sub>26.1 · 2.18</sub> |  | ✔ |  |  |  |  |  |  |
| [Template Directive Support for Theme Templates](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-3A8F5EF2-3740-4A2C-BEC1-F33A23001C5A) <sub>26.1 · 2.22.2</sub> |  | ✔ |  |  |  |  |  |  |
| [Client-side Template Component Partials](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-FA1DEE56-05B5-4791-868C-A3BAE8EEB5D7) <sub>26.1 · 2.25</sub> |  | ✔ |  |  |  |  |  |  |
| [Universal Theme Enhancements](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-7627C002-63DE-4A4E-867E-93EA0B0ED84E) <sub>26.1 · 2.33</sub> |  | ✔ |  |  |  |  |  |  |
| [Control Breaks for Template Components](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-3FB702B3-C631-4957-AB15-9550682DF827) <sub>24.2 · 2.14</sub> |  |  | ✔ |  |  |  |  |  |
| [Default RTL Direction Based on Language](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-18ABA462-51C6-479A-A7FB-1969D3E906E8) <sub>24.2 · 2.17</sub> |  |  | ✔ |  |  |  |  |  |
| [Theme Metadata Decoupled from Application Metadata](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-F1E153BA-51E9-45D5-A93F-6323D03575DE) <sub>24.2 · 2.26</sub> |  |  | ✔ |  |  |  |  |  |
| [Universal Theme Enhancements](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-7627C002-63DE-4A4E-867E-93EA0B0ED84E) <sub>24.2 · 2.28</sub> |  |  | ✔ |  |  |  |  |  |
| [Template Component Enhancements](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-014EFCED-A898-4160-8FC8-FB2085722131) <sub>24.1 · 2.4</sub> |  |  |  | ✔ |  |  |  |  |
| [Accessibility Improvements](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-EF1BA272-1D35-4A2D-8F1C-E52265AB05B6) <sub>24.1 · 2.10</sub> |  |  |  | ✔ |  |  |  |  |
| [Universal Theme Enhancements](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-7627C002-63DE-4A4E-867E-93EA0B0ED84E) <sub>24.1 · 2.25</sub> |  |  |  | ✔ |  |  |  |  |
| [Translation of Runtime Messages into Ukrainian and Vietnamese](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-03CC37FD-2BD7-42F0-88C7-B299AF8BD2ED) <sub>24.1 · 2.27</sub> |  |  |  | ✔ |  |  |  |  |
| [Automatic Dismissal of Success Messages](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-AF8BA5A4-7D98-465B-9FCA-6FF1406B5395) <sub>24.1 · 2.31</sub> |  |  |  | ✔ |  |  |  |  |
| [More Attributes for Template Components](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-6C43044A-0464-4657-A293-D84F68FFB846) <sub>23.2 · 2.8</sub> |  |  |  |  | ✔ |  |  |  |
| [Populate List Item Subentries with List Reference](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-49A877C4-BDEC-40E2-ABB0-1B41161FE753) <sub>23.2 · 2.21</sub> |  |  |  |  | ✔ |  |  |  |
| [Template Components](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-8965DD94-D103-4203-A74B-4E1B8D59E86F) <sub>23.1 · 2.1</sub> |  |  |  |  |  | ✔ |  |  |
| [PWA Push Notifications](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-C3BEC5DB-6345-4C03-96C9-F1C37A76E89F) <sub>23.1 · 2.2</sub> |  |  |  |  |  | ✔ |  |  |
| [Import and Export in Theme Roller](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-5160FD4B-3621-4B3A-8936-4E2CC67D9AE3) <sub>23.1 · 2.14</sub> |  |  |  |  |  | ✔ |  |  |
| [Region Display Selector Enhancements](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-29A3C228-5BFF-4C8B-A207-A87F95DB9335) <sub>23.1 · 2.15</sub> |  |  |  |  |  | ✔ |  |  |
| [Improved App Icon Fidelity](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-3A2FFCEE-21C9-4D9B-8CC1-F74A057C2958) <sub>23.1 · 2.17</sub> |  |  |  |  |  | ✔ |  |  |
| [Translation of Runtime Messages into Icelandic](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-622939A5-8C31-4BD4-B78C-DA3F1DD3F4CF) <sub>23.1 · 2.18</sub> |  |  |  |  |  | ✔ |  |  |
| [New Dynamic Content Region](https://docs.oracle.com/en/database/oracle/apex/22.2/htmrn/new-features.html#GUID-B55FE5BA-0F87-4A0D-A621-46817B1CFE78) <sub>22.2 · 3.3</sub> |  |  |  |  |  |  | ✔ |  |
| [Progressive Web App Enhancements](https://docs.oracle.com/en/database/oracle/apex/22.2/htmrn/new-features.html#GUID-CC29DE90-3004-4389-AD65-EB7917581593) <sub>22.2 · 3.10</sub> |  |  |  |  |  |  | ✔ |  |
| [Landmark Support for Regions](https://docs.oracle.com/en/database/oracle/apex/22.2/htmrn/new-features.html#GUID-98CFD3D3-8D02-4C16-A380-72DC4023014B) <sub>22.2 · 3.12</sub> |  |  |  |  |  |  | ✔ |  |
| [Drawer Modal Dialog Template](https://docs.oracle.com/en/database/oracle/apex/22.2/htmrn/new-features.html#GUID-E2D7BC4E-931D-4170-8C59-5483D3372DD5) <sub>22.2 · 3.15</sub> |  |  |  |  |  |  | ✔ |  |
| [Customizing the PWA Service Worker](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-7AE4D7D7-8E9C-4A30-A2B8-6A9D1BCE66D5) <sub>22.1 · 3.1.7</sub> |  |  |  |  |  |  |  | ✔ |
| [Improved Region Images](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-0197F618-7FF7-49EC-8473-40E559994F77) <sub>22.1 · 3.1.9</sub> |  |  |  |  |  |  |  | ✔ |
| [Application Icons](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-36C5A5FD-0215-45CB-B619-27DA78EB4EAE) <sub>22.1 · 3.1.11</sub> |  |  |  |  |  |  |  | ✔ |

<details>
<summary>Ältere Releases 21.2 – 18.1 (18 Einträge)</summary>

| Feature | 21.2 | 21.1 | 20.2 | 20.1 | 19.2 | 19.1 | 18.2 | 18.1 |
|:--|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| [Progressive Web Apps](https://docs.oracle.com/en/database/oracle/application-express/21.2/htmrn/index.html#GUID-D5FD5B6E-53BF-48A3-A6CD-9114094B0D70) <sub>21.2 · 3.1.2</sub> | ✔ |  |  |  |  |  |  |  |
| [Universal Theme & UI Updates](https://docs.oracle.com/en/database/oracle/application-express/21.2/htmrn/index.html#GUID-377BC025-9373-48A2-AFCF-A31F188E57A2) <sub>21.2 · 3.1.3</sub> | ✔ |  |  |  |  |  |  |  |
| [Updated Alert and Confirm Dialogs](https://docs.oracle.com/en/database/oracle/application-express/21.2/htmrn/index.html#GUID-6417C65F-C7B1-4294-A6F8-EDB0638E4C26) <sub>21.2 · 3.1.5</sub> | ✔ |  |  |  |  |  |  |  |
| [Font APEX Enhancements](https://docs.oracle.com/en/database/oracle/application-express/21.2/htmrn/index.html#GUID-3517FC73-7CDF-4B61-91FD-9717F5A9DF8E) <sub>21.2 · 3.1.16</sub> | ✔ |  |  |  |  |  |  |  |
| [Universal Theme Enhancements](https://docs.oracle.com/en/database/oracle/application-express/21.1/htmrn/index.html#GUID-B14943C7-18EC-4B4A-8CF7-AE582143F09E) <sub>21.1 · 3.1.3</sub> |  | ✔ |  |  |  |  |  |  |
| [Font APEX Icons](https://docs.oracle.com/en/database/oracle/application-express/21.1/htmrn/index.html#GUID-79FDC7EC-9120-47A6-8347-21463312E86E) <sub>21.1 · 3.1.17</sub> |  | ✔ |  |  |  |  |  |  |
| [Redwood UI (Redwood Light Theme Style)](https://docs.oracle.com/en/database/oracle/application-express/20.2/htmrn/index.html#GUID-7BFDB1FE-D102-4881-ABCA-EA9835089134) <sub>20.2 · 3.1.8</sub> |  |  | ✔ |  |  |  |  |  |
| [Tree Region Enhancements](https://docs.oracle.com/en/database/oracle/application-express/20.2/htmrn/index.html#GUID-3433185C-223D-418A-B3D4-CC0DB421FCEE) <sub>20.2 · 3.1.11</sub> |  |  | ✔ |  |  |  |  |  |
| [Template Directives](https://docs.oracle.com/en/database/oracle/application-express/20.2/htmrn/index.html#GUID-97A9B666-C4BA-4515-84B8-9C4BEEF4B126) <sub>20.2 · 3.1.16</sub> |  |  | ✔ |  |  |  |  |  |
| [Redwood UI](https://docs.oracle.com/en/database/oracle/application-express/20.1/htmrn/index.html#GUID-7BFDB1FE-D102-4881-ABCA-EA9835089134) <sub>20.1 · 4.1.1</sub> |  |  |  | ✔ |  |  |  |  |
| [Universal Theme (Link Target Attribute)](https://docs.oracle.com/en/database/oracle/application-express/20.1/htmrn/index.html#GUID-6CFF2E68-0D2B-4D9F-A8D7-85873209D5B8) <sub>20.1 · 4.1.5</sub> |  |  |  | ✔ |  |  |  |  |
| [Mega Menu Navigation](https://docs.oracle.com/en/database/oracle/application-express/20.1/htmrn/index.html#GUID-EC6F3E46-61B2-49D8-864E-CEB6973A9F50) <sub>20.1 · 4.1.8</sub> |  |  |  | ✔ |  |  |  |  |
| [Universal Theme](https://docs.oracle.com/en/database/oracle/application-express/19.2/htmrn/index.html#GUID-6CFF2E68-0D2B-4D9F-A8D7-85873209D5B8) <sub>19.2 · 4.1.2</sub> |  |  |  |  | ✔ |  |  |  |
| [Enhanced Application Logo](https://docs.oracle.com/en/database/oracle/application-express/19.2/htmrn/index.html#GUID-AF02817D-2736-4ED0-9304-B1F11D96DDAA) <sub>19.2 · 4.1.9</sub> |  |  |  |  | ✔ |  |  |  |
| [Region template Inline Pop-up](https://docs.oracle.com/en/database/oracle/application-express/19.1/htmrn/index.html#GUID-DFD8376D-7597-4193-B7C2-CAA60A06D590) <sub>19.1 · 4.1.2</sub> |  |  |  |  |  | ✔ |  |  |
| [Universal Theme](https://docs.oracle.com/en/database/oracle/application-express/19.1/htmrn/index.html#GUID-6CFF2E68-0D2B-4D9F-A8D7-85873209D5B8) <sub>19.1 · 4.1.8</sub> |  |  |  |  |  | ✔ |  |  |
| [Updated Font APEX](https://docs.oracle.com/en/database/oracle/application-express/18.2/htmrn/index.html#GUID-DC878484-9B2C-491E-B39F-7FB735485639) <sub>18.2 · 4.1.1</sub> |  |  |  |  |  |  | ✔ |  |
| [Updated Font APEX](https://docs.oracle.com/database/apex-18.1/HTMRN/toc.htm#GUID-DC878484-9B2C-491E-B39F-7FB735485639) <sub>18.1 · 4.1.2</sub> |  |  |  |  |  |  |  | ✔ |

</details>

<sub>[↑ Kategorien](#kategorien)</sub>

## REST, Datenquellen und Daten-Import

| Feature | 26.2 | 26.1 | 24.2 | 24.1 | 23.2 | 23.1 | 22.2 | 22.1 |
|:--|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| [Enhanced Fusion Applications Starter App](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-B63CEBF2-3D22-49F5-9126-F1BDB2CF224C) <sub>26.2</sub> | ✔ |  |  |  |  |  |  |  |
| [REST Data Sources Dynamic Values](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-2DF885BE-C596-4E58-94F3-D8013C99C508) <sub>26.1 · 2.5.4</sub> |  | ✔ |  |  |  |  |  |  |
| [Template Directive Support for REST Data Sources](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-746E6A85-D853-4A72-9351-6254C3AC1507) <sub>26.1 · 2.5.5</sub> |  | ✔ |  |  |  |  |  |  |
| [JSON Sources](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-96526B18-0C95-408D-A398-C7E57E3C2CAB) <sub>24.2 · 2.1</sub> |  |  | ✔ |  |  |  |  |  |
| [JSON Duality Views](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-FA70141F-6219-4AAB-91B7-39DC58AEB7C3) <sub>24.2 · 2.2</sub> |  |  | ✔ |  |  |  |  |  |
| [REST Source Enhancements](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-922C01C8-8B50-4BFB-86D9-0D416DC79995) <sub>24.2 · 2.4</sub> |  |  | ✔ |  |  |  |  |  |
| [Support for Fusion Integration](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-EFCDD231-7B9B-4D12-9155-851EFBF41F26) <sub>24.2 · 2.8</sub> |  |  | ✔ |  |  |  |  |  |
| [BOSS REST Service Support](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-27F0B964-3132-4D1A-AE66-DFD3D6195416) <sub>24.2 · 2.9</sub> |  |  | ✔ |  |  |  |  |  |
| [Hierarchical JSON Support for REST Sources](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-9D347C71-B9E1-4BBF-858E-7F61BAD1293B) <sub>24.1 · 2.21</sub> |  |  |  | ✔ |  |  |  |  |
| [Improvements to REST Source Infrastructure](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-1DB10FAB-2423-4DB5-9F50-8A30D078CEB1) <sub>24.1 · 2.22</sub> |  |  |  | ✔ |  |  |  |  |
| [Improvements to REST Source Infrastructure](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-58B37AE0-5340-47CD-9AFB-54C230C798E5) <sub>23.2 · 2.11</sub> |  |  |  |  | ✔ |  |  |  |
| [REST Source Catalogs from OpenAPI Documents](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-DEBD6DD5-5A79-4F2E-BD45-63C3F643ED2A) <sub>23.2 · 2.12</sub> |  |  |  |  | ✔ |  |  |  |
| [OData Connector as a Native REST Source Type](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-6DB03D89-3709-41C3-8356-152BFC2C76CE) <sub>23.2 · 2.13</sub> |  |  |  |  | ✔ |  |  |  |
| [Support for Fusion Apps Extensions](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-9E83467A-CEC5-40A1-A00A-067735D6CCF2) <sub>23.2 · 2.14</sub> |  |  |  |  | ✔ |  |  |  |
| [REST Data Source Enhancements](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-877611CD-31D1-4E51-A2F8-216C46B27F64) <sub>23.1 · 2.5</sub> |  |  |  |  |  | ✔ |  |  |
| [Property Graph Support](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-5370C60E-482E-4BB6-8342-BD24AE653F3F) <sub>23.1 · 2.6</sub> |  |  |  |  |  | ✔ |  |  |
| [REST Sources (REST Enabled SQL Query)](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-1D9E3439-B5DD-41BF-8F04-33D96453460E) <sub>22.1 · 3.1.17</sub> |  |  |  |  |  |  |  | ✔ |

<details>
<summary>Ältere Releases 21.2 – 18.1 (12 Einträge)</summary>

| Feature | 21.2 | 21.1 | 20.2 | 20.1 | 19.2 | 19.1 | 18.2 | 18.1 |
|:--|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| [REST Catalogs and Improvements](https://docs.oracle.com/en/database/oracle/application-express/21.2/htmrn/index.html#GUID-C528F3EB-3887-4941-9FC5-BED7D146D3B6) <sub>21.2 · 3.1.7</sub> | ✔ |  |  |  |  |  |  |  |
| [New Application Data Loading](https://docs.oracle.com/en/database/oracle/application-express/21.1/htmrn/index.html#GUID-D2FE9163-AEE6-4C4D-A074-A1AA600BF3A6) <sub>21.1 · 3.1.6</sub> |  | ✔ |  |  |  |  |  |  |
| [REST Data Sources (CSV Support)](https://docs.oracle.com/en/database/oracle/application-express/21.1/htmrn/index.html#GUID-AE1635EA-7E65-46F3-AA5C-95B107D2B59E) <sub>21.1 · 3.1.9</sub> |  | ✔ |  |  |  |  |  |  |
| [REST Data Source Synchronization](https://docs.oracle.com/en/database/oracle/application-express/20.2/htmrn/index.html#GUID-FF0E8042-AD6A-485B-822E-2B018CA3F2F4) <sub>20.2 · 3.1.5</sub> |  |  | ✔ |  |  |  |  |  |
| [REST Data Source Connector Plug-Ins](https://docs.oracle.com/en/database/oracle/application-express/20.2/htmrn/index.html#GUID-694962A3-CC6E-4EC5-B16D-20FF92C4430B) <sub>20.2 · 3.1.6</sub> |  |  | ✔ |  |  |  |  |  |
| [New Name for Web Source Modules](https://docs.oracle.com/en/database/oracle/application-express/20.2/htmrn/index.html#GUID-9D807CDC-118E-48E2-B973-F3A148466066) <sub>20.2 · 3.1.13</sub> |  |  | ✔ |  |  |  |  |  |
| [Data Loading into Existing Tables](https://docs.oracle.com/en/database/oracle/application-express/19.2/htmrn/index.html#GUID-6CF98529-6DBB-4C32-A177-6FF9273D9B6A) <sub>19.2 · 4.1.6</sub> |  |  |  |  | ✔ |  |  |  |
| [Interactive Report, Interactive Grid and Popup LOV searches can be passed to a REST service](https://docs.oracle.com/en/database/oracle/application-express/19.2/htmrn/index.html#GUID-AC045B74-D32A-41C2-A3A2-BBC0DB1CD05D) <sub>19.2 · 4.1.14</sub> |  |  |  |  | ✔ |  |  |  |
| [Clob Column support in SQL Workshop Data Loading and APEX_DATA_PARSER](https://docs.oracle.com/en/database/oracle/application-express/19.2/htmrn/index.html#GUID-26998347-93B6-4DD7-808A-E1FC7B91E5BD) <sub>19.2 · 4.1.15</sub> |  |  |  |  | ✔ |  |  |  |
| [Data Loading](https://docs.oracle.com/en/database/oracle/application-express/19.1/htmrn/index.html#GUID-CE064C54-F237-421F-A8FC-6C957CCAA325) <sub>19.1 · 4.1.6</sub> |  |  |  |  |  | ✔ |  |  |
| [REST Enabled SQL Support](https://docs.oracle.com/database/apex-18.1/HTMRN/toc.htm#GUID-331ADF9F-D798-48A1-8AB6-E543C6EEF8C5) <sub>18.1 · 4.1.3</sub> |  |  |  |  |  |  |  | ✔ |
| [REST Service Consumption](https://docs.oracle.com/database/apex-18.1/HTMRN/toc.htm#GUID-52FA8FCC-D1EF-4A23-AC28-FFFF32D2F1D7) <sub>18.1 · 4.1.4</sub> |  |  |  |  |  |  |  | ✔ |

</details>

<sub>[↑ Kategorien](#kategorien)</sub>

## Administration und Betrieb

| Feature | 26.2 | 26.1 | 24.2 | 24.1 | 23.2 | 23.1 | 22.2 | 22.1 |
|:--|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| [Enhanced Mail Queue Reporting](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-098369DE-A6EE-4758-96B9-4C9DCEEC2207) <sub>26.2 · Administration</sub> | ✔ |  |  |  |  |  |  |  |
| [Enhanced Manage Service Wizard](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-4C0962C4-B7B2-4636-B558-5C34FB1379D1) <sub>26.2 · Administration</sub> | ✔ |  |  |  |  |  |  |  |
| [Oracle BI Publisher Credentials Support](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-0FF7323E-84CF-4485-8C4C-852090994A98) <sub>26.1 · 2.11</sub> |  | ✔ |  |  |  |  |  |  |
| [Disabling External Links for an Instance](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-4C7F9230-EBE2-46DB-8636-795B236C1807) <sub>26.1 · 2.14</sub> |  | ✔ |  |  |  |  |  |  |
| [UI for APEX Install/Upgrade Logs](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-4CBA78BF-0046-4B99-89B9-5F2988B55F5A) <sub>26.1 · 2.17</sub> |  | ✔ |  |  |  |  |  |  |
| [Application User Experience Data (OpenTelemetry)](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-8037EB13-18AE-4709-8A2E-4CDB2DC579E7) <sub>24.2 · 2.21</sub> |  |  | ✔ |  |  |  |  |  |
| [Define Maximum Emails Processed](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-AF89580D-C298-4614-A086-4E9664DF64F8) <sub>24.1 · 2.28</sub> |  |  |  | ✔ |  |  |  |  |
| [Unified Privilege Management](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-828DBB65-B4FB-49AC-91DE-9869C0D01D44) <sub>24.1 · 2.30</sub> |  |  |  | ✔ |  |  |  |  |
| [New Instance Parameters for APEX_INSTANCE_ADMIN](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-61CD2D9F-CEB9-40F6-A654-D04CD0665216) <sub>23.2 · 2.24</sub> |  |  |  |  | ✔ |  |  |  |
| [Store Static Resources in Oracle Cloud Object Storage](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-70B5D9C1-A2DF-4981-8C10-B69727267AA6) <sub>23.2 · 2.26</sub> |  |  |  |  | ✔ |  |  |  |
| [Capture ECID in APEX Webservice Log](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-25199462-9DEC-4B4C-969C-DE397B172688) <sub>23.1 · 2.8</sub> |  |  |  |  |  | ✔ |  |  |
| [Application Continuity](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-823C04C6-9E79-40C9-A805-719BE137BFCC) <sub>23.1 · 2.9</sub> |  |  |  |  |  | ✔ |  |  |
| [APEX Administrator Digest](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-210B2A99-C8D1-4B06-B934-C83271DCD728) <sub>23.1 · 2.10</sub> |  |  |  |  |  | ✔ |  |  |
| [Auto-Provisioning Restrictions](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-07C0D72A-FCAE-42AC-8CCC-97F63728F2F5) <sub>23.1 · 2.11</sub> |  |  |  |  |  | ✔ |  |  |
| [New Application Administration API Package](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-CF7439F0-3852-4CA9-A405-31B3B2054061) <sub>23.1 · 2.12</sub> |  |  |  |  |  | ✔ |  |  |
| [Email Template Updates](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-DD330082-E598-418F-906F-60F6C032E586) <sub>22.1 · 3.1.21</sub> |  |  |  |  |  |  |  | ✔ |

<details>
<summary>Ältere Releases 21.2 – 18.1 (2 Einträge)</summary>

| Feature | 21.2 | 21.1 | 20.2 | 20.1 | 19.2 | 19.1 | 18.2 | 18.1 |
|:--|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| [Environment Setup (Environment Banner, SAML)](https://docs.oracle.com/en/database/oracle/application-express/21.2/htmrn/index.html#GUID-A9FE2F6F-429B-4704-AE39-54D3A28FD1E1) <sub>21.2 · 3.1.10</sub> | ✔ |  |  |  |  |  |  |  |
| [Email and Email Template Enhancements](https://docs.oracle.com/en/database/oracle/application-express/21.2/htmrn/index.html#GUID-B96C92AF-F16B-4331-B8BC-73BB9506C8B1) <sub>21.2 · 3.1.11</sub> | ✔ |  |  |  |  |  |  |  |

</details>

<sub>[↑ Kategorien](#kategorien)</sub>

## APIs und JavaScript-Bibliotheken

| Feature | 26.2 | 26.1 | 24.2 | 24.1 | 23.2 | 23.1 | 22.2 | 22.1 |
|:--|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| [PL/SQL API Updates](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-39BC930D-5B8A-450D-AFEB-24E89BE1CF6C) <sub>26.2 · Administration</sub><br>Neue Prozeduren in APEX_APPLICATION_ADMIN und APEX_APPLICATION_INSTALL für Deep Data Security, Supporting Objects, Application Locking und Working Copies. Dazu kommen Ergänzungen in APEX_AUTHENTICATION (Gruppen aus dem ID-Token), APEX_HUMAN_TASK (Outcome setzen), APEX_SESSION (Data Roles) und APEX_WORKFLOW (Instanzen migrieren). | ✔ |  |  |  |  |  |  |  |
| [JavaScript API Updates](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-5E4F1950-DACE-4D55-9505-C4570FC30C38) <sub>26.2</sub><br>Mit apex.region.multipleRefresh lassen sich Charts, Interactive Grids, Cards und Template-Component-Regionen in einem einzigen Ajax-Request aktualisieren. Neu sind die Klasse ForegroundTimer und eine eigene chartRegion-Schnittstelle, dazu kleinere Korrekturen, etwa an apex.navigation.redirect. | ✔ |  |  |  |  |  |  |  |
| [JavaScript Library Upgrades](https://docs.oracle.com/en/database/oracle/apex/26.2/htmrn/new-features.html#GUID-175489FB-CC24-40F6-89EF-A4A7AAFD7770) <sub>26.2</sub><br>Aktualisierte Drittbibliotheken, darunter JET 20.1.4, MapLibre GL 6.7.0, Monaco 0.56.0, DOMPurify 3.4.14 und FullCalendar 6.1.21. Außerdem neue Versionen der OpenTelemetry-Pakete sowie von MarkedJS, Terser und Turndown. | ✔ |  |  |  |  |  |  |  |
| [PL/SQL API Updates](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-39BC930D-5B8A-450D-AFEB-24E89BE1CF6C) <sub>26.1 · 2.37</sub><br>Neu sind APEX_HUMAN_TASK.REFRESH_BUSINESS_ADMINS, DELETE_TASKS in APEX_WORKFLOW und APEX_HUMAN_TASK sowie SET_TOOL_RESULT in APEX_AI. Dazu kommen die neuen Pakete APEX_INSTANCE_DEBUG (Debug- und Activity-Logs ohne SYS-Rechte) und APEX_DB_DICTIONARY (LLM-taugliche Tabellenbeschreibungen). APEX_SHARED_COMPONENT kann jetzt auch Themes aktualisieren und veröffentlichen, APEX_AI wurde durchgängig überarbeitet. |  | ✔ |  |  |  |  |  |  |
| [JavaScript API Updates](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-5E4F1950-DACE-4D55-9505-C4570FC30C38) <sub>26.1 · 2.38</sub><br>Neu sind die Schnittstelle interactiveReportRegion mit Auswahl- und Zeilenverwaltung, Template-Funktionen in apex.util sowie hideLayer, showLayer und moveLayer für mapRegion. Das grid-Widget erhält erweiterte Clipboard- und Mehrfachbereich-Auswahl, dazu kommen zahlreiche Accessibility-Ergänzungen an menu, menuButton und showSpinner. |  | ✔ |  |  |  |  |  |  |
| [JavaScript Library Upgrades](https://docs.oracle.com/en/database/oracle/apex/26.1/htmrn/new-features.html#GUID-175489FB-CC24-40F6-89EF-A4A7AAFD7770) <sub>26.1 · 2.39</sub><br>Aktualisierte Bibliotheken, darunter JET 20.0.2, jQuery 3.7.1, jQuery UI 1.14.1, MapLibre 5.6.1, monaco-editor 0.55.1 und DOMPurify 3.4.0. Neu aufgenommen sind die API-Spezifikationen bzw. SDKs für Anthropic, Google Gemini, Mistral AI und Ollama. |  | ✔ |  |  |  |  |  |  |
| [PL/SQL API Updates](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-39BC930D-5B8A-450D-AFEB-24E89BE1CF6C) <sub>24.2 · 2.29</sub><br>Neu sind APEX_APPLICATION_ADMIN.SET_REMOTE_SERVER, APEX_CREDENTIAL.SET_SCOPE, APEX_REGION.GET_ID und das Paket APEX_SHARED_COMPONENT mit REFRESH und PUBLISH. APEX_LANG erhält UPDATE_MESSAGE und neue Parameter für CREATE_MESSAGE, APEX_PAGE.GET_URL kann absolute URLs erzeugen. |  |  | ✔ |  |  |  |  |  |
| [JavaScript API Updates](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-5E4F1950-DACE-4D55-9505-C4570FC30C38) <sub>24.2 · 2.30</sub><br>Neue apex.message-Funktionen sowie erweiterte Syntax für actions und apex.util.applyTemplate (ab Compatibility Mode 24.2). Änderungen an facetsRegion, model und tableModelView unterstützen Faceted-Search-Filter, verzögertes Leeren von Daten und Control Breaks. |  |  | ✔ |  |  |  |  |  |
| [JavaScript Library Upgrades](https://docs.oracle.com/en/database/oracle/apex/24.2/htmrn/new-features.html#GUID-175489FB-CC24-40F6-89EF-A4A7AAFD7770) <sub>24.2 · 2.31</sub><br>Aktualisierte Bibliotheken, darunter JET 17.0.2, Monaco Editor 0.51.0, MapLibre GL 4.6.0, DOMPurify 3.1.6, FullCalendar 6.1.15 und Marked 14.1.0. Neu hinzugekommen sind die OpenTelemetry-Pakete für die Erfassung von Nutzungsdaten. |  |  | ✔ |  |  |  |  |  |
| [PL/SQL API Updates](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-39BC930D-5B8A-450D-AFEB-24E89BE1CF6C) <sub>24.1 · 2.32</sub><br>APEX_AUTOMATION.TERMINATE ersetzt das nun veraltete ABORT. Neu sind außerdem APEX_EXEC.DESCRIBE_QUERY, zusätzliche Parameter und Overloads in APEX_INSTANCE_ADMIN sowie APEX_PLUGIN_UTIL.PRINT_READ_ONLY als Nachfolger von print_display_only. |  |  |  | ✔ |  |  |  |  |
| [JavaScript API Updates](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-5E4F1950-DACE-4D55-9505-C4570FC30C38) <sub>24.1 · 2.33</sub><br>Neue Schnittstellen cardsRegion und templateReportRegion sowie neue Events, Optionen und Methoden für die Auswahl in tableModelView und grid. facetsRegion unterstützt Datumswerte, und mit apex.message.setDismissPreferences lässt sich das automatische Ausblenden von Erfolgsmeldungen steuern. |  |  |  | ✔ |  |  |  |  |
| [JavaScript Library Upgrades](https://docs.oracle.com/en/database/oracle/apex/24.1/htmrn/new-features.html#GUID-175489FB-CC24-40F6-89EF-A4A7AAFD7770) <sub>24.1 · 2.34</sub><br>Aktualisierte Bibliotheken, darunter Oracle JET 16.0.1, Monaco Editor 0.47.0, TinyMCE 6.8.3, FullCalendar 6.1.11, MapLibre 4.0.1 und DOMPurify 3.1.4. |  |  |  | ✔ |  |  |  |  |
| [JavaScript API Updates](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-5E4F1950-DACE-4D55-9505-C4570FC30C38) <sub>23.2 · 2.28</sub><br>apex.util.escapeHTML liefert für NULL jetzt einen Leerstring, lovValuesOptimization wurde entfernt. Neu sind tileLayer-Eigenschaften für mapRegion und ein postNode-Callback für model.walkTree, dazu ein geändertes Verhalten von model.allowDelete bei Bäumen. |  |  |  |  | ✔ |  |  |  |
| [JavaScript Library Upgrades](https://docs.oracle.com/en/database/oracle/apex/23.2/htmrn/new-features.html#GUID-175489FB-CC24-40F6-89EF-A4A7AAFD7770) <sub>23.2 · 2.29</sub><br>Aktualisierte Bibliotheken, darunter Oracle JET 15.0.7, TinyMCE 6.7.1, FullCalendar 6.1.8, DOMPurify 3.0.5 und Marked.js 5.1.2. Neu aufgenommen wurde die Oracle Rich Text Library 1.0.2 (ab APEX 23.2.9). |  |  |  |  | ✔ |  |  |  |
| [JavaScript API Updates](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-5E4F1950-DACE-4D55-9505-C4570FC30C38) <sub>23.1 · 2.23</sub><br>Neu sind die actions-Methode ariaKeyshortcut, Funktionen für Push-Subscriptions in apex.pwa und die model-Methode getDataOverflow. Zusätzlich gibt es neue Optionen für apex.message und apex.model.create sowie Debug-Logging für apex.page.isChanged. |  |  |  |  |  | ✔ |  |  |
| [JavaScript Library Upgrades](https://docs.oracle.com/en/database/oracle/apex/23.1/htmrn/new-features.html#GUID-175489FB-CC24-40F6-89EF-A4A7AAFD7770) <sub>23.1 · 2.24</sub><br>Aktualisierte Bibliotheken, darunter CKEditor5 36.0.0, JET 14.0.0, jQuery 3.6.4, MapLibre 2.4.0, FullCalendar 5.11.3, DOMPurify 2.4.3 und Terser 5.16.1. |  |  |  |  |  | ✔ |  |  |
| [JavaScript API Updates](https://docs.oracle.com/en/database/oracle/apex/22.2/htmrn/new-features.html#GUID-5E4F1950-DACE-4D55-9505-C4570FC30C38) <sub>22.2 · 3.17</sub><br>Neu sind apex.util.throttle, der Parameter pImmediate für debounce und neue model-Events. mapRegion erhält die Eigenschaft useVectorTileLayers, außerdem gibt es Parameter-Umbenennungen und Verbesserungen der Dokumentation. |  |  |  |  |  |  | ✔ |  |
| [PL/SQL API Updates](https://docs.oracle.com/en/database/oracle/apex/22.2/htmrn/new-features.html#GUID-39BC930D-5B8A-450D-AFEB-24E89BE1CF6C) <sub>22.2 · 3.18</sub><br>APEX_ESCAPE erhält die Funktionen csv und striphtml sowie breitere CLOB-Unterstützung. APEX_LDAP kann über p_credential_static_id Web Credentials nutzen, APEX_THEME wurde um Beispiele ergänzt. |  |  |  |  |  |  | ✔ |  |
| [JavaScript Library Upgrades](https://docs.oracle.com/en/database/oracle/apex/22.2/htmrn/new-features.html#GUID-175489FB-CC24-40F6-89EF-A4A7AAFD7770) <sub>22.2 · 3.19</sub><br>Aktualisierte Bibliotheken, darunter CKEditor 5.35.x, jQuery 3.6.0, FullCalendar 5.11.2, JET 12.1.3 und MapLibre 2.1.9. |  |  |  |  |  |  | ✔ |  |
| [JavaScript Library Upgrades](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-175489FB-CC24-40F6-89EF-A4A7AAFD7770) <sub>22.1 · 3.1.22</sub><br>Aktualisierte Bibliotheken, darunter Oracle JET 12.0.0, jQuery UI 1.13.1, CKEditor5 32.0.0, MarkedJS 4.0.12 und DOMPurify 2.3.1. Maps nutzen jetzt MapLibre 1.15.2 statt Mapbox. |  |  |  |  |  |  |  | ✔ |
| [JavaScript API Updates](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-5E4F1950-DACE-4D55-9505-C4570FC30C38) <sub>22.1 · 3.1.23</sub><br>Actions lassen sich jetzt an Links binden und mit Kontext-ID und Argumenten aufrufen, auch aus treeView und menu. Neu sind unter anderem apex.model.multipleFetch, Funktionen für ausgeblendete und deaktivierte Datensätze im model sowie neue apex.locale-Funktionen für Tages- und Monatsnamen. |  |  |  |  |  |  |  | ✔ |
| [PL/SQL API Updates](https://docs.oracle.com/en/database/oracle/apex/22.1/htmrn/index.html#GUID-39BC930D-5B8A-450D-AFEB-24E89BE1CF6C) <sub>22.1 · 3.1.24</sub><br>APEX_WEB_SERVICE erhält CLEAR_REQUEST_HEADERS und CLEAR_REQUEST_COOKIES. APEX_STRING unterstützt Arrays von CLOBs mit PUSH, SPLIT_CLOBS und JOIN_CLOBS. |  |  |  |  |  |  |  | ✔ |

<details>
<summary>Ältere Releases 21.2 – 18.1 (14 Einträge)</summary>

| Feature | 21.2 | 21.1 | 20.2 | 20.1 | 19.2 | 19.1 | 18.2 | 18.1 |
|:--|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| [JavaScript Library Upgrades](https://docs.oracle.com/en/database/oracle/application-express/21.2/htmrn/index.html#GUID-175489FB-CC24-40F6-89EF-A4A7AAFD7770) <sub>21.2 · 3.1.13</sub><br>Aktualisierte Bibliotheken: jQuery 3.6.0, MarkedJS 3.0.0, Oracle JET 11.0.0 und PrismJS 1.24.1. | ✔ |  |  |  |  |  |  |  |
| [JavaScript (jsDoc) Updates](https://docs.oracle.com/en/database/oracle/application-express/21.2/htmrn/index.html#GUID-5E4F1950-DACE-4D55-9505-C4570FC30C38) <sub>21.2 · 3.1.14</sub><br>Neue Namespaces apex.date und apex.pwa sowie neue Schnittstellen für colorPickerItem, facetsRegion, mapRegion und numberFieldItem. apex.util.applyTemplate erhält eine verbesserte if-Direktive, außerdem gibt es apex.items, apex.regions, apex.env und die Item-Methoden isReady und whenReady. | ✔ |  |  |  |  |  |  |  |
| [JavaScript Library Upgrades](https://docs.oracle.com/en/database/oracle/application-express/21.1/htmrn/index.html#GUID-175489FB-CC24-40F6-89EF-A4A7AAFD7770) <sub>21.1 · 3.1.13</sub><br>Aktualisierte Bibliotheken: Oracle JET 10.0.0, FullCalendar 5.5.1, CKEditor5 27.1.0, Monaco Editor 0.22.3, jQuery 3.5.1 und jQuery Migrate 3.3.2. |  | ✔ |  |  |  |  |  |  |
| [New JavaScript APIs](https://docs.oracle.com/en/database/oracle/application-express/21.1/htmrn/index.html#GUID-9D3CA38B-3FDA-446E-9D73-15D141F09394) <sub>21.1 · 3.1.15</sub><br>Neu sind apex.item.isItem, apex.locale.toNumber und getModel bzw. getPageInfo für mehrere Widgets. grid und tableModelView erhalten neue Optionen wie fixedRowHeight und virtuelle Paginierung, und apex.util.applyTemplate prüft bei Ersetzungen jetzt zuerst Model-Spalten. |  | ✔ |  |  |  |  |  |  |
| [JavaScript Library Upgrades](https://docs.oracle.com/en/database/oracle/application-express/20.2/htmrn/index.html#GUID-A5C02F23-1A64-4F2C-A18B-09612D995B2A) <sub>20.2 · 3.1.14</sub><br>Aktualisierte Bibliotheken: Oracle JET 9.1.0, jQuery 3.5.1, CKEditor 5 und Monaco Editor 0.20.0. |  |  | ✔ |  |  |  |  |  |
| [New JavaScript APIs](https://docs.oracle.com/en/database/oracle/application-express/20.2/htmrn/index.html#GUID-9D3CA38B-3FDA-446E-9D73-15D141F09394) <sub>20.2 · 3.1.15</sub><br>Neu sind apex.item.addAttachHandler für Item-Plug-ins sowie apex.lang.loadMessages und loadMessagesIfNeeded. Model-Felder erhalten Metadaten wie dataType, calcValue und aggregates, und tableModelView bzw. grid bekommen Optionen für leere Footer und Paginierung. |  |  | ✔ |  |  |  |  |  |
| [Oracle JET and Third Party Library Updates](https://docs.oracle.com/en/database/oracle/application-express/20.1/htmrn/index.html#GUID-D1915738-4EEB-42A0-99B0-4C7FAD4CA174) <sub>20.1 · 4.1.3</sub><br>Aktualisierte Bibliotheken: Oracle JET 8.0.0, jQuery 3.4.1, jQuery UI 1.12.1 und FullCalendar 3.10.0. |  |  |  | ✔ |  |  |  |  |
| [New JavaScript APIs](https://docs.oracle.com/en/database/oracle/application-express/20.1/htmrn/index.html#GUID-9D3CA38B-3FDA-446E-9D73-15D141F09394) <sub>20.1 · 4.1.4</sub><br>Neu sind der Namespace apex.locale sowie die Funktionen apex.da.cancel und apex.theme.mq. apex.actions, das menu-Widget und treeView können Links jetzt in einem neuen Fenster öffnen, model.create erhält die Option requestOptions. |  |  |  | ✔ |  |  |  |  |
| [New JavaScript APIs](https://docs.oracle.com/en/database/oracle/application-express/19.2/htmrn/index.html#GUID-9D3CA38B-3FDA-446E-9D73-15D141F09394) <sub>19.2 · 4.1.1</sub><br>Neue Tastennamen und die Funktionen apex.actions.getKeyCaps bzw. setKeyCaps für Tastaturkürzel. grid, iconList, interactiveGridView, recordView und tableModelView erhalten neue Optionen und Methoden wie finishEditing. |  |  |  |  | ✔ |  |  |  |
| [Oracle JET and jQuery Library Updates](https://docs.oracle.com/en/database/oracle/application-express/19.2/htmrn/index.html#GUID-D1915738-4EEB-42A0-99B0-4C7FAD4CA174) <sub>19.2 · 4.1.12</sub><br>Aktualisierte Bibliotheken: Oracle JET 7.2.0, jQuery 3.4.1, jQuery UI 1.12.1 und FullCalendar 3.3.10. |  |  |  |  | ✔ |  |  |  |
| [New Callout and Popup Template Option APIs](https://docs.oracle.com/en/database/oracle/application-express/19.2/htmrn/index.html#GUID-801202D3-2367-4587-B69F-EB366BA7DEC7) <sub>19.2 · 4.1.17</sub><br>Zwei neue APIs für Template Options: die callout-Option und das popup-Widget. |  |  |  |  | ✔ |  |  |  |
| [JavaScript API Documentation](https://docs.oracle.com/en/database/oracle/application-express/19.1/htmrn/index.html#GUID-9D3CA38B-3FDA-446E-9D73-15D141F09394) <sub>19.1 · 4.1.1</sub><br>Die JavaScript-API-Dokumentation zieht weiter in eine eigene Referenz um. Neu sind unter anderem apex.util.getNestedObject, Toolbar-Funktionen für das interactiveGrid und die grid-Option cellCssClassesColumn. |  |  |  |  |  | ✔ |  |  |
| [JavaScript API Documentation](https://docs.oracle.com/en/database/oracle/application-express/18.2/htmrn/index.html#GUID-9D3CA38B-3FDA-446E-9D73-15D141F09394) <sub>18.2 · 4.1.2</sub><br>Die JavaScript-APIs werden in eine eigene Referenz ausgelagert. Neu dokumentiert sind unter anderem die Widgets grid, iconList, interactiveGrid, menu, recordView, tableModelView und treeView. |  |  |  |  |  |  | ✔ |  |
| [JavaScript API Documentation](https://docs.oracle.com/database/apex-18.1/HTMRN/toc.htm#GUID-9D3CA38B-3FDA-446E-9D73-15D141F09394) <sub>18.1 · 4.1.6</sub><br>Die JavaScript-APIs ziehen aus der API Reference in eine eigene JavaScript API Reference um. Neu dokumentiert sind unter anderem menu, treeView, grid sowie apex.actions und apex.model. |  |  |  |  |  |  |  | ✔ |

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
