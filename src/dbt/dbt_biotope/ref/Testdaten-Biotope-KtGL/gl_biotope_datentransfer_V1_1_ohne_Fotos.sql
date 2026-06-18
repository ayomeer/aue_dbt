/*	
	Transfer- und Umbauskript prod_gl_biotope (flache Tabellen) --> gl_biotope (vglw hoher Abstraktionsgrad)
	
	TODO: Foto_intern befuellen. z.Z. noch keine Daten auf prod_gl_biotope
*/

---------------------------------------------------------------------------------------------------------------------------
-- Datentabellen und Kataloge räumen
---------------------------------------------------------------------------------------------------------------------------

TRUNCATE TABLE
	-- kataloge --
	gl_biotope.bedeutung_catalogue,
	gl_biotope.bedeutung_catref,
	gl_biotope.beschreibung_catalogue,
	gl_biotope.beschreibung_catref,
	gl_biotope.beschreibung_hl_catalogue,
	gl_biotope.datenherkunft_catalogue,
	gl_biotope.datenherkunft_catref,
	gl_biotope.biotopart_catalogue,
	gl_biotope.biotopart_catref,
	gl_biotope.biotyp_catalogue,
	--gl_biotope.biotyp_catref,
	gl_biotope.kartierungsgrundlage_catalogue,
	gl_biotope.kartierungsgrundlage_catref,
	gl_biotope.rechtsstatus_catalogue,
	gl_biotope.rechtsstatus_catref,
	-- interne kataloge
	gl_biotope.datenqualitaet_catalogue,
	gl_biotope.datenqualitaet_catref,
	gl_biotope.beobachter_catalogue,
	gl_biotope.beobachter_catref,
	gl_biotope.spezarten_catalogue,
	gl_biotope.spezarten_catref,
	gl_biotope.substrat_catalogue,
	gl_biotope.substrat_catalogue,
	gl_biotope.substrat_catref,
	-- daten --
	gl_biotope.hochlagen_einheitsflaeche,
	gl_biotope.hochlagen_lebensraum,
	gl_biotope.biotop,
	gl_biotope.teilobjekt,
	gl_biotope.teilobjekt_intern,
	gl_biotope.teilobjektteilobjekt_intern,
	gl_biotope.erfassung_artvorkommen_intern,
	gl_biotope.foto_intern,
	gl_biotope.biotop_national,
	gl_biotope.ueberschneidungnatobjekte;
	
ALTER SEQUENCE gl_biotope.t_ili2db_seq RESTART WITH 100;

---------------------------------------------------------------------------------------------------------------------------
-- Kataloge
---------------------------------------------------------------------------------------------------------------------------

-- HARTKODIERTE KATALOGE (VORGABE BUNDESMODELL) ---------------------------------------------------------------------------
-- Bedeutung
INSERT INTO gl_biotope.bedeutung_catalogue (
	t_basket, bcode, beschrieb, beschrieb_de, beschrieb_fr, beschrieb_it) 
VALUES
	(5, 'B1', 'National', 'National', 'National', 'Nazionale'),
	(5, 'B2', 'Regianal', 'Regianal', 'Régional', 'Regionale'),
	(5, 'B3', 'Regianal', 'Lokal', 'Local', 'Locale');

-- Kartierungsgrundlage
INSERT INTO gl_biotope.kartierungsgrundlage_catalogue (t_basket, kcode, bezeichnung, bezeichnung_de, bezeichnung_fr, bezeichnung_it)
VALUES
	(5, 'K1', 'Landeskarte 1:25000', 'Landeskarte 1:25000', 'Carte nationale 1 :25’000', 'Carta nazionale 1:25’000'),
	(5, 'K2', 'Andere Landeskarte', 'Andere Landeskarte', 'Autre carte nationale', 'Altra carta nazionale'),
	(5, 'K3', 'Kantonale Plangrundlage', 'Kantonale Plangrundlage', 'Base cantonale de planification', 'Base cartografica cantonale'),
	(5, 'K4', 'Luftbild, Orthophoto', 'Luftbild, Orthophoto', 'Photographie arienne, orthophoto', 'Immagine aerea, orthophoto'),
	(5, 'K5', 'andere', 'andere', 'Autres', 'Altri/e'),
	(5, 'K6', 'unbekannt', 'unbekannt', 'Inconnu', 'Sconosciuto');

