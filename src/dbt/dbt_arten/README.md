
# prod_gl_arten

## Important to know about prod_gl_arten

- The column `id_art` in the table `besondere_waldarten` referrs to `id_art` in `cat_art`
- `besondere_waldarten` is a subset of `cat_art`

## Pipelines

### WISGL Data Synchronization

1) Update `prod_gl_arten.artvorkommen_gl_pt` with data from `besonderewaldarten.besonderearten`
2) Re-compute `prod_gl_arten.wis_artvorkommen`
3) Replace `besonderewaldarten.besonderearten` data with `prod_gl_arten.wis_artvorkommen` data (truncate and insert)

**sources**:
- `prod_gl_arten`
  - `artvorkommen_gl_pt`
  - `cat_art`

- `imp_wisgl_besonderewaldarten`

**target tables**:
- `gl_besonderewaldarten.besonderearten`: This is where dept. Wald 


#### Upsert Strategy

- Match on (geometrie, funddatum, id_art) composite key
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
- [x] check other column changes


**fix missing id_art in artvorkommen**
- [ ] create update job to write cat_art based on art_wiss
  - make id_art NOT NULL once cleaned up
- [ ] run job on prod

**check removed duplicates on art_wiss again**

**optimization after pressing issues are done**
- [ ] refactor to decouple audits from transfer models, create new graph starting from sources for audits
- [ ] refactor to use tags instead of variables that enable/disable models
  - makes them show up in lineage viewer and docs
- [ ] address issues that were observed when going through export process.
- [ ] rename job models to be more descriptive
- [ ] add descriptions to models