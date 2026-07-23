-- Remove possible duplicates introduced by UNION in previous models
-- only necessary, if 

SELECT DISTINCT ON (geometrie, funddatum, id_art)
	*
FROM {{ ref('union_besondere_arten') }}
ORDER BY geometrie, funddatum, id_art, (ext_wisgl_id is not NULL) DESC 