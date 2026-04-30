-- Skript Nr. 2 - Datentransfer prod_gl_artvorkommen --> wis

-- Transfer Waldameisen
-- Zum Zeitpunkt der erarbeitung des Skripts waren nicht alle Waldameisenarten mit einer ID versehen.
-- Zusätzlich wurden auch Funde der Revierförster mit NULL bei der Qualitaetskontrolle bewertet. Dies
-- Aufgrund der schwierigen Zuordnung von Arten, welche bspw. morphologisch nicht unterscheidbar sind.
-- Aus diesem Grund werden die Waldameisen auch mit Qualitaetskontrolle NULL ins WIS übernommen.

-- Aufgrund der fehlenden ID läuft der Abgleich über den lateinischen Namen.


-- Stand 21. Februar 2022


-- Untergattung Waldameisen importieren

WITH imp as (
		SELECT nextval('prod_gl_arten.wis_artvorkommen_id_seq'::regclass) as id, 
		CASE 
			WHEN "w"."lateinischer name" = 'Formica cf lugubris' THEN 'Formica lugubris'
			WHEN "w"."lateinischer name" = 'Formica cf. lugubris' THEN 'Formica lugubris'
			WHEN "w"."lateinischer name" = 'Formica lugubris' THEN 'Formica lugubris'
			WHEN "w"."lateinischer name" = 'Formica paralugubris' THEN 'Formica paralugubris'
			WHEN "w"."lateinischer name" = 'Formica polyctena' THEN 'Formica polyctena'
			WHEN "w"."lateinischer name" = 'Formica rufa' THEN 'Formica rufa'
			WHEN "w"."lateinischer name" = 'Formica rufa, Gruppe' THEN 'Formica rufa'
			WHEN "w"."lateinischer name" = 'Formica rufa x polyctena' THEN 'Formica rufa'
			WHEN "w"."lateinischer name" = 'Formica sensu stricto' THEN 'Formica sensu stricto'
		END as lateinischer_name,
		CASE 
			WHEN "w"."lateinischer name" = 'Formica cf lugubris' THEN 'Starkbeborstete Gebirgswaldameise'
			WHEN "w"."lateinischer name" = 'Formica cf. lugubris' THEN'Starkbeborstete Gebirgswaldameise'
			WHEN "w"."lateinischer name" = 'Formica lugubris' THEN 'Starkbeborstete Gebirgswaldameise'
			WHEN "w"."lateinischer name" = 'Formica paralugubris' THEN 'Kurzbeborstete Gebirgswaldameise'
			WHEN "w"."lateinischer name" ='Formica polyctena' THEN 'Kahlrücke Waldameise'
			WHEN "w"."lateinischer name" = 'Formica rufa' THEN 'Rote Waldameise'
			WHEN "w"."lateinischer name" = 'Formica rufa, Gruppe' THEN 'Rote Waldameise'
			WHEN "w"."lateinischer name" = 'Formica rufa x polyctena' THEN 'Rote Waldameise'
			WHEN "w"."lateinischer name" = 'Formica sensu stricto' THEN 'Waldameisen (Untergattung)'
		END as deutscher_name,
		w.organismengruppe, 
		'451.1/2' as schutz_status_schweiz,
		'ja' as schutz_status_kt_gl, 
		CASE 
			WHEN "w"."lateinischer name" = 'Formica cf lugubris' THEN 'kA'
			WHEN "w"."lateinischer name" = 'Formica cf. lugubris' THEN'kA'
			WHEN "w"."lateinischer name" = 'Formica lugubris' THEN 'kA'
			WHEN "w"."lateinischer name" = 'Formica paralugubris' THEN 'kA'
			WHEN "w"."lateinischer name" = 'Formica polyctena' THEN 'NT'
			WHEN "w"."lateinischer name" = 'Formica rufa' THEN 'NT'
			WHEN "w"."lateinischer name" ='Formica rufa, Gruppe' THEN 'NT'
			WHEN "w"."lateinischer name" = 'Formica rufa x polyctena' THEN 'NT'
			WHEN "w"."lateinischer name" = 'Formica sensu stricto' THEN 'kA'
		END as rote_liste_status,
       CASE
			WHEN f.radius IS NULL THEN 9999
			ELSE f.radius
       END as radius, 
       CASE
			WHEN f.radius > 50 THEN false	
		ELSE true
       END as genau, 
       w.foerdermassnahmen as foerdermassnahmen,
       CASE
			WHEN f.verwaltungsintern IS NULL THEN true
			ELSE f.verwaltungsintern
       END as verwaltungsintern,
       CASE 
			WHEN f.kantonsintern IS NULL THEN false
			ELSE f.kantonsintern
       END as kantonsintern,
       date('now') as hinzugefuegt_am,
		CASE 
			WHEN "w"."lateinischer name" = 'Formica cf lugubris' THEN 25288
			WHEN "w"."lateinischer name" = 'Formica cf. lugubris' THEN 25288
			WHEN "w"."lateinischer name" = 'Formica lugubris' THEN 25288
			WHEN "w"."lateinischer name" = 'Formica paralugubris' THEN 25291
			WHEN "w"."lateinischer name" = 'Formica polyctena' THEN 25292
			WHEN "w"."lateinischer name" = 'Formica rufa' THEN 86730
			WHEN "w"."lateinischer name" = 'Formica rufa, Gruppe' THEN 86730
			WHEN "w"."lateinischer name" = 'Formica rufa x polyctena' THEN 86730
			WHEN "w"."lateinischer name" = 'Formica sensu stricto' THEN 108121
		END as id_art, 
		ST_SetSRID(ST_Point(f.e,f.n),2056) as geometrie,
       f.bemerkungen, 
       true as status, 
       f.fotos, 
       CASE
			WHEN f.finder IS NULL THEN 'keine Angabe'
			ELSE f.finder
       END as finder, 
       CASE 
			WHEN f.finder = 'Ruedi Zimmermann' and f.funddatum is NULL THEN '1.1.2019'
			ELSE f.funddatum
	   END as funddatum, 
       CASE
			WHEN f.substrat IS NULL THEN 'keine Angabe'
			ELSE f.substrat
       END as substrat
  FROM prod_gl_arten.besondere_waldarten as w 
       join prod_gl_arten.artvorkommen_gl_pt as f on f.art_wiss = "w"."lateinischer name"
WHERE w.wis is true and w.organismengruppe = 'Waldameisen')

INSERT INTO prod_gl_arten.wis_artvorkommen SELECT * FROM imp where imp.genau is true;