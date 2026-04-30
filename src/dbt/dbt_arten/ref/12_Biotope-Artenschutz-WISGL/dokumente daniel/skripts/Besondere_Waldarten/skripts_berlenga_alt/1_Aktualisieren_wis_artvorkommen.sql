-- Transfer Artendaten nach wis_artvorkommen
-- gemäss den Angaben in der Tabelle besondere_waldarten
-- Stand 24. März 2021

-- 1. Vorhandene Daten löschen und Sequenz zurücksetzen
TRUNCATE prod_gl_arten.wis_artvorkommen RESTART IDENTITY;
-- 2. Neue Daten importieren
WITH imp as (
       SELECT nextval('prod_gl_arten.wis_artvorkommen_id_seq'::regclass) as id, 
       f.art_wiss as lateinischer_name, 
       f.art_deutsch as deutscher_name, 
       w.organismengruppe, 
       c.schutz_ch as schutz_status_schweiz, 
       c.schutz_gl as schutz_status_kt_gl, 
       c.rl_status as rote_liste_status, 
       f.radius, 
       CASE
           WHEN w.organismengruppe = 'Blütenpflanzen' and f.radius > 100 THEN false
	   WHEN w.organismengruppe = 'Farne' and f.radius > 100 THEN false
	   WHEN w.organismengruppe = 'Flechten' and f.radius > 50 THEN false
	   WHEN w.organismengruppe = 'Käfer' and f.radius > 50 THEN false
	   WHEN w.organismengruppe = 'Moose' and f.radius > 50 THEN false
	   WHEN w.organismengruppe = 'Sträucher / Gehölze' and f.radius > 100 THEN false
	   WHEN w.organismengruppe = 'Vögel' and f.radius > 1000 THEN false
	   WHEN w.organismengruppe = 'Amphibien' and f.radius > 100 THEN false
	   WHEN w.organismengruppe = 'Reptilien' and f.radius > 100 THEN false
	   WHEN w.organismengruppe = 'Fledermäuse' and f.radius > 100 THEN false
	   WHEN w.organismengruppe = 'Schmetterlinge' and f.radius > 100 THEN false
           ELSE true
       END as genau, 
       'Im Wald: '||w.foerdermassnahmen as foerdermassnahmen,
       case
	   when f.verwaltungsintern is null then true
	   else f.verwaltungsintern
       end as verwaltungsintern,
       f.kantonsintern,
       date('now') as hinzugefuegt_am,
       c.id_art,
       ST_SetSRID(ST_Point(f.e,f.n),2056) as geometrie,
       f.bemerkungen, 
       f.status, 
       f.fotos, 
       f.finder, 
       f.funddatum, 
       f.substrat
  FROM prod_gl_arten.besondere_waldarten as w 
       join prod_gl_arten.artvorkommen_gl_pt as f on f.id_from_cat_arten = w.id_art
       left join prod_gl_arten.cat_art as c on f.id_from_cat_arten = c.id_art
 WHERE f.funddatum > '1.1.1980' and w.wis is true)
INSERT INTO prod_gl_arten.wis_artvorkommen SELECT * FROM imp where imp.genau is true;