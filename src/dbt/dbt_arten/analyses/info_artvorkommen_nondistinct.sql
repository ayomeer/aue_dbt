-- This query returns artvorkommen_gl_pt objects, which are not distinct from
-- every other one based on the composite key (geometrie, funddatum, 
-- id_from_cat_arten). This is primarily a result of id_from_cat_arten being 
-- null instead of containing the id corresponding to the species described in
-- the columns art_deutsch and art_wiss.

WITH nondistinct as (
  SELECT 
    row_number() over() as dup_id,
    array_agg(gid) as gids,
    geometrie,
    funddatum,
    id_from_cat_arten as id_art,
    COUNT(*) as cnt
  FROM {{ ref('stg_artvorkommen') }}
  GROUP BY geometrie, funddatum, id_from_cat_arten
  HAVING COUNT(*) > 1
),
unnested_gids as (
  SELECT 
    unnest(gids) as gid,
    dup_id
  FROM nondistinct
)
SELECT 
  n.dup_id,
  id_from_cat_arten as id_art,
  funddatum,
  geometrie,
  art_deutsch,
  art_wiss
FROM {{ ref('stg_artvorkommen') }} as a 
JOIN unnested_gids as n 
  ON n.gid = a.gid 

ORDER BY 
  dup_id,
  id_from_cat_arten,
  funddatum,
  geometrie