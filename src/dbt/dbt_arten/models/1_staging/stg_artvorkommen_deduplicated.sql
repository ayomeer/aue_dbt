{{ config(
	materialized='table',
	enabled=false 
) }}

SELECT DISTINCT ON (geometrie, funddatum, art_wiss)
	*
FROM {{ ref('stg_artvorkommen') }}
ORDER BY geometrie, funddatum, art_wiss, gid DESC 