{{ config(
  materialized='table'
) }}
-- Aggregates 'arten' within a given 'biotope_sf' object filtered by 
-- field 'pub_in_biotopverzeichnis' 
WITH base as (
  SELECT
    p.gid as p_gid,
    p.art_deutsch,
    p.art_wiss,
    sf.gid as sf_gid,
    sf.objekt_nummer,
    sf.teilobj_nr
  FROM (
    SELECT * 
    FROM {{ source('prod_gl_arten', 'artvorkommen_gl_pt') }} as a
    LEFT JOIN prod_gl_arten.cat_art as c 
      ON c.bez_art_latein = a.art_wiss
    WHERE 
      c.spez_art is true AND
      c.pub_in_biotopverzeichnis is true
  ) as p
  LEFT JOIN {{ ref('stg_biotope_to_sf') }} as sf
    ON ST_Within(p.geometrie, sf.geometrie)
  WHERE sf.gid is not null
)
SELECT
  sf_gid,
  array_agg(distinct art_deutsch) as arr_art_deutsch,
  array_agg(distinct art_wiss) as arr_art_wiss
FROM base
GROUP BY sf_gid