-- depends_on: {{ ref('snapshot_artvorkommen_pre_update_id_art') }}

{{ config(
  post_hook='{{ update_artvorkommen_id_art(this) }}'
) }}

SELECT
  art.gid,
  art.art_deutsch,
  art.art_wiss,
  cat.name_lateinisch,
  cat.name_deutsch,
  cat.id_art
FROM {{ ref('stg_artvorkommen') }} as art
LEFT JOIN {{ ref('stg_cat_art') }} as cat
  ON lower(cat.name_lateinisch) = (art.art_wiss)
WHERE id_from_cat_arten is null and art_wiss is not null
  AND cat.id_art is not null
