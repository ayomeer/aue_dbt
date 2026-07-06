{{ config(
  materialized='table',
  post_hook= '{{
    update_lebensraumnummer(
      source_model=this,
      target_table="biotope_to_sf"
    )
  }}'
)}}

SELECT 
  gid,
	biotopart,
	beschreibung,
	sf.lebensraumnummer,
  split_part(sf.beschreibung, ' ', 1) as split_part_1,
  substring(beschreibung, 7) as substring_beschreibung
FROM {{ source('prod_gl_biotope', 'biotope_to_sf') }} as sf
WHERE 
  sf.lebensraumnummer is null AND
  sf.beschreibung is not null AND
  split_part(sf.beschreibung, ' ', 1) ~ '^.{1,2}(\..{1,2})*$'
  