-- Biotyp	
INSERT INTO gl_biotope.biotyp_catalogue (t_basket, bezeichnung)
VALUES
	(5, 'HM'),
	(5, 'FM'),
	(5, 'TWW'),
	(5, 'TWW A2'),
	(5, 'AL'),
	(5, 'AU'),
	(5, 'AU A2');
	
-- Datenqualitaet 
INSERT INTO gl_biotope.datenqualitaet_catalogue (t_basket, qualitaet)
VALUES 
	(6, 'Pendent'),
	(6, 'Verifiziert'),
	(6, 'Falschmeldung');


-- KATALOGE AUS PROD_GL_BIOTOPE -------------------------------------------------------------------------------------------
-- Herkunft
INSERT INTO gl_biotope.datenherkunft_catalogue (t_basket, herkunft)
SELECT
	5,
	herkunft
FROM prod_gl_biotope.cat_herkunft;
	
-- Rechtsstatus
INSERT INTO gl_biotope.rechtsstatus_catalogue (t_basket, rstatus)
SELECT
	5,
	rechtsstatus
FROM prod_gl_biotope.cat_rechtsstatus;

-- Biotopart
INSERT INTO gl_biotope.biotopart_catalogue (t_basket, bezeichnung)
SELECT	
	5,
	biotopart
FROM prod_gl_biotope.cat_biotopart;

-- Beschreibung
INSERT INTO gl_biotope.beschreibung_catalogue (t_basket, beschreibung_de, beschreibung_la, lebensraumnummer)
SELECT
	5,
	beschreibung_de,
	beschreibung_la,
	lebensraumnummer
FROM prod_gl_biotope.cat_beschreibung;

-- Beobachter (intern)
INSERT INTO gl_biotope.beobachter_catalogue (t_basket, bname)
SELECT 
	6,
	bez_beobachter
FROM prod_gl_biotope.cat_beobachter;

-- Beschreibung Hochlagen
INSERT INTO gl_biotope.beschreibung_hl_catalogue(
	t_basket,
	beschreibung_de, 
	beschreibung_la, 
	lebensraumnummer
)
SELECT
	8,
	beschreibung_de,
	beschreibung_la,
	lebensraumnummer
FROM prod_gl_biotope.cat_beschreibung_hochlagen;


-- KATALOGE AUS PROD_GL_ARTEN ---------------------------------------------------------------------------------------------
-- Spezielle Arten (Umgebautes Subset von prod_gl_arten.cat_art)

/*
	Da der Katalog prod_gL_arten.cat_art keine eindeutige Wertespalte vorhanden ist, muss hier die Beziehung
	zwischen dem prod- und gl-Katalog ueber die ganze Session hinweg zwischengespeichert werden, damit sie auch
	beim Schreiben der Katalogreferenzen in erfassung_artvorkommen_intern noch verfuegbar sind.
*/
DROP TABLE IF EXISTS id_relation_spezarten_session; -- Falls das Skript mehrmals in der gleichen Session ausgefuehrt wird
CREATE TEMPORARY TABLE id_relation_spezarten_session
(
	id_art integer,
	t_id bigint
); -- ohne "ON COMMIT DROP" --> Wird erst am Ende der Session gedroppt (In pgAdmin: Query Fenster geschlossen)
INSERT INTO id_relation_spezarten_session (id_art, t_id)
SELECT 
	id_art,
	nextval('gl_biotope.t_ili2db_seq'::regclass)
FROM prod_gl_arten.cat_art
WHERE spez_art is true;

