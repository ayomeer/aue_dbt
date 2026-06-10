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
  w.genau as genauigkeit_ausreichend,
  w.status as biotopstatus,
  w.id::numeric as id_gl_aus_import,
  now()::date as last_modified,
  '{{target.user}}'::varchar as last_user,
  --oid_uuid generated automatically on insert (DEFAULT value)
  w.id_art as id_from_cat_arten,
  w.x_koord as e,
  w.y_koord as n,
  hinzugefuegt_am::date as dat_hinzugefuegt_am, -- if NULL: generated automatically on insert (DEFAULT value)
  NULL::boolean as neobiot,
  true::boolean as qualitaetskontrolle, -- explicitly true, so it fulfills export criteria for export back to wisgl
  cat.vdc_taxon_id as taxonidch,
  NULL::integer ext_hoehe,
  NULL::varchar as gemeinde_kt_glarus,
  NULL::boolean as loeschmarkierung,
  w.geometrie
FROM {{ ref('stg_imp_wisgl_besonderearten') }} as w
LEFT JOIN {{ ref('stg_cat_art') }} as cat
  ON cat.id_art = w.id_art

