# Diagramm-Test (Branch test/diagramme)

Testdatei, um zu prüfen, welche Darstellungen GitHub rendert. Datenbasis: `apex-new-features.md`.

## 1. Mermaid-Version auf GitHub

```mermaid
info
```

## 2a. Mindmap: Kategorien → Releases (22.1 – 26.2, Anzahl neuer Features)

```mermaid
mindmap
  root(("APEX New Features"))
    c1["Administration und Betrieb"]
      n2["26.2 · 2"]
      n3["26.1 · 3"]
      n4["24.2 · 1"]
      n5["24.1 · 2"]
      n6["23.2 · 2"]
      n7["23.1 · 5"]
      n8["22.1 · 1"]
    c9["APIs und JavaScript-Bibliotheken"]
      n10["26.2 · 3"]
      n11["26.1 · 3"]
      n12["24.2 · 3"]
      n13["24.1 · 3"]
      n14["23.2 · 2"]
      n15["23.1 · 2"]
      n16["22.2 · 3"]
      n17["22.1 · 3"]
    c18["Charts, Maps und Kalender"]
      n19["26.2 · 2"]
      n20["26.1 · 1"]
      n21["24.1 · 1"]
      n22["23.2 · 1"]
      n23["22.2 · 1"]
    c24["Entwicklung und Lifecycle"]
      n25["26.2 · 5"]
      n26["26.1 · 16"]
      n27["24.2 · 7"]
      n28["24.1 · 8"]
      n29["23.2 · 8"]
      n30["23.1 · 5"]
      n31["22.2 · 1"]
      n32["22.1 · 9"]
    c33["Items, Formulare und Dynamic Actions"]
      n34["26.1 · 8"]
      n35["24.2 · 2"]
      n36["24.1 · 4"]
      n37["23.2 · 4"]
      n38["23.1 · 2"]
      n39["22.2 · 7"]
      n40["22.1 · 2"]
    c41["KI und Generative AI"]
      n42["26.2 · 5"]
      n43["26.1 · 11"]
      n44["24.2 · 4"]
      n45["24.1 · 1"]
    c46["Reports, Grids und Suche"]
      n47["26.2 · 2"]
      n48["26.1 · 6"]
      n49["24.2 · 2"]
      n50["24.1 · 4"]
      n51["23.2 · 3"]
      n52["22.2 · 2"]
      n53["22.1 · 3"]
    c54["REST, Datenquellen und Daten-Import"]
      n55["26.2 · 1"]
      n56["26.1 · 2"]
      n57["24.2 · 5"]
      n58["24.1 · 2"]
      n59["23.2 · 4"]
      n60["23.1 · 2"]
      n61["22.1 · 1"]
    c62["Security und Authentifizierung"]
      n63["26.2 · 3"]
      n64["26.1 · 6"]
      n65["24.2 · 1"]
      n66["24.1 · 2"]
      n67["23.1 · 1"]
      n68["22.1 · 1"]
    c69["Universal Theme, UI und PWA"]
      n70["26.2 · 2"]
      n71["26.1 · 5"]
      n72["24.2 · 4"]
      n73["24.1 · 5"]
      n74["23.2 · 2"]
      n75["23.1 · 6"]
      n76["22.2 · 4"]
      n77["22.1 · 3"]
    c78["Workflow, Tasks und Automations"]
      n79["26.2 · 5"]
      n80["26.1 · 4"]
      n81["24.2 · 2"]
      n82["24.1 · 2"]
      n83["23.2 · 3"]
      n84["23.1 · 1"]
      n85["22.2 · 1"]
      n86["22.1 · 1"]
```

## 2b. Mindmap: KI und Generative AI → Release → Feature

```mermaid
mindmap
  root(("KI und Generative AI"))
    r87["26.2"]
      f88["Reasoning Effort for AI Agents"]
      f89["New Provider API Setting for Generative AI Services"]
      f90["OCI Generative AI Service Settings"]
      f91["AI-Generated Navigation in Show AI Assistant"]
      f92["Computed Columns with Natural Language in Interactive Reports"]
    r93["26.1"]
      f94["Natural Language Support for Interactive Report"]
      f95["Create Page Using Natural Language"]
      f96["AI Agent Tools"]
      f97["AI Tool Guardrails"]
      f98["Generate Text with AI Page Process"]
      f99["AI-Generated Structured Outputs JSON"]
      f100["Generative AI Token Usage Limits"]
      f101["Additional AI Provider Support"]
      f102["AI Dynamic Action Enhancements"]
      f103["Blueprints"]
      f104["File Attachment Support for APEX_AI"]
    r105["24.2"]
      f106["Dynamic Action: Generate Text with AI"]
      f107["Create Custom Data Models Using AI"]
      f108["AI Configurations and RAG Sources"]
      f109["Generative AI Configuration Screen Enhancements"]
    r110["24.1"]
      f111["Generative AI Support"]
```

