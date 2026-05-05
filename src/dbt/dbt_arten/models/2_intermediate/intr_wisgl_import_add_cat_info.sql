-- Join besondere_waldarten info onto WIS import

{{ config (enabled=false)}}

SELECT
  wis.name_deutsch,
  wis_name_lateinisch
FROM {{ ref('stg_imp_wisgl_besonderearten') }} as wis
LEFT JOIN {{ ref('stg_cat_art') }} as cat
  ON cat.id_art = wis_imp.id_art