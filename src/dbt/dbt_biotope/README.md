Welcome to your new dbt project!

# dbt_biotope




## Relation to Schemas outside of dbt Project

`prod_gl_biotope` acts as the data source for this project (see sources.yaml)

Data products get exported to the following schema:
- `ch_kt_auengebiete`
- `ch_kt_biotope_flaechen`
- `ch_kt_biotope_linien`
- `ch_kt_biotope_punkte`
- `ch_kt_flachmoore`
- `ch_kt_hochmoore`
- `ch_kt_trockenwiesen`

## TODO

- Set up additional source schemas according to excel file 'Erstdatetransfer' on local DB (need either backups from viktor or permissions.. from viktor)
  - dbu_aue_nls.biotope_national
  - prod_gl_arten

  
**Additional nice to haves:**
- Python script for creating sources.yml from prod schema name 