INSERT INTO gl_biotope.spezarten_catalogue (
	t_id,
	t_basket,
	bez_art_latein,
	bez_art_deutsch,
	rl_status,
	schutzstatus,
	foerdermassnahmen,
	prioritaere_art_ch,
	vorkommen_publiziert,
	art_aus_waldbiostrategie
)
WITH cat_translations as ( -- Umformen in die im Modell gegebenen Werte
	SELECT
		id_art,
		 -- Code in From: XX oder XX(XX) herausfiltern (rl_status aus cat_art haben zum Teil weitere Zeichen)
		(REGEXP_MATCHES(rl_status, '[A-Z]{2}(?:\([A-Z]{2}\))?'))[1] as rl_status,
		-- Zusammensetzen schutzstatus aus Kombination schutz_gl und schutz_ch
		CASE WHEN schutz_ch is not null AND schutz_ch != '' THEN 'Schutz CH' 
		ELSE 
			CASE WHEN schutz_gl = 'ja' THEN 'Schutz GL'
				 WHEN schutz_gl = 'ja 3 Zweige zu eigener Verwendung' THEN 'Schutz GL partiell (3 Zweige)'
				 WHEN schutz_gl = 'ja 5 Stück zu eigener Verwendung'  THEN 'Schutz GL partiell (5 Stück)'
				 WHEN schutz_gl = 'ja Alpenpflanzen' THEN 'Schutz GL partiell Alpenpflanzen'
				 WHEN schutz_gl = 'keine Angabe' THEN null
			END 
		END as schutzstatus,
		CASE WHEN bafu_prioritaet is not null AND bafu_prioritaet != '' THEN true ELSE false 
		END as prio_boolean,
		CASE WHEN art_aus_waldbiostrategie is null OR art_aus_waldbiostrategie = 'keine Angabe'	THEN false ELSE true
		END as art_aus_waldbiostrategie_boolean
	FROM prod_gl_arten.cat_art
)
SELECT
	r.t_id,
	6,
	cat.bez_art_latein,
	cat.bez_art_deutsch,
	ct.rl_status,
	ct.schutzstatus,
	cat.foerdermassnahmen,
	ct.prio_boolean, 					
	vorkommen_publiziert,		
	ct.art_aus_waldbiostrategie_boolean
FROM prod_gl_arten.cat_art 				as cat
LEFT JOIN cat_translations  			as ct ON cat.id_art = ct.id_art
LEFT JOIN id_relation_spezarten_session as r  ON cat.id_art = r.id_art
WHERE spez_art is true;

-- beobachter (aggregiert aus Daten)
INSERT INTO gl_biotope.beobachter_catalogue (t_basket, bname)
SELECT 
	6,
	finder
FROM prod_gl_arten.artvorkommen_gl_pt as pt
WHERE NOT EXISTS ( -- duplikate verhindern (weiter oben schon Werte aus prod_gl_biotope.cat_beobachter eingefuegt)
	SELECT bname   
	FROM gl_biotope.beobachter_catalogue as c
	WHERE pt.finder = c.bname
	GROUP BY bname 
)																	 
GROUP BY finder;

-- Substrat (aggregiert aus Daten)
INSERT INTO gl_biotope.substrat_catalogue (t_basket, bezeichnung)
SELECT 
	6,
	substrat
FROM prod_gl_arten.artvorkommen_gl_pt
GROUP BY substrat;


---------------------------------------------------------------------------------------------------------------------------
-- Biotope: prod-Teilobjekte ueberfuehren in Ueberobjekte und Teilobjekte
---------------------------------------------------------------------------------------------------------------------------
/* 	
	Im dem produktiven Schema werden nur Teilobjekte gefuehrt, welche die Informationen zu dem Biotop als ganzes
	beherbergen. Hier werden diese Informationen zu neuen Ueberobjekten zusammengefasst und die entsprechenden
	Verknuepfungen gemacht. 
	Als erstes werden die IDs fuer alle neuen Objekte  in einer temporaeren Tabelle vergeben, sodass die Relationen 
	schon definiert sind und dann beim INSERT INTO auf diese id-Beziehungen zurueckgegriffen. 
*/


BEGIN TRANSACTION; -- Tabellen 'Biotop' und 'Teilobjekt' muessen in gleicher Transaktion geschrieben werden!

