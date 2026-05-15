
# prod_gl_arten

## Important to know about prod_gl_arten

- The column `id_art` in the table `besondere_waldarten` referrs to `id_art` in `cat_art`
- `besondere_waldarten` is a subset of `cat_art`

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


#### Upsert Strategy

- Match on (geometrie, funddatum, art_wiss) composite key
- If updating, don't overwrite the following columns:
  - ext_herkunft, ext_label, copyright


#### Audits

<!-- TODO: explain output table columns -->

## TODO

**Deduplication**
- [x] Deploy deduplicated version on IAP/PROD via backup
  - [x] Check with Viktor

**import WISGL data**
- [x] Make UPSERT observable
  - [x] Create data diff audit, which compares before and after upsert
  - [x] Create test to catch bad data before trying to insert


**deliver dataset to Daniel**
- [x] re-compute wis_artvorkommen table with now updated artvorkommen_gl_pt 
- [x] do last renaming tasks in PZ Skript NR.3
- [x] fix foerdermassnahmen being clipped
  - [x] fixed foerdermassnahmen that were imported incorrectly
  - [x] checked, that all 79 remaining foerdermassnahmen mismatches stem from string from being shorter in _geopackage_ (`row_shown=old`)
- [ ] check other column changes


**optimization after pressing issues are done**
- [ ] refactor to use tags instead of variables that enable/disable models