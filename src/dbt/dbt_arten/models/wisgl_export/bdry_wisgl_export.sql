
SELECT   
  -- t_id generated automatically on insert
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
FROM {{ ref('intr_wisgl_export_dedup') }}