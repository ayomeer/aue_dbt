
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