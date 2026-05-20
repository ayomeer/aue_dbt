-- Remove possible duplicates introduced by UNION in previous models
-- only necessary, if 

SELECT DISTINCT ON (geometrie, funddatum, id_art)
	*
FROM {{ ref('extract_and_reformat_waldarten') }}
ORDER BY geometrie, funddatum, id_art, id DESC 