# ER-Modell: APEX New Features App

Basis: [anforderungen_nfo.md](anforderungen_nfo.md), Stand der Anforderungen 100–640.

```mermaid
erDiagram
    RELEASE ||--o{ FEATURE : enthaelt
    RELEASE ||--o{ RELEASE_VIDEO : hat
    RELEASE ||--o{ IMPORT_LOG : protokolliert
    RELEASE_VIDEO ||--o{ VIDEO_CHAPTER : listet
    CATEGORY ||--o{ FEATURE : kategorisiert
    VIDEO_CHAPTER |o--o{ FEATURE : verlinkt
    APP_USER ||--o{ IMPORT_LOG : startet

    RELEASE {
        number release_id PK
        varchar version UK "z.B. 26.1"
        varchar new_features_url "Anf. 610"
        varchar pdf_url "Anf. 650, optional"
        timestamp created_at
    }
    CATEGORY {
        number category_id PK
        varchar name_de
        varchar name_en
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
        clob summary_en "Zusammenfassung englisch"
        clob summary_de "Zusammenfassung deutsch"
        varchar doc_url "link_feature_oracle_doc"
        varchar source "CSV, AI, MANUAL"
        varchar review_status "NEW, REVIEWED"
        timestamp created_at
        timestamp updated_at
    }
    RELEASE_VIDEO {
        number video_id PK
        number release_id FK
        varchar youtube_url
        varchar youtube_key "11-stellige Video-ID"
        char is_main "Y/N, Anf. 210"
        clob description "Quelle der Sprungmarken"
        timestamp fetched_at
    }
    VIDEO_CHAPTER {
        number chapter_id PK
        number video_id FK
        number start_seconds
        varchar title
        varchar link_url "youtu.be/ID?t=Sekunden"
    }
    APP_USER {
        number user_id PK
        varchar username UK
        varchar role_code "CONTRIBUTOR oder ADMIN, Anf. 300"
    }
    IMPORT_LOG {
        number import_id PK
        number release_id FK
        number user_id FK
        varchar import_type "CSV, AI_EXTRACT, AI_ENRICH"
        varchar status "OK, ERROR"
        varchar message "Anf. 430, zweisprachig ueber Text Messages"
        timestamp started_at
        timestamp finished_at
    }
```

## Entwurfsentscheidungen

- **Zweisprachigkeit:** `summary_de` und `summary_en` sind Spalten in `FEATURE`. Bei nur zwei Sprachen ist das einfacher als eine Übersetzungstabelle und passt zu `desc_de`/`desc_en` aus Anforderung 440. Der Originaltext (`raw_text_en`) bleibt getrennt, damit die KI jederzeit neu zusammenfassen kann.
- **Kategorien:** `FEATURE` verweist per ID auf `CATEGORY`, daher bleiben Umbenennen (160) und Verschieben (130) einfache Updates. Der Fremdschlüssel verhindert das Löschen einer belegten Kategorie (140). `name_en` ist für den Sprachwechsel (500) vorgesehen.
- **YouTube:** Sprungmarken stehen getrennt in `VIDEO_CHAPTER` (220). Ein Feature zeigt auf höchstens eine Sprungmarke (200). Auch nicht zugeordnete Kapitel bleiben sichtbar. Fehlt jede Sprungmarke, zeigt die App "Keine Sprungmarken gefunden" (230).
- **KI-Kontrolle:** `source` und `review_status` markieren KI-Ergebnisse, damit ein Contributor sie prüfen kann.
- **Rollen:** `APP_USER.role_code` ist eine einfache Lösung. Alternativ gibt es in APEX die integrierte Funktion Application Access Control.
