{{ config(
  materialized='table'
) }}
-- Aggregates 'arten' within a given 'biotope_sf' object filtered by 
-- field 'pub_in_biotopverzeichnis' 
WITH base as (
  SELECT
    a.gid as a_gid,
    split_part(c.bez_art_deutsch, ',', 1) as bez_art_deutsch, -- use only first name given in catalogue
    c.bez_art_latein,
    sf.gid as sf_gid,
    sf.objekt_nummer,
    sf.teilobj_nr
  FROM {{ source('prod_gl_arten', 'artvorkommen_gl_pt') }} as a
  LEFT JOIN {{ source('prod_gl_arten', 'cat_art') }} as c 
    ON c.id_art = a.id_from_cat_arten
  LEFT JOIN {{ ref('stg_biotope_to_sf') }} as sf
    ON ST_Within(a.geometrie, sf.geometrie)
  WHERE sf.gid is not null
    AND c.spez_art is true 
    AND c.pub_in_biotopverzeichnis is true
)
SELECT
  sf_gid,
  array_agg(distinct bez_art_deutsch) as arr_art_deutsch,
  array_agg(distinct bez_art_latein) as arr_art_wiss
FROM base
GROUP BY sf_gid