-- zwischenspeichern id relationen. speziell: Neues objekt 'biotop' auf gl-Schema, welches aus Aggregat entsteht --------
CREATE TEMPORARY TABLE id_relations
(
	biotop_tid bigint,
	to_gid integer,
	teilobj_tid bigint,
	teilobj_intern_tid bigint
)
ON COMMIT DROP;

INSERT INTO id_relations (biotop_tid, to_gid, teilobj_tid, teilobj_intern_tid)
WITH gid_aggregate as(
	SELECT 
		nextval('gl_biotope.t_ili2db_seq'::regclass) as biotop_tid,
		array_agg(gid)  as gid_arr
	FROM (
		SELECT objekt_nummer, gid FROM prod_gl_biotope.biotope_to_sf as sf
		WHERE rechtsstatus is not null 										--> TODO: Zeile löschen, wenn bereinigt!
		UNION 
		SELECT objekt_nummer, gid FROM prod_gl_biotope.biotope_to_li as li
		UNION 
		SELECT objekt_nummer, gid FROM prod_gl_biotope.biotope_to_pt as pt) as gids
	GROUP BY objekt_nummer
)
SELECT
	biotop_tid,
	unnest(gid_arr),
	nextval('gl_biotope.t_ili2db_seq'::regclass) as teilobj_tid,
	nextval('gl_biotope.t_ili2db_seq'::regclass) as teilobj_intern_tid
FROM gid_aggregate;


-- DATENTABELLE 'biotop' FUELLEN ----------------------------------------------------------------------------------------
INSERT INTO gl_biotope.biotop  (t_id, t_basket, kanton, objekt_nummer, objekt_name)
WITH biotope_agg as (
	SELECT
		MIN(gid) as rep_gid, -- einzelnes Teilobjekt representativ fuer neues Ueberobjekt (Objektdaten)
		sf.objekt_nummer,
		mode() within group (order by objekt_name) as objekt_name -- haeufigst vorkommenden Namen uebernehmen
	FROM prod_gl_biotope.biotope_to_sf as sf
	WHERE rechtsstatus is not null 										--> TODO: Zeile löschen, wenn bereinigt!
	GROUP BY sf.objekt_nummer
)
SELECT
	r.biotop_tid,
	7,
	'GL',
	b.objekt_nummer,
	b.objekt_name
FROM biotope_agg as b
LEFT JOIN id_relations as r ON b.rep_gid = r.to_gid;


-- DATENTABELLE 'teilobjekt' FUELLEN ------------------------------------------------------------------------------------

INSERT INTO gl_biotope.teilobjekt (
	t_id,
	t_basket,
	t_type,
	von_biotop,
	teilobj_nr,
    teilobj_name,
    biotopart,
    beschreibung,
    herkunft,
    kartierungsgrundlage,
    bedeutung,
    rechtsstatus,
    publikation,
    spezart,
    entscheid,
    flaeche_ha,
	laenge_m,
    geo_obj,	-- Flaechengeometrie
	geo_obj1,	-- Liniengeometrie
	geo_obj2	-- Punktgeometrie
)

-- Flaechenobjekte
SELECT 
	r.teilobj_tid,
	7,
	'to_flaeche', 		--> t_type
	r.biotop_tid,
	sf.teilobj_nr,
	sf.teilobj_name,
	cat3.t_id as catref_biotopart,
	cat8.t_id as catref_beschreibung,
	cat4.t_id as catref_herkunft,
	cat7.t_id as catref_kartierungsgrundlage,
	cat6.t_id as catref_bedeutung,
	cat5.t_id as catref_rechtsstatus,
	sf.publikation,
	sf.spezart,
	sf.entscheid,
	sf.flaeche_m2 *0.0001, -- meter zu hektaren
	null as laenge_m2, -- laenge_m
	sf.geometrie as sf_geometrie,
	null::geometry::geometry as li_geometrie, -- Liniengeometrie
	null::geometry as pt_geometrie -- Punktgeometrie
