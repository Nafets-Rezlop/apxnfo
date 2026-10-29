anforderungen an eine web app, mit der man einen einfach überblick über die new features von oracle apex bekommen kann.

Hintergrund: oracle veröffentlicht 2x/jahr ein neues release, es gibt sehr viele new features und ein nutzer soll möglichst schnell viele Information dazu erhalten können.

anforderungen

# kategorien
| Nr. | Anforderung |
|----:|-------------|
| 100 | das system muss jedes neue feature kategorisieren |
| 110 | die kategorien soll es aus dem repo nafets-rezlop/apxnfo übernehmen |
| 120 | die kategorien sollen vom admin nachträglich geändert werden können |
| 130 | kategorieänderung 1: verschieben eines features von einer kategorie in eine andere |
| 140 | kategorieänderung 2: löschen einer kategorie, dabei müssen alle features in eine andere verschoben werden, erst danach ist das löschen möglich |
| 150 | kategorieänderung 3: anlage einer kategorie |
| 160 | kategorieänderung 4 : umbenennen einer kategorie |

# feature verlinkung zu youtube
| Nr. | Anforderung |
|----:|-------------|
| 200 | das system soll pro new feature ein youtube link anzeigen können. Hintergrund: Oracle APEX stellt die neuen features mit mehreren Zoom Sessions vor und lädt diese Videos in einen Youtube kanal. Pro video gibt es oft eine Beschreibung der Inhalte und Sprungmarken zu den stellen im video, wo bestimmte features vorgestellt werden. |
| 210 | das system soll pro apex release ein hauptlink zu dem youtube film abspeichern können. Hintergrund: zu diesem Video gibt es fast immer sprungmarken |
| 220 | das system soll nach verlinkung des release films auf youtube automatisch nach in der Beschreibung nach den sprungmarken innerhalb des videos suchen und diese separat auflisten. |
| 230 | falls keine sprungmarken gefunden wurden soll das system ausgeben: Keine sprungmarken gefunden |

# berechtigungen
| Nr. | Anforderung |
|----:|-------------|
| 300 | das system hat 2 rollen: contributor, admin |
| 310 | der contributor kann neue features anlegen, kategorisieren und youtube links hinterlegen |
| 320 | der admin kann zusätzlich kategorien löschen |
| 330 | der zugang zur app ist frei im internet |

# aufnahme neuer releases
| Nr. | Anforderung |
|----:|-------------|
|420 | das system soll die neuen features aus einer csv datei importieren können. Hintergrund: die CSV Datei wird per KI generiert und enthält die neuen features, die in der new feature seite des releases enthalten sind. |
|430 | Die CSV Datei wird vom contributor hochgeladen und das System prüft die Datei auf korrekte Syntax. Im Erfolgsfall wird eine Meldung ausgegeben, die die release nummer enthält, Beispiel: "CSV Datei für release 26.2 erfolgreich importiert" |
| 440 | das system soll CSV Datei prüfen auf die spalten: "Feature", "desc_de", "desc_en", "category", "link_feature_oracle_doc" | "link_feature_youtube" |


# sprachen
| Nr. | Anforderung |
|----:|-------------|
| 500 | die app bietet einen wechsel zwischen englisch und deutsch |
| 510 | alle meldungen sollen in beiden sprachen angezeigt werden |

# vorbereitung des imports eines neuen releases mit python script
| Nr. | Anforderung |
|----:|-------------|   
| 600 | das system soll ein python script bereitstellen, das die neuen features aus der new feature seite des releases extrahiert und in eine csv datei schreibt. |
| 610 | als input für das python script wird die URL der new feature seite des releases benötigt. |
| 620 | das python script soll die csv datei in einem format schreiben, das vom system importiert werden kann. siehe anforderung 440 |
| 630 | das python script soll als zusätzlichen optionalen parameter den youtube link des release films akzeptieren.
| 640 | Das system soll dann die sprungmarken aus der Beschreibung des videos extrahieren und in die csv datei unter "link_feature_youtube" schreiben. |
| 650 | das python script als zusätzlichen optionalen parameter den link zum new feature pdf von oracle aufnehmen können. beispiel für 26.1: https://www.oracle.com/a/otn/docs/apex-261-new-features.pdf|


