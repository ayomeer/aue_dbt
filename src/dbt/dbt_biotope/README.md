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


## TODO

Schemas erzeugen und dbt trafo job definieren:

- [x] kt_amphibien_laichgebiete   Data Validation successful ✅
- [x] kt_amphibien_wanderobjekte  No data
- [x] kt_auengebiete              Data Validation successful ✅
- [x] kt_biotope_flaechen         Data Validation failed: bedeutung National issue -> Anahita is looking at data
- [x] kt_biotope_linien           Data Validation successful ✅
- [x] kt_biotope_punkte           Data Validation successful ✅
- [x] kt_flachmoore               Data Validation successful ✅
- [x] kt_hochmoore                Data Validation failed: Handful of geometry errors to fix
- [x] kt_trockenwiesen            Data Validation failed: one intersection issue
=> We get new data anyways

- [x] add t_ili_tid uuids to all objects so ili validators doesn't complain
- [x] re-import non-amphibien schemas with updated script that has `--createDatasetCol` option enabled and add column to export scripts
