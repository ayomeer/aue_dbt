# dbt_biotope

## Angenwendeter Ablauf

1) INTERLIS Modell auf PostGIS Datenbank importieren (https://github.com/ayomeer/aue_interlis/blob/main/ili2pg/scripts/schemaimport.sh)

2) `data` datenset hinzufügen (Model Baker Dataset Manager)
  a)  Zugehörigen Basket erstellen für das jeweilige Daten-Topic, z.B. `'kt_Trockenwiesen_V1_1.kt_Trockenwiesen'`
  b) Basket t_id auf `100` setzen (pgAdmin)

3) Kataloge Importieren (https://github.com/ayomeer/aue_interlis/blob/main/ili2pg/scripts/catalogue_import.sh)

4) Mit `generate_models.py` ili_mirrors, prepare_target und write_to models für das jeweilige Zielschema generieren

5) dbt transformation auf die ili_mirrors hin aufbauen bzw. ili_mirrors anpassen

6) write_to Reihenfolge mit `-- depends_on: ` festlegen 



## Biotoparten und Geometrietypen

### Biotoparten mit Spezifischem Zielschema

| source table  | biotopart                         | target schema                 |
| ------------- | --------------------------------- | ----------------------------- |
| biotope_to_sf | Auengebiet                        | ch_kt_auengebiete             |  
| biotope_to_sf | Amphibienlaichgebiet, Kernbereich | ch_kt_amphibien_laichgebiete  | 
| biotope_to_sf | Amphibienlaichgebiet              | ch_kt_amphibien_laichgebiete  | 
| biotope_to_sf | Hochmoor                          | ch_kt_hochmoore               | 
| biotope_to_sf | Flachmoor                         | ch_kt_flachmoore              | 
| biotope_to_sf | TWW-Magerheuwiese                 | ch_kt_trockenwiesen           | 
| biotope_to_sf | TWW-Magerweide                    | ch_kt_trockenwiesen           | 

### Übrige Biotoparten

Für Biotopflächen Zuweisungsliste nach Lebensraumnummern benutzt -> `seeds/assignment_table_bio_typ.csv`.
Biotoplinien und Punkte werden alle als `"BIO_TYP7; Anderer Biotoptyp"` exportiert.


## Andere Notizen

- `obj_gisflaeche` in INTERLIS Modell lower boundary 1.0 definiert. Damit alle Objekte in das MGDM exportiert werden können, wird die Fläche vorübergehend um 1.0 erhöht. Modelländerung pendent.

> ℹ️ Status Daten DevEnv vs IAP: synched; IAP ahead of PROD.

## TODO

- [ ] fix test fails

- [ ] Transformationen für Linien- und Punktbiotope implementieren, analog zu Flächen-Biotopen
  - [ ] Neue Daten in `prod_gl_biotope` importieren
  - [ ] Staging models auf neue Datenquelle umschreiben und sicherstellen, dass downstream models ihre Attributen füllen können
  - [ ] `transformations.export_to_kantonales_inventar`
  - [ ] `transformations.export_to_pub_gl_biotope`