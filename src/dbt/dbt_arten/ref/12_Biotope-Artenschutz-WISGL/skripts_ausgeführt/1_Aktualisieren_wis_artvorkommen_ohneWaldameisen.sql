-- Skript Nr. 1 - Datentransfer prod_gl_artvorkommen --> wis
-- Transfer Artendaten nach wis_artvorkommen (OHNE WALDAMEISEN)
-- gemäss den Angaben in der Tabelle besondere_waldarten

-- Stand 21. Februar 2022

-- 1. Vorhandene Daten löschen und Sequenz zurücksetzen
TRUNCATE prod_gl_arten.wis_artvorkommen RESTART IDENTITY;
-- 2. Neue Daten importieren
WITH imp as (
		SELECT nextval('prod_gl_arten.wis_artvorkommen_id_seq'::regclass) as id, 
		"w"."lateinischer name",
		"w"."deutscher name",
		w.organismengruppe, 
       CASE
			WHEN c.schutz_ch IS NULL THEN 'nicht geschuetzt'
			ELSE c.schutz_ch 
       END as schutz_status_schweiz,
       CASE
			WHEN c.schutz_gl IS NULL THEN 'nicht geschuetzt'
			ELSE c.schutz_gl 
       END as schutz_status_kt_gl,
       c.rl_status as rote_liste_status, 
       CASE
			WHEN f.radius IS NULL THEN 9999
			ELSE f.radius
       END as radius, 
       CASE
			WHEN w.organismengruppe = 'Amphibien' and f.radius > 100 THEN false
			WHEN w.organismengruppe = 'Blütenpflanzen' and f.radius > 100 THEN false
			WHEN w.organismengruppe = 'Farne' and f.radius > 100 THEN false
			WHEN w.organismengruppe = 'Flechten' and f.radius > 50 THEN false
			WHEN w.organismengruppe = 'Fledermäuse' and f.radius > 100 THEN false
			WHEN w.organismengruppe = 'Käfer' and f.radius > 50 THEN false
			WHEN w.organismengruppe = 'Moose' and f.radius > 50 THEN false
			WHEN w.organismengruppe = 'Schmetterlinge' and f.radius > 100 THEN false
			WHEN w.organismengruppe = 'Reptilien' and f.radius > 100 THEN false
			WHEN w.organismengruppe = 'Sträucher / Gehölze' and f.radius > 100 THEN false
			WHEN w.organismengruppe = 'Vögel' and f.radius > 1000 THEN false
			WHEN w.organismengruppe = 'Waldameisen' and f.radius > 50 THEN false	
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
       c.id_art,
       ST_SetSRID(ST_Point(f.e,f.n),2056) as geometrie,
       f.bemerkungen, 
       true as status, 
       f.fotos, 
       CASE
			WHEN f.finder IS NULL THEN 'keine Angabe'
			ELSE f.finder
       END as finder, 
       f.funddatum, 
       CASE
			WHEN f.substrat IS NULL THEN 'keine Angabe'
			ELSE f.substrat
       END as substrat
  FROM prod_gl_arten.besondere_waldarten as w 
       join prod_gl_arten.artvorkommen_gl_pt as f on f.id_from_cat_arten = w.id_art
       left join prod_gl_arten.cat_art as c on f.id_from_cat_arten = c.id_art
WHERE f.funddatum > '1.1.1980' and f.qualitaetskontrolle is true and w.wis is true and w.organismengruppe != 'Waldameisen')

INSERT INTO prod_gl_arten.wis_artvorkommen SELECT * FROM imp where imp.genau is true;