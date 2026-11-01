# ER-Modell: APEX New Features App

Basis: [nfo_specification.md](nfo_specification.md), Stand der Anforderungen 100–650.

```mermaid
erDiagram
    RELEASE ||--o{ FEATURE : enthaelt
    RELEASE ||--o{ RELEASE_VIDEO : hat
    RELEASE ||--o{ IMPORT_LOG : protokolliert
    RELEASE_VIDEO ||--o{ VIDEO_CHAPTER : listet
    CATEGORY ||--o{ FEATURE : kategorisiert
    VIDEO_CHAPTER |o--o{ FEATURE : verlinkt

    RELEASE {
        number release_id PK
        varchar version UK "z.B. 26.1"
        varchar new_features_url "Anf. 610"
        varchar pdf_url "Anf. 650, optional"
        timestamp created_at
    }
    CATEGORY {
        number category_id PK
        varchar name_de UK "Anf. 170"
        varchar name_en UK "Anf. 170"
        number sort_order
    }
    FEATURE {
        number feature_id PK
        number release_id FK
        number category_id FK "Anf. 100, NOT NULL, ON DELETE RESTRICT (Anf. 140)"
        number chapter_id FK "Anf. 200, nullable"
        number chapter_match_score "0-1, Qualitaet der Zuordnung"
        varchar title
        clob raw_text_en "Originaltext von der Oracle-Seite"
        varchar feature_summary_en UK "VARCHAR2(4000), NOT NULL, Initialwert 'empty', Anf. 450"
        varchar feature_summary_de UK "VARCHAR2(4000), NOT NULL, Initialwert 'empty', Anf. 450"
        varchar doc_url "link_feature_oracle_doc"
        timestamp created_at
        timestamp updated_at
    }
    RELEASE_VIDEO {
        number video_id PK
        number release_id FK
        varchar title "Titel auf YouTube"
        varchar youtube_url UK "Anf. 240"
        varchar youtube_key UK "11-stellige Video-ID"
        char is_main "Y/N, Anf. 210"
        clob description "Quelle der Sprungmarken"
        timestamp fetched_at
    }
    VIDEO_CHAPTER {
        number chapter_id PK
        number video_id FK
        number start_seconds
        varchar title
        varchar link_url UK "youtu.be/ID?t=Sekunden, Anf. 240"
    }
    IMPORT_LOG {
        number import_id PK
        number release_id FK
        varchar started_by "APEX-Benutzername (APP_USER)"
        varchar import_type "CSV, AI_EXTRACT, AI_ENRICH"
        varchar status "OK, ERROR"
        varchar message "Anf. 430, zweisprachig ueber Text Messages"
        timestamp started_at
        timestamp finished_at
    }
```

## Entwurfsentscheidungen

- **Zweisprachigkeit:** `feature_summary_de` und `feature_summary_en` sind Spalten in `FEATURE`. Bei nur zwei Sprachen ist das einfacher als eine Übersetzungstabelle und passt zu den gleichnamigen CSV-Spalten aus Anforderung 440. Der Originaltext (`raw_text_en`) bleibt getrennt, damit die KI jederzeit neu zusammenfassen kann.
- **Kategorien:** `FEATURE` verweist per ID auf `CATEGORY`, daher bleiben Umbenennen (160) und Verschieben (130) einfache Updates. Der Fremdschlüssel verhindert das Löschen einer belegten Kategorie (140). `name_en` ist für den Sprachwechsel (500) vorgesehen.
- **YouTube:** Sprungmarken stehen getrennt in `VIDEO_CHAPTER` (220). Ein Feature zeigt auf höchstens eine Sprungmarke (200). Auch nicht zugeordnete Kapitel bleiben sichtbar. Fehlt jede Sprungmarke, zeigt die App "Keine Sprungmarken gefunden" (230).
- **Eindeutigkeit:** Kategorienamen (170), Feature-Beschreibungen (450) sowie YouTube-Links von Release-Videos und Sprungmarken (240) sind jeweils eindeutig. `feature_summary_de`/`feature_summary_en` sind deshalb `VARCHAR2(4000)` statt CLOB, denn auf CLOB-Spalten erlaubt Oracle keinen Unique Constraint.
- **Kein Überschreiben:** `feature_summary_de`/`feature_summary_en` sind NOT NULL mit dem Initialwert `'empty'`. Ein Update mit leerem Wert, etwa von einer Seite ohne dieses Feld, scheitert, statt den gespeicherten Text zu löschen. Die Eindeutigkeit (450) gilt für alle Werte außer `'empty'` (funktionsbasierter Unique Index).
- **Rollen:** Benutzer und Rollen (Anf. 300) verwaltet die in APEX integrierte Application Access Control mit den Rollen `CONTRIBUTOR` und `ADMINISTRATOR`. Eine eigene Benutzertabelle entfällt. Seiten und Komponenten werden über Authorization Schemes abgesichert, die auf diese Rollen prüfen. Die Zuordnungen stehen in den Views `APEX_APPL_ACL_USERS` und `APEX_APPL_ACL_USER_ROLES`. Gepflegt werden sie über die Access-Control-Seiten der App oder per `APEX_ACL`. `IMPORT_LOG.started_by` speichert deshalb nur den APEX-Benutzernamen (`APP_USER`) und hat keinen Fremdschlüssel.
