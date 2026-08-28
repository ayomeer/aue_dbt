-- test fails if string would be clipped
-- (for example in )
SELECT
  herkunft
FROM {{ ref('stg_biotope_to_sf') }}
WHERE LENGTH(herkunft) > 250