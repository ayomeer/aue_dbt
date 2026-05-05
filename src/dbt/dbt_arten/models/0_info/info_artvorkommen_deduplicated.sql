{{ config(
	enabled=false 
) }}

SELECT DISTINCT ON (geometrie, funddatum, art_wiss)
	*
FROM {{ source('src_prod_gl_arten', 'orig_artvorkommen') }}
ORDER BY geometrie, funddatum, art_wiss, gid DESC 