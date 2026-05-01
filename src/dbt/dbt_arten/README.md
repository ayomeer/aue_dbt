Welcome to your new dbt project!
# prod_gl_arten

## Pipelines

### WISGL Datensynchronisation

1) Update `prod_gl_arten.artvorkommen_gl_pt` with data from `besonderewaldarten.besonderearten`
2) Re-compute `prod_gl_arten.wis_artvorkommen`
3) Replace `besonderewaldarten.besonderearten` data with `prod_gl_arten.wis_artvorkommen` data (truncate and insert)

**sources**:
- `prod_gl_arten`
  - `artvorkommen_gl_pt`
  - `cat_art`

- `besonderewaldarten.besonderearten` 

**target tables**:
- `prod_gl_arten.wis_artvorkommen`


#### Upserting Strategy





## TODO

**import WISGL data**
- [ ] 
- [ ] Define tests for successful upsert

**Deduplication**
- [ ] Deploy deduplicated version on IAP/PROD