FROM prod_gl_biotope.biotope_to_sf 					as sf
LEFT JOIN id_relations 								as r	ON sf.gid = r.to_gid
LEFT JOIN prod_gl_biotope.cat_bedeutung 			as cat1 ON sf.bedeutung = cat1.bedeutung
LEFT JOIN prod_gl_biotope.cat_kartierungsgrundlage 	as cat2 ON sf.kartierungsgrundlage = cat2.kartierungsgrundlage
LEFT JOIN gl_biotope.biotopart_catalogue 			as cat3 ON sf.biotopart = cat3.bezeichnung
LEFT JOIN gl_biotope.datenherkunft_catalogue 		as cat4 ON sf.herkunft = cat4.herkunft
LEFT JOIN gl_biotope.rechtsstatus_catalogue 		as cat5 ON sf.rechtsstatus = cat5.rstatus
LEFT JOIN gl_biotope.bedeutung_catalogue 			as cat6 ON cat1.code_bund = cat6.bcode
LEFT JOIN gl_biotope.kartierungsgrundlage_catalogue as cat7 ON cat2.code_bund = cat7.kcode
LEFT JOIN gl_biotope.beschreibung_catalogue 		as cat8 ON sf.lebensraumnummer = cat8.lebensraumnummer
-- Naechste nicht mehr nötig nach Datenbereinigung auf prod_gl_biotope
WHERE sf.biotopart is not null AND sf.rechtsstatus is not null

-- Linienobjekte
UNION SELECT 
	r.teilobj_tid,
	7,
	'to_linie', 		--> t_type
	r.biotop_tid,
	li.teilobj_nr,
	li.teilobj_name,
	cat3.t_id as catref_biotopart,
	cat8.t_id as catref_beschreibung,
	cat4.t_id as catref_herkunft,
	cat7.t_id as catref_kartierungsgrundlage,
	cat6.t_id as catref_bedeutung,
	cat5.t_id as catref_rechtsstatus,
	li.publikation,
	li.spezart,
	li.entscheid,
	null as flaeche_m2,
	laenge_m, -- laenge_m
	null::geometry as sf_geometrie,	-- Flaechengeometrie
	li.geometrie as li_geometrie, 	-- Liniengeometrie
	null::geometry as pt_geometrie 	-- Punktgeometrie
FROM prod_gl_biotope.biotope_to_li 					as li
LEFT JOIN id_relations 								as r	ON li.gid = r.to_gid
LEFT JOIN prod_gl_biotope.cat_bedeutung 			as cat1 ON li.bedeutung = cat1.bedeutung
LEFT JOIN prod_gl_biotope.cat_kartierungsgrundlage 	as cat2 ON li.kartierungsgrundlage = cat2.kartierungsgrundlage
LEFT JOIN gl_biotope.biotopart_catalogue 			as cat3 ON li.biotopart = cat3.bezeichnung
LEFT JOIN gl_biotope.datenherkunft_catalogue 		as cat4 ON li.herkunft = cat4.herkunft
LEFT JOIN gl_biotope.rechtsstatus_catalogue 		as cat5 ON li.rechtsstatus = cat5.rstatus
LEFT JOIN gl_biotope.bedeutung_catalogue 			as cat6 ON cat1.code_bund = cat6.bcode
LEFT JOIN gl_biotope.kartierungsgrundlage_catalogue as cat7 ON cat2.code_bund = cat7.kcode
LEFT JOIN gl_biotope.beschreibung_catalogue 		as cat8 ON li.lebensraumnummer = cat8.lebensraumnummer

-- Punktobjekte
UNION SELECT 
	r.teilobj_tid,
	7,
	'to_punkt', 		--> t_type
	r.biotop_tid,
	pt.teilobj_nr,
	pt.teilobj_name,
	cat3.t_id as catref_biotopart,
	cat8.t_id as catref_beschreibung,
	cat4.t_id as catref_herkunft,
	cat7.t_id as catref_kartierungsgrundlage,
	cat6.t_id as catref_bedeutung,
	cat5.t_id as catref_rechtsstatus,
	pt.publikation,
	pt.spezart,
	pt.entscheid,
	null as flaeche_m2, -- flaeche_m2
	null as laenge_m, -- laenge_m
	null::geometry as sf_geometrie, -- Flaechengeometrie
	null::geometry as li_geometrie, -- Liniengeometrie
	pt.geometrie as pt_geometrie 	-- Punktgeometrie
