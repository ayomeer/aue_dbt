# Bewirtschafter Update Job

## Ablauf

1) Export File auf `dbt_gslw` Schema importieren. Im Fall von AGRICOLA wars ein Excel File: 
- Abspeichern als CSV (Datei > Exportieren > Datentyp ändern > CSV)
- CSV-Datei in Notepad++ öffnen: Encoding > Convert to UTF-8
- In QGIS: Als Layer importieren und via DB-Manager auf DB importieren
    - Im CSV-Import Dialog "trim fields" deaktivieren, damit `KT_ID` korrekt formattiert bleibt 
    - Nach dem Importieren OWNER auf gleiche Rolle setzen, wie andere dbt tabellen und views