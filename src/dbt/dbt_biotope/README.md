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
| biotope_to_sf | Amphibienlaichgebiet              | ch_kt_amphibien_wanderobjekte | 
| biotope_to_sf | Hochmoor                          | ch_kt_hochmoore               | 
| biotope_to_sf | Flachmoor                         | ch_kt_flachmoore              | 
| biotope_to_sf | TWW-Magerheuwiese                 | ch_kt_trockenwiesen           | 
| biotope_to_sf | TWW-Magerweide                    | ch_kt_trockenwiesen           | 

### Übrige Biotoparten

Zuweisungsliste nach Lebensraumnummern benutzen!

#### Flächen

target schema: `ch_kt_biotope_flaechen`

| source table  | biotopart                         | bio_typ  |
| ------------- | --------------------------------- | -------- |
| biotope_to_sf | Feldgehölz                        | BIO_TYP7 |
| biotope_to_sf | Stehende Gewässer                 | BIO_TYP1 |
| biotope_to_sf | Hecke                             | BIO_TYP7 |
| biotope_to_sf | Schützenswerte Waldgesellschaft   | BIO_TYP3 |
| biotope_to_sf | Artenschutzfläche                 | BIO_TYP7 |
| biotope_to_sf | Andere schützenswerte Lebensräume | BIO_TYP7 |
| biotope_to_sf | Andere                            | BIO_TYP7 |
| biotope_to_sf | Pufferzone                        | BIO_TYP7 |

#### Linen

target schema: `ch_kt_biotope_linien`

| source table  | biotopart                         | bio_typ  |
| ------------- | --------------------------------- | -------- |
| biotope_to_li | Hecke                             | BIO_TYP6 |
| biotope_to_li | Trockenmauer                      | BIO_TYP6 |

#### Punkte

target schema: `ch_kt_biotope_punkte`

| source table  | biotopart                         | bio_typ  |
| ------------- | --------------------------------- | -------- |
| biotope_to_pt | Artvorkommen                      | BIO_TYP7 |
| biotope_to_pt | Biotopbäume                       | BIO_TYP7 |
| biotope_to_pt | Pilzvorkommen                     | BIO_TYP7 |


## Andere Notizen

- `obj_gisflaeche` in INTERLIS Modell lower boundary 1.0 definiert. Damit alle Objekte in das MGDM exportiert werden können, wird die Fläche vorübergehend um 1.0 erhöht. Modelländerung pendent.


## TODO

Schemas erzeugen und dbt trafo job definieren:

- [ ] kt_amphibien_laichgebiete
- [ ] kt_amphibien_wanderobjekte
- [x] kt_auengebiete
- [x] kt_biotope_flaechen
- [ ] kt_biotope_linien
- [x] kt_biotope_punkte
- [x] kt_flachmoore
- [x] kt_hochmoore
- [x] kt_trockenwiesen

- [ ] add t_ili_tid uuids to all objects so ili validators doesn't complain