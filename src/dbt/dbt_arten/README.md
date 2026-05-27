
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
This will make it so deduplication logic is consistent across artvorkommen and export script and there will be less to no diff. There may also be more objects in export after this.
- [x] create update job to write id_art based on art_wiss
  - This doesn't affect wisgl export
  - [x] run job on prod
- [x] check deduplication loss in wisgl_export
  - it's because PZ's script manually assigns id_art based on latin names.


**optimization after pressing issues are done**
- [x] refactor to decouple audits from transfer models, create new graph starting from sources for audits
- [x] refactor to use tags instead of variables that enable/disable models
  - makes them show up in lineage viewer and docs
  - choosing to still use variable to enable transfer models for safety
- [ ] address issues that were observed when going through export process.
  - catalog mismatch between prod_gl_arten and wisgl
  --> how are id_art 
- [x] rename job models to be more descriptive
- [x] add descriptions to models
  - re-deploy docs to netlify page
- [x] Create custom docs overview page