{{ config(
  enabled=var('enable_transfer', false),
  post_hook='{{ update_artvorkommen_art_txt(this) }}'
) }}

SELECT *
FROM {{ ref('arvorkommen_art_txt_update_values') }}