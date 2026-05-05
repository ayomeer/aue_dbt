-- Remove possible duplicates introduced by UNION in previous models

SELECT DISTINCT ON (geometrie, funddatum, name_lateinisch)
	*
FROM {{ ref('intr_wisgl_export') }}
ORDER BY geometrie, funddatum, name_lateinisch, id DESC 