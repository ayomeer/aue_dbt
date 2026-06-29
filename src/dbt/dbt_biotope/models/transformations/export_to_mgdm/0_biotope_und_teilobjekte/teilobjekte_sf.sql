{{ config(materialized='table') }}

SELECT
  sf.objekt_nummer,
  sf.teilobj_nr::varchar(30),
  sf.biotopart,
  sf.geometrie as geo_obj,
  b.t_id as t_id_biotop
FROM {{ ref('stg_biotope_to_sf') }} sf
LEFT JOIN {{ ref('biotope_sf') }}  as b
  ON sf.gid = ANY(b.link_key_array)
WHERE b.t_id is not null -- (can be null because of area > 1ha filter in biotope_sf)
