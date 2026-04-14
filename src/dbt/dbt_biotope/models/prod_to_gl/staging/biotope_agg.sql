	SELECT
		MIN(gid) as rep_gid, -- einzelnes Teilobjekt representativ fuer neues Ueberobjekt (Objektdaten)
		sf.objekt_nummer,
		mode() within group (order by objekt_name) as objekt_name -- haeufigst vorkommenden Namen uebernehmen
	FROM {{ source('src_prod_gl_biotope', 'biotope_to_sf') }} as sf
	WHERE rechtsstatus is not null 										--> TODO: Zeile löschen, wenn bereinigt!
	GROUP BY sf.objekt_nummer