
  create view "test_db"."dbt_arten"."bdry_wis_update__dbt_tmp"
    
    
  as (
    SELECT
  -- gid generated automatically on insert (DEFAULT value)
  w.name_deutsch as art_deutsch,
  w.name_lateinisch as art_wiss,
  cat.spez_art as spezart,
  w.substrat,
  w.radius,
  NULL::varchar as ext_label,
  'WISGL Datenimport ' || extract(year from now())::varchar as ext_herkunft,
  'Kanton Glarus' as copyright,
  w.funddatum,
  w.finder,
  w.kantonsintern,
  w.verwaltungsintern,
  w.bemerkungen,
  w.fotos,
  w.genauigkeit_ausreichend,
  w.biotopstatus,
  w.id::numeric as id_gl_aus_import,
  now()::date as last_modified,
  'postgres'::varchar as last_user,
  --oid_uuid generated automatically on insert (DEFAULT value)
  w.id_from_cat_arten,
  w.x_koord as e,
  w.y_koord as n,
  -- dat_hinzugefuegt_am generated automatically on insert (DEFAULT value)
  NULL::boolean as neobiot,
  NULL::boolean as qualitaetskontrolle,
  cat.vdc_taxon_id as taxonidch,
  NULL::integer ext_hoehe,
  NULL::varchar as gemeinde_kt_glarus,
  NULL::boolean as loeschmarkierung,
  w.geometrie
FROM "test_db"."dbt_arten"."stg_imp_wisgl_besonderearten" as w
LEFT JOIN "test_db"."dbt_arten"."stg_cat_art" as cat
  ON cat.id_art = w.id_from_cat_arten
  );