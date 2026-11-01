Vorgehen:
- Lege mit dem admin user über sqlcl ein schema an: NFO_SYS
- gib dem schema user alle rechte um die Objekte anzulegen und zu ändern
- lege die Tabellen an (siehe ER-Modell)
- lege die LOV views an für categories 
- erzeuge die dml packages mit dem tapi generator (pkg_nfo_tapi_gen.sql), aber nur für categories und features.
- erzeuge unit tests für die dml packages 
- korrigiere die dml packages, falls die unit tests fehlschlagen
