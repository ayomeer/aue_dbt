{{ config(materialized='table') }}

SELECT
  COALESCE(
    wisgl_id,
    MAX(wisgl_id) OVER () + row_number() OVER (partition by wisgl_id is null ORDER BY gid)  
  ) as t_id,
  {# COALESCE(
    wisgl_id,
    MAX(wisgl_id) OVER () 
    + COUNT(*) FILTER (WHERE wisgl_id IS NULL) OVER ()
  ) as t_id_alt, #}
	{{ var('baskets')['default_basket']['t_id'] }} as t_basket,
	-- t_ili_tid generated automatically on insert
    id_art,
	name_deutsch as name_d,
	name_lateinisch name_lat,
	organismengruppe,
	schutz_status_schweiz as schutz_ch,
	schutz_status_kt_gl as schutz_gl,
	rote_liste_status as roteliste,
	radius,
	genau,
	substrat,
	foerdermassnahmen,
	finder,
	funddatum,
	hinzugefuegt_am,
	kantonsintern,
	verwaltungsintern,
	status as astatus,
	bemerkungen,
	fotos, 
	geometrie
FROM {{ ref('deduplicate') }}
ORDER BY wisgl_id, t_id