## 3. Heatmap (Emoji-Tabelle): neue Features je Kategorie und Release

Legende: ⬜ 0 · 🟨 1–2 · 🟧 3–5 · 🟥 6 und mehr

| Kategorie | 26.2 | 26.1 | 24.2 | 24.1 | 23.2 | 23.1 | 22.2 | 22.1 | 21.2 | 21.1 | 20.2 | 20.1 | 19.2 | 19.1 | 18.2 | 18.1 |
|:--|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| Administration und Betrieb | 🟨 2 | 🟧 3 | 🟨 1 | 🟨 2 | 🟨 2 | 🟧 5 | ⬜ | 🟨 1 | 🟨 2 | ⬜ | ⬜ | ⬜ | ⬜ | ⬜ | ⬜ | ⬜ |
| APIs und JavaScript-Bibliotheken | 🟧 3 | 🟧 3 | 🟧 3 | 🟧 3 | 🟨 2 | 🟨 2 | 🟧 3 | 🟧 3 | 🟨 2 | 🟨 2 | 🟨 2 | 🟨 2 | 🟧 3 | 🟨 1 | 🟨 1 | 🟨 1 |
| Charts, Maps und Kalender | 🟨 2 | 🟨 1 | ⬜ | 🟨 1 | 🟨 1 | ⬜ | 🟨 1 | ⬜ | 🟨 1 | 🟨 2 | ⬜ | ⬜ | ⬜ | 🟨 2 | ⬜ | 🟧 4 |
| Entwicklung und Lifecycle | 🟧 5 | 🟥 16 | 🟥 7 | 🟥 8 | 🟥 8 | 🟧 5 | 🟨 1 | 🟥 9 | 🟧 4 | 🟧 4 | 🟨 1 | 🟧 4 | 🟧 3 | 🟨 2 | 🟧 3 | 🟨 2 |
| Items, Formulare und Dynamic Actions | ⬜ | 🟥 8 | 🟨 2 | 🟧 4 | 🟧 4 | 🟨 2 | 🟥 7 | 🟨 2 | ⬜ | 🟧 3 | 🟨 1 | ⬜ | 🟨 2 | 🟨 2 | 🟨 1 | ⬜ |
| KI und Generative AI | 🟧 5 | 🟥 11 | 🟧 4 | 🟨 1 | ⬜ | ⬜ | ⬜ | ⬜ | ⬜ | ⬜ | ⬜ | ⬜ | ⬜ | ⬜ | ⬜ | ⬜ |
| Reports, Grids und Suche | 🟨 2 | 🟥 6 | 🟨 2 | 🟧 4 | 🟧 3 | ⬜ | 🟨 2 | 🟧 3 | 🟧 3 | 🟧 3 | 🟧 4 | 🟧 4 | 🟧 4 | ⬜ | ⬜ | ⬜ |
| REST, Datenquellen und Daten-Import | 🟨 1 | 🟨 2 | 🟧 5 | 🟨 2 | 🟧 4 | 🟨 2 | ⬜ | 🟨 1 | 🟨 1 | 🟨 2 | 🟧 3 | ⬜ | 🟧 3 | 🟨 1 | ⬜ | 🟨 2 |
| Security und Authentifizierung | 🟧 3 | 🟥 6 | 🟨 1 | 🟨 2 | ⬜ | 🟨 1 | ⬜ | 🟨 1 | ⬜ | ⬜ | 🟨 1 | ⬜ | ⬜ | ⬜ | ⬜ | 🟨 1 |
| Universal Theme, UI und PWA | 🟨 2 | 🟧 5 | 🟧 4 | 🟧 5 | 🟨 2 | 🟥 6 | 🟧 4 | 🟧 3 | 🟧 4 | 🟨 2 | 🟧 3 | 🟧 3 | 🟨 2 | 🟨 2 | 🟨 1 | 🟨 1 |
| Workflow, Tasks und Automations | 🟧 5 | 🟧 4 | 🟨 2 | 🟨 2 | 🟧 3 | 🟨 1 | 🟨 1 | 🟨 1 | ⬜ | ⬜ | 🟨 1 | ⬜ | ⬜ | ⬜ | ⬜ | ⬜ |