# technische anforderungen
| Nr. | Anforderung |
|----:|-------------|       
| 700 | das system soll in Oracle APEX 26.1 entwickelt werden |  
| 710 | es soll mit der neuen Funktion AI Blueprints entwickelt werden |
| 720 | das system soll die neuen features in einer interaktiven grid anzeigen |

# migration zur befüllung

# datenmodell
| Nr. | Anforderung |
|----:|-------------|
| 800 | das system soll die neuen features in einer relationalen Datenbank speichern |
| 810 | das system soll basierend auf dem ER Modell er_model_nfo.md entwickelt werden|
| 820 | alle tabellen sollen mit präfix "t_nfo" angelegt werden |
| 822 | jede tabelle hat einen künstlichen primärschlüssel, der aus tabellenkürzel + _id besteht, z.B. feat_id für die features tabelle. |
| 825|  jeder primärschlüssel wird von einer eigenen erstellten sequenz versorgt, namenskonvention: s_nfo_features_feat_id|
| 830 | alle spalten haben das tabellenkürzel als präfix, z.B. feat_id, feat_desc_de |
| 835 | alle tabellen haben englischen pluralnamen, z.B. t_nfo_features, t_nfo_categories, t_nfo_releases |
| 840 | constraints haben die namenskonvention cf_nfo_<tabellenkürzel elterntabelle>_<tabellenkürzel kindtabelle><spaltenname ohne tabellenkürzel>, z.B. cf_nfo_catg_feat_feat_id |
| 850 | jede tabelle hat auditspalten <tab_kürzel>_ins_date (default sysdate, verpflichtend), <tab_kürzel>_ins_user (verpflichtend), <tab_kürzel>_upd_date (optional), <tab_kürzel>_upd_user (optional) | 
|870 | das system erstellt für die auditspalten _user eine Domäne mit VARCHAR2(128bytes) und dem Namen dom_nfo_user, die in allen tabellen verwendet wird. |
|890 | das system erstellt für die auditspalten _ins_date und _upd_date eine Domäne mit DATE und dem Namen dom_nfo_date, die in allen tabellen verwendet wird. |
|900 | alle DML Operationen sollen über eigene packages erfolgen und nicht über den DML Prozess von APEX.|
|910 | das system soll für jede tabelle ein eigenes package erstellen, das die DML Operationen kapselt. Namenskonvention: pkg_nfo_<tabellenkürzel>_dml, z.B. pkg_nfo_feat_dml |
|920 | um das datenmodell nicht in der UI zu zeigen, sollen views erstellt werden, die die tabellen kapseln. |
|930 | es soll eine view v_nfo_ui_features geben, die die tabelle t_nfo_features kapselt und die spalten feat_id, feat_desc_de, feat_desc_en, feat_link_feature_oracle_doc, feat_link_feature_youtube, feat_catg_id, feat_rel_id enthält. Sie löst die IDs der Kategorien und Releases auf und zeigt die Namen an |
|940 | gegen diese view laufen alle DML Operationen um die tabelle t_nfo_features zu befüllen. Die view ist updatable. |
|950 | es soll eine view v_nfo_ui_categories geben, die die tabelle t_nfo_categories kapselt und die spalten catg_id, catg_name enthält. |
|960 | gegen diese view laufen alle DML Operationen um die tabelle t_nfo_categories zu befüllen. Die view ist updatable. |
|970 | es soll eine view v_nfo_ui_releases geben, die die tabelle t_nfo_releases kapselt und die spalten rel_id, rel_name enthält. |
|980| gegen diese view laufen alle DML Operationen um die tabelle t_nfo_releases zu befüllen. Die view ist updatable. |
|990 | jedes DML package bekommt als übergabeparameter den recordtype der zugehörigen view, z.B. v_nfo_ui_categories%rowtype|
|1000 | das system soll innerhalb der DML packages das lost-update problem verhindern, indem es dieselbe Logik verwendet, wie sie im APEX backend unter SQL Workshop → Utilities → Methods on Tables verwendet wird (mit MD5 Prüfsummen ) 
|1010 | von einer APEX Seite, die einen Datensatz auf einer modalen Seite bearbeitet oder neu anlegt, sollen die TAPI-Prozeduren so aufgrufen werden. Beispiel für eine delete prozedur siehe unten |
|1020 | die TAPI-Prozeduren sollen nur mit MERGE und DELETE arbeiten.|
|1030| DAs system soll das MERGE so implementieren, dass es im Fall eines leeren Primärschlüssels, bspw. falls feat_id NULL ist, ein INSERT ausgeführt wird, ansonsten ein UPDATE.|

