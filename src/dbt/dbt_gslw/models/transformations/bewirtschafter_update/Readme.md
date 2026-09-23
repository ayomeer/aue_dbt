# Bewirtschafter Update Job

## Schritte zum Bewirtschafter-Update

1) Export File auf `dbt_gslw` Schema importieren. Im Fall von AGRICOLA wars ein Excel File: 
- Abspeichern als CSV (Datei > Exportieren > Datentyp ändern > CSV)
- CSV-Datei in Notepad++ öffnen: Encoding > Convert to UTF-8
- In QGIS: Als Layer importieren und via DB-Manager auf DB importieren als `imp_agricola_bew`
    - Im CSV-Import Dialog "trim fields" deaktivieren, damit `KT_ID` korrekt formattiert bleibt 
    - Nach dem Importieren OWNER auf gleiche Rolle setzen, wie andere dbt tabellen und views

2) dbt Job `transformations.bewirtschafter_update` ausführen:
    ```bash
    dbt run -s +transformations.bewirtschafter_update
    ```
    Dies erstellt die Tabelle `dbt_gslw.preview_bewirtschafter_update`, an welcher die Änderungen vorgängig geprüft werden können.

3) Audit Tabellen zur Preview generieren: 
    ```bash
    dbt run -s +audits.bewirtschafter_update_preview
    ```
    Dies erstellt die beiden Audit-Tabellen `audit_preview_cols` und `audit_preview_rows`, welche einen besseren Einblick in die Änderungen als Folge von `transformations.bewirtschafter_update` geschehen.

4) Sind die Änderungen geprüft und in Ordnung, kann der Transform-Job mit `enable_transfer` ausgeführt werden. Zunächst sollte aber noch eine aktuelle Version des Schemas auf den IAP kopiert werden, damit beim Zurückkopieren nichts verloren geht (windmill > copyschema).
    ```bash
    dbt run -s +transformations.bewirtschafter_update --vars 'enable_transfer: true'
    ```
    Hiermit wird das Update anstelle der preview-Tabelle auf die tatsächliche (IAP-)Tabelle `dbu_aue_gslw.bewirtschafter` geschrieben. Anschliessend kann das Schema zurück auf PROD kopiert werden, um die Änderungen wirksam zu machen (vorher Backup vom PROD Schema machen).  