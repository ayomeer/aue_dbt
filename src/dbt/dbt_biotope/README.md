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

- biotope_to_li 
  - 'Hecke'
  - 'Trockenmauer'

- biotope_to_pt
  - Artvorkommen
  - Biotopbäume
  - Pilzvorkommen

- biotope_to_sf
  - 'Schützenswerte Waldgesellschaft'
  - 'Auengebiet'
  - 'Amphibienlaichgebiet, Kernbereich'
  - 'Amphibienlaichgebiet'
  - 'Hochmoor'
  - 'Flachmoor'
  - 'TWW-Magerheuwiese'
  - 'TWW-Magerweide'
  - 'Pufferzone'
  - 'Feldgehölz'
  - 'Stehende Gewässer'
  - 'Artenschutzfläche'
  - **'Hecke'**
  - 'Andere schützenswerte Lebensräume'
  - 'Andere'

## TODO

Schemas erzeugen und dbt trafo job definieren:

- [ ] kt_amphibien_laichgebiete
- [ ] kt_amphibien_wanderobjekte
- [x] kt_auengebiete
- [ ] kt_biotope_flaechen
- [ ] kt_biotope_linien
- [ ] kt_biotope_punkte
- [x] kt_flachmoore
- [x] kt_hochmoore
- [ ] kt_trockenwiesen