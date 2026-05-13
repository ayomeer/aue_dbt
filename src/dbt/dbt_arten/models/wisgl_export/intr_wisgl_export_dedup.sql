-- Remove possible duplicates introduced by UNION in previous models

SELECT DISTINCT ON (geometrie, funddatum, id_art)
	*
FROM {{ ref('intr_wisgl_export') }}
ORDER BY geometrie, funddatum, id_art, id DESC 