FROM prod_gl_biotope.biotope_to_pt 					as pt
LEFT JOIN id_relations 								as r	ON pt.gid = r.to_gid
LEFT JOIN prod_gl_biotope.cat_bedeutung 			as cat1 ON pt.bedeutung = cat1.bedeutung
LEFT JOIN prod_gl_biotope.cat_kartierungsgrundlage 	as cat2 ON pt.kartierungsgrundlage = cat2.kartierungsgrundlage
LEFT JOIN gl_biotope.biotopart_catalogue 			as cat3 ON pt.biotopart = cat3.bezeichnung
LEFT JOIN gl_biotope.datenherkunft_catalogue 		as cat4 ON pt.herkunft = cat4.herkunft
LEFT JOIN gl_biotope.rechtsstatus_catalogue 		as cat5 ON pt.rechtsstatus = cat5.rstatus
LEFT JOIN gl_biotope.bedeutung_catalogue 			as cat6 ON cat1.code_bund = cat6.bcode
LEFT JOIN gl_biotope.kartierungsgrundlage_catalogue as cat7 ON cat2.code_bund = cat7.kcode
LEFT JOIN gl_biotope.beschreibung_catalogue 		as cat8 ON pt.lebensraumnummer = cat8.lebensraumnummer;


-- DATENTABELLE 'teilobjekt_intern' FUELLEN -----------------------------------------------------------------------------
INSERT INTO gl_biotope.teilobjekt_intern(
	t_id,
	t_basket,
	nutzung,
	gefaehrdung,
	empfehlung,
	datum_erhebung,
	bearbeiterimfeld,
	kommentar,
	letzte_mutation,
	mutationsgrund
)
SELECT 
	r.teilobj_intern_tid,
	9,
	intern_nutzung,
	intern_gefaehrdung,
	intern_empfehlung,
	intern_datum_erhebung,
	cat1.t_id as catref_bearbeiterimfeld,
	intern_kommentar,
	intern_letzte_mutation,
	intern_mutationsgrund
FROM prod_gl_biotope.biotope_to_sf 			as sf
LEFT JOIN id_relations 						as r 	ON sf.gid = r.to_gid
LEFT JOIN gl_biotope.beobachter_catalogue 	as cat1 ON sf.intern_bearbeiterimfeld = cat1.bname
WHERE rechtsstatus is not null 										--> TODO: Zeile löschen, wenn bereinigt!

UNION SELECT 
	r.teilobj_intern_tid,
	9,
	intern_nutzung,
	intern_gefaehrdung,
	intern_empfehlung,
	intern_datum_erhebung,
	cat1.t_id as catref_bearbeiterimfeld,
	intern_kommentar,
	intern_letzte_mutation,
	intern_mutationsgrund
FROM prod_gl_biotope.biotope_to_li			as li
LEFT JOIN id_relations						as r 	ON li.gid = r.to_gid
LEFT JOIN gl_biotope.beobachter_catalogue 	as cat1 ON li.intern_bearbeiterimfeld = cat1.bname

UNION SELECT 
	r.teilobj_intern_tid,
	9,
	intern_nutzung,
	intern_gefaehrdung,
	intern_empfehlung,
	intern_datum_erhebung,
	cat1.t_id as catref_bearbeiterimfeld,
	intern_kommentar,
	intern_letzte_mutation,
	intern_mutationsgrund
FROM prod_gl_biotope.biotope_to_pt 			as pt
LEFT JOIN id_relations						as r 	ON pt.gid = r.to_gid
LEFT JOIN gl_biotope.beobachter_catalogue 	as cat1 ON pt.intern_bearbeiterimfeld = cat1.bname;

-- VERKNUEPFUNGSTABELLE 'teilobjektteilobjekt_intern' FUELLEN ----------------------------------------------------------
INSERT INTO gl_biotope.teilobjektteilobjekt_intern (
	t_basket,
	hat_interne_daten,		-- ID Teilobjekt_intern
	gehoert_zu_teilobjekt	-- ID Teilobjekt
)
SELECT 
	9,						-- Topic, in dem die Assotiation 'teilobjektteilobjekt_intern' im Modell definiert ist
	teilobj_intern_tid,
	teilobj_tid
