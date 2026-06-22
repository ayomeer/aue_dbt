-- test fails if string would be clipped
SELECT
  herkunft
FROM {{ ref('stg_biotope_to_sf') }}
WHERE LENGTH(herkunft) > 80