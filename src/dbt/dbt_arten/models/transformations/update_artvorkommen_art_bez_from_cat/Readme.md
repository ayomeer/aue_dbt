# Tranform-Job: update_artvorkommen_art_bez_from_cat

## Motivation
Die Art welche dem Artvorkommen über die Katalog-ID zugewiesen wird is die "master"-Information. Im artvorkommen-Layer selbst gibt es aber auch `art_wiss` und `art_deutsch`, welche als 'convenience' eingeführt wurden und grundsätzlich die gleiche Information anzeigen sollten.

Um allfällige Diversionen der Angaben der Katalog-Art über `id_from_cat_arten` und der Felder `art_wiss` und `art_deutsch` zu korrigieren, wurde dieser Transformations-Job geschrieben.

## Beschreibung
Zu erst kann im dbt-Modell geprüft werden, welche Änderungen gemacht werden, in dem der Transformations-Job ohne die Variable `enable_tranform: true` ausgeführt wird und dann die view aus dem gleichnamigen Modell erstellte View `arvorkommen_art_txt_update_values` geprüft wird. Diese zeigt für jedes Objekt, das eine Änderung erfährt jeweils den aktuellen und (geplanten) neuen Werte an.

Nachdem die geplanten Änderungen geprüft wurden, kann der gleiche Transformations-Job mit der Variable `enable_tranform: true` ausgeführt werden. Also:

```bash
dbt run -s +transformations.update_artvorkommen_art_bez_from_cat --vars 'enable_transfer: true'
```

Dies führt das Update auf dem IAP-Server aus. Danach kann man sich nochmals vergewissern, dass alles richtig geschrieben wurde und dann via windmill copyschema Job die Änderungen auf PROD zurück geschrieben werden.