-- Skript Nr. 4 - Datentransfer prod_gl_artvorkommen --> wis
-- Transfer augsgewählter Spalten von wis_artvorkommen nach gl_besonderewaldarten.besonderearten (Schema mit INTERLIS-Modell)

-- Stand 09.02.22


-- 1. Vorhandene Daten gl_besonderewaldarten löschen
TRUNCATE gl_besonderewaldarten.besonderearten RESTART IDENTITY;  

-- 2. Ausgewählte Daten importieren
INSERT INTO gl_besonderewaldarten.besonderearten(
  t_basket,
  id_art,
  name_d,
  name_lat,
  organismengruppe,
  schutz_ch,
  schutz_gl,
  roteliste,
  radius,
  genau,
  substrat,
  foerdermassnahmen,
  finder,
  funddatum,
  hinzugefuegt_am,
  kantonsintern,
  verwaltungsintern,
  astatus,
  bemerkungen,
  fotos,
  geometrie,
) 
SELECT   
	1,
	id_art,
	deutscher_name,
	lateinischer_name,
	organismengruppe,
	schutz_status_schweiz,
	schutz_status_kt_gl,
	rote_liste_status,
	radius,
	genau,
	substrat,
	foerderungsmassnahmen,
	finder,
	funddatum,
	hinzugefuegt_am,
	kantonsintern,
	verwaltungsintern,
	status,
	bemerkungen,
	fotos, 
	geometrie
FROM prod_gl_arten.wis_artvorkommen 