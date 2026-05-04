{{ config(
  enabled=var('enable_transfer', false),
  post_hook='{{ ili_utils.upsert_into("prod_gl_arten", "artvorkommen_gl_pt", "geometrie, funddatum, art_wiss") }}'
) }}

SELECT * FROM {{ ref('bdry_wis_update') }}