FROM id_relations;

COMMIT;


---------------------------------------------------------------------------------------------------------------------------
-- ARTVORKOMMEN
---------------------------------------------------------------------------------------------------------------------------
INSERT INTO gl_biotope.erfassung_artvorkommen_intern (
	t_basket,
	art,
	funddatum,
	substrat,
	beobachter,
	bemerkungen,
	qualitaetskontrolle,
	kommt_vor_in
)
WITH qualitaetskontrolle_bool2catref as (
	SELECT 
		t_id, 
		qualitaet,
		CASE qualitaet WHEN 'Pendent' THEN null
			 WHEN 'Verifiziert' THEN true
			 WHEN 'Falschmeldung' Then false
		END prod_cat_value
	FROM gl_biotope.datenqualitaet_catalogue
)
SELECT 
	9,
	r.t_id,
	pt.funddatum,
	cat2.t_id as catref_substrat,
	cat3.t_id as catref_beobachter,
	pt.bemerkungen,
	q.t_id as catref_datenqualitaet,
	ttoi.hat_interne_daten as fkey_teilobjekt
FROM prod_gl_arten.artvorkommen_gl_pt as pt
INNER JOIN gl_biotope.teilobjekt 					as sf   ON st_within(pt.geometrie, sf.geo_obj)
LEFT JOIN id_relation_spezarten_session				as r    ON pt.id_from_cat_arten = r.id_art
LEFT JOIN gl_biotope.substrat_catalogue 			as cat2 ON pt.substrat = cat2.bezeichnung
LEFT JOIN gl_biotope.beobachter_catalogue 			as cat3 ON pt.finder = cat3.bname
LEFT JOIN qualitaetskontrolle_bool2catref 			as q	ON pt.qualitaetskontrolle = q.prod_cat_value
LEFT JOIN gl_biotope.teilobjektteilobjekt_intern	as ttoi ON sf.t_id = ttoi.gehoert_zu_teilobjekt
WHERE pt.id_from_cat_arten in (SELECT id_art FROM id_relation_spezarten_session);
	
---------------------------------------------------------------------------------------------------------------------------
-- Liste von publizierten und kontrollierten(!) SpezArten in Teilobjekt Attribut 'SpezArt' schreiben
---------------------------------------------------------------------------------------------------------------------------		
UPDATE gl_biotope.teilobjekt as tobj
SET spezart = q.string_spezarten
FROM (
	SELECT 
		ttoi.gehoert_zu_teilobjekt,
		array_to_string(array_agg(DISTINCT cat1.bez_art_deutsch), ', ') as string_spezarten
	FROM gl_biotope.erfassung_artvorkommen_intern 	as av
	LEFT JOIN gl_biotope.spezarten_catalogue 		as cat1 ON av.art = cat1.t_id
	LEFT JOIN gl_biotope.datenqualitaet_catalogue 	as cat2 ON av.qualitaetskontrolle = cat2.t_id
	LEFT JOIN gl_biotope.teilobjektteilobjekt_intern as ttoi ON av.kommt_vor_in = ttoi.hat_interne_daten
	WHERE cat1.vorkommen_publiziert is true AND cat2.qualitaet = 'Verifiziert'
	GROUP BY ttoi.gehoert_zu_teilobjekt
	ORDER BY ttoi.gehoert_zu_teilobjekt
) as q
WHERE tobj.t_id = q.gehoert_zu_teilobjekt;


---------------------------------------------------------------------------------------------------------------------------
-- NATIONALE OBJEKTE 
---------------------------------------------------------------------------------------------------------------------------
BEGIN TRANSACTION; -- Explizites Transaktionsfenster als Zeitfenster fuer TEMP TABLE
-- STAGE DATA ----------------------------------------------------------------------------------------------------------
/* Staging Tabelle mit Geometrie und neu vergebener t_id in gleicher Tabelle, somit Relation ueber Tabellenspalte  */
CREATE TEMPORARY TABLE staging_table
(
	like gl_biotope.biotop_national,
	geom geometry(MultiPolygon,2056),
	gid integer
)
ON COMMIT DROP;

