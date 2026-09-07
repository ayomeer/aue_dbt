-- Returned rows will be updated with latin and german names from corresponding to
-- their linked cat_art entry.
SELECT
    a.gid,
    a.art_wiss,
    c.name_lateinisch as new_art_wiss,
    a.art_deutsch,
    split_part(c.name_deutsch, ', ', 1) as new_art_deutsch,
    c.id_art
FROM {{ ref('stg_artvorkommen') }} as a
LEFT JOIN {{ ref('stg_cat_art') }} as c 
    ON a.id_from_cat_arten = c.id_art
WHERE a.id_from_cat_arten is not null
  AND c.name_deutsch is not null AND c.name_deutsch <> ''
  AND name_deutsch is distinct from art_deutsch
ORDER BY art_deutsch