# weiter mit:
Offene Punkte werden als GitHub Issues geführt: https://github.com/nafets-rezlop/apxnfo/issues
- [#3](https://github.com/Nafets-Rezlop/apxnfo/issues/3) MD5-Fehler (Lost Update) in APEX abfangen und anzeigen
- [#5](https://github.com/Nafets-Rezlop/apxnfo/issues/5) ER Modell auf Vollständigkeit prüfen
- [#6](https://github.com/Nafets-Rezlop/apxnfo/issues/6) Sprachumstellung in den Views (APEX Appl. Variable für die Sprache?)
- [#7](https://github.com/Nafets-Rezlop/apxnfo/issues/7) SQL Makros auf die Views (Testbarkeit)

# Code-Beispiele
## Übergabe von Parametern von Page items an die TAPI-Prozeduren
### Löschen eines Features
-- bei delete reicht der Primärschlüssel
```sql
declare
   lo_rec_feature v_nfo_ui_features%rowtype;
begin
   lo_rec_feature.feat_id := :P1_FEAT_ID;
   pkg_nfo_feat_dml.del(lo_rec_feature);
end;
```
### Anlegen und Ändern eines Features (MERGE)
Regeln: 
1) Ist :P1_FEAT_ID leer, wird ein neues Feature angelegt, sonst das vorhandene geändert (Anf. 1030).
2) :P1_FEAT_MD5 wird beim Laden des des Feature-Datensatzes aus der Datenbank berechnet und in einem versteckten Page Item gespeichert.Beim Speichern des Datensatz wird die MD5 Prüfsumme an die TAPI-Prozedur übergeben. Die TAPI-Prozedur prüft, ob der Datensatz in der Datenbank noch die gleiche Prüfsumme hat. Ist dies nicht der Fall, wird ein Fehler ausgegeben und der Datensatz nicht gespeichert.

```sql
-- KLÄREN (#3): hier nicht berücksichtig ist das Reagieren auf den Fehler, falls die MD5 Prüfsumme nicht mehr stimmt. Wie dies am besten in APEX umgesetzt werden kann, muss noch geklärt werden.
declare
   lo_rec_feature v_nfo_ui_features%rowtype;
   lo_md5          varchar2(32767);
begin
   lo_rec_feature.feat_id      := :P1_FEAT_ID;
   lo_rec_feature.feat_desc_de := :P1_FEAT_DESC_DE;
   lo_rec_feature.feat_desc_en := :P1_FEAT_DESC_EN;
   lo_rec_feature.feat_catg_id := :P1_FEAT_CATG_ID;
   lo_rec_feature.feat_rel_id  := :P1_FEAT_REL_ID;
   lo_md5 := :P1_FEAT_MD5; 
   pkg_nfo_feat_dml.mrg(lo_rec_feature, lo_md5);   
end;
```