INSERT INTO staging_table (
	t_id, t_basket, bund_nr, bund_name, bund_teilobj_nr, bund_typ, geom, gid)
SELECT
	nextval('gl_biotope.t_ili2db_seq'::regclass),
	7,
	"OBJ" as obj,
	"NAME" as obj_name,
	"TOBJ" as tobj,
	cat.t_id as cat_biotyp,
	the_geom,
	gid
FROM dbu_aue_nls.biotope_national 		as nat
LEFT JOIN gl_biotope.biotyp_catalogue 	as cat ON nat."BIOTYP" = cat.bezeichnung;

-- DATENTABELLE 'biotop_national' FUELLEN ----------------------------------------------------------------------------
INSERT INTO gl_biotope.biotop_national (
	t_id, 
	t_basket, 
	bund_nr, 
	bund_name, 
	bund_teilobj_nr, 
	bund_typ)
SELECT 
	t_id,
	t_basket,
	bund_nr,
	bund_name,
	bund_teilobj_nr,
	bund_typ
FROM staging_table;

-- VERKNUEPFUNGSTABELLE 'ueberschneidungnatobjekte' FUELLEN ------------------------------------------------------------
WITH spacial_join as (
	SELECT 
		gl_to.t_id as gl_to_id, 
		st.t_id    as nat_id
	FROM gl_biotope.teilobjekt 	as gl_to
	INNER JOIN staging_table 	as st ON st_intersects(gl_to.geo_obj, st.geom)
)
INSERT INTO gl_biotope.ueberschneidungnatobjekte (
	t_basket, 
	hat_ueberlagerung,		-- t_id nat-objekt
	ueberlagert_teilobjekt 	-- t_id gl-objekt 
)
SELECT 
	7,
	nat_id,
	gl_to_id
FROM spacial_join;

COMMIT; -- staging_table wird gedropped


---------------------------------------------------------------------------------------------------------------------------
-- Hochlagen
---------------------------------------------------------------------------------------------------------------------------
BEGIN TRANSACTION;
-- Relation alte ids und neue ids zwischenspeichern
CREATE TEMPORARY TABLE id_relation_einheitsflaeche
(
	prod_gid integer,
	gl_t_id integer
)
ON COMMIT DROP;

INSERT INTO id_relation_einheitsflaeche (
	prod_gid,
	gl_t_id
)
SELECT	
	fl.gid, 
	nextval('gl_biotope.t_ili2db_seq'::regclass)
FROM prod_gl_biotope.biotope_hochlagen_einheitsflaeche as fl;

-- Einfuegen Daten Einheitsflaechen
INSERT INTO gl_biotope.hochlagen_einheitsflaeche (
	t_id,
	t_basket,
	bezeichnung,					
	erhebungsjahr,
	geo_obj
)
SELECT 
	r.gl_t_id,
	8,
	erhebungsjahr || '_' || row_number() OVER (PARTITION BY erhebungsjahr
											   ORDER BY st_y(st_centroid(geo_obj)) desc),
	erhebungsjahr,
	geo_obj
FROM prod_gl_biotope.biotope_hochlagen_einheitsflaeche as p
LEFT JOIN id_relation_einheitsflaeche as r ON p.gid = r.prod_gid;


-- Einfuegen Daten Lebensraum
INSERT INTO gl_biotope.hochlagen_lebensraum (
	t_basket,
	beschreibung,
	flaechen_anteil_proz,
	gehoert_zu
)
SELECT
	8,
	cat.t_id as CatRef_beschreibung, 
	flaechen_anteil_proz,
	r.gl_t_id
FROM prod_gl_biotope.biotope_hochlagen_lebensraeume as lr
LEFT JOIN gl_biotope.beschreibung_hl_catalogue as cat ON lr.beschreibung = cat.beschreibung_de
LEFT JOIN id_relation_einheitsflaeche as r ON lr.id_from_einheitsflaeche = r.prod_gid;

COMMIT;

