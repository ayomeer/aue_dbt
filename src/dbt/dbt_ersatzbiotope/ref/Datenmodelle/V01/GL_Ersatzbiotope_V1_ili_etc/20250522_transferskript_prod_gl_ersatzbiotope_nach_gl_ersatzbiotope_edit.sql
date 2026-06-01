/*	
	Transfer- und Umbauskript prod_gl_ersatzbiotope (flache Tabellen) --> gl_ersatzbiotope (vglw hoher Abstraktionsgrad)
*/

---------------------------------------------------------------------------------------------------------------------------
-- Datentabellen und Kataloge räumen
---------------------------------------------------------------------------------------------------------------------------

TRUNCATE TABLE
	-- kataloge --
	gl_ersatzbiotope.ersatzmassnahme_item, --?
	gl_ersatzbiotope.ersatzmassnahme_catref,
	-- daten --
	gl_ersatzbiotope.ersatzbiotop,
	gl_ersatzbiotope.to_flaeche,
	gl_ersatzbiotope.to_linie,
	gl_ersatzbiotope.to_punkt
CASCADE
;
-- -- Query returned successfully in 45 secs 625 msec.

ALTER SEQUENCE gl_ersatzbiotope.t_ili2db_seq RESTART WITH 100;
-- -- Query returned successfully in 65 msec.
---------------------------------------------------------------------------------------------------------------------------
-- Kataloge
---------------------------------------------------------------------------------------------------------------------------

-- KATALOGE AUS PROD_GL_ERSATZBIOTOPE -------------------------------------------------------------------------------------------
-- Ersatzmassnahmen_Item(Kategorie)
INSERT INTO gl_ersatzbiotope.ersatzmassnahme_item (t_basket, t_ili_tid, massnahmenkategorie)
SELECT
	33,
	gen_random_uuid (),
	trim(kategorie) as massnahmenkategorie
FROM prod_gl_ersatzbiotope.cat_kategorie;

-- -- Query returned successfully in 71 msec.
---------------------------------------------------------------------------------------------------------------------------
-- Ersatzbiotope: prod-Teilobjekte ueberfuehren in Ueberobjekte und Teilobjekte
---------------------------------------------------------------------------------------------------------------------------
/* 	
	Im dem produktiven Schema werden nur Teilobjekte gefuehrt, welche die Informationen zu dem Ersatzbiotop als ganzes
	beherbergen. Hier werden diese Informationen zu neuen Ueberobjekten zusammengefasst und die entsprechenden
	Verknuepfungen gemacht. 
	In einem ersten Schritt werden die Objektdaten aus den Teilobjekttabellen für Flächen-, Linien und Punktobjekte in den
	produktiven Daten zusammengefasst und dann gruppiert. Unterschiedliche Einträge in den Teilobjekten führen zu mehreren
	Datensätzen pro Objekt --> Prüfen und eventuell korrigieren.
*/

with allobj as
(
	-- surface objects
	select
		objekt_nummer, entscheide, dokumente, projekttraeger
	from prod_gl_ersatzbiotope.ersatzbiotope_sf
	group by objekt_nummer, entscheide, dokumente, projekttraeger 
	
	union
	
	-- line objects
	select
	objekt_nummer, entscheide, dokumente, projekttraeger
	from prod_gl_ersatzbiotope.ersatzbiotope_li
	group by objekt_nummer, entscheide, dokumente, projekttraeger
	
	union
	
	-- point objects
	select
	objekt_nummer, entscheide, dokumente, projekttraeger
	from prod_gl_ersatzbiotope.ersatzbiotope_pt
	group by objekt_nummer, entscheide, dokumente, projekttraeger
	order by objekt_nummer, entscheide, dokumente, projekttraeger
),
zusobj as
(
	select 
		nextval('gl_ersatzbiotope.t_ili2db_seq'::regclass) as t_id,
		31::integer as t_basket,
		uuid_generate_v4() as t_ili_tid,
		14::integer as kanton,
		objekt_nummer, 
		entscheide, 
		dokumente, 
		projekttraeger
	from allobj
)
insert into gl_ersatzbiotope.ersatzbiotop select * from zusobj
;
-- -- Query returned successfully in 76 msec

-- DATENTABELLE 'to_flaeche' FUELLEN ------------------------------------------------------------------------------------
-- Anmerkung: Die Fläche der Objekte wird neu berechnet

INSERT INTO gl_ersatzbiotope.to_flaeche (
	t_id, 
	t_basket, 
	t_ili_tid, 
	flaeche_m2, 
	geo_obj, 
	teilobj_nr, 
	kategorie_ersatzmassnahme, 
	ersatzmassnahme, 
	ziellebensraum, 
	ersatzbiotop
)
SELECT
	nextval('gl_ersatzbiotope.t_ili2db_seq'::regclass) as t_id,
	31::integer as t_basket,
	uuid_generate_v4() as t_ili_tid,
	st_area(the_geom) as flaeche_m2,
	sf.the_geom as geo_obj,
	sf.teilobjekt_nummer as teilobj_nr,
	cat1.t_id as kategorie_ersatzmassnahme,
	sf.ersatzmassnahme,
	sf.ziellebensraum,
	ebio.t_id as ersatzbiotop
from prod_gl_ersatzbiotope.ersatzbiotope_sf as sf
left join gl_ersatzbiotope.ersatzmassnahme_item as cat1 on trim(sf.kategorie_ersatzmassnahme) = trim(cat1.massnahmenkategorie)
left join gl_ersatzbiotope.ersatzbiotop as ebio on sf.objekt_nummer = ebio.objekt_nummer; 
-- ^ /!\ Da objekt_nummer in ebio nicht eindeutig, werden Teilobjekte aufgefächert !!!
 

-- DATENTABELLE 'to_linie' FUELLEN ------------------------------------------------------------------------------------
-- Anmerkung: Die Länge der Objekte wird neu berechnet

-- INSERT INTO gl_ersatzbiotope.to_linie
--     (
-- 	t_id, 
-- 	t_basket, 
-- 	t_ili_tid, 
-- 	laenge_m, 
-- 	geo_obj, 
-- 	teilobj_nr, 
-- 	kategorie_ersatzmassnahme, 
-- 	ersatzmassnahme, 
-- 	ziellebensraum, 
-- 	von_ersatzbiotop)
-- SELECT
--     nextval('gl_ersatzbiotope.t_ili2db_seq'::regclass) as t_id,
-- 	33::integer as t_basket,
--     gen_random_uuid () as t_ili_tid,
-- 	st_length(the_geom) as laenge_m,
--     the_geom as geo_obj,
-- 	teilobj_nr,
-- 	cat1.t_id as kategorie_ersatzmassnahme,
-- 	ersatzmassnahme,
-- 	ziellebensraum,
-- 	ebio.t_id as von_ersatzbiotop
-- from prod_gl_ersatzbiotope.ersatzbiotope_li as li
-- left join gl_ersatzbiotope.ersatzmassnahme_item as cat1 on trim(li.kategorie_ersatzmassnahme) = trim(cat1.massnahmenkategorie)
-- left join gl_ersatzbiotope.ersatzbiotop as ebio on li.objekt_nummer = ebio.objekt_nummer;

-- -- DATENTABELLE 'to_punkt' FUELLEN ------------------------------------------------------------------------------------

-- INSERT INTO gl_ersatzbiotope.to_punkt
--     (
-- 	t_id, 
-- 	t_basket, 
-- 	t_ili_tid,  
-- 	geo_obj, 
-- 	teilobj_nr, 
-- 	kategorie_ersatzmassnahme, 
-- 	ersatzmassnahme, 
-- 	ziellebensraum, 
-- 	von_ersatzbiotop)
-- SELECT
--     nextval('gl_ersatzbiotope.t_ili2db_seq'::regclass) as t_id,
-- 	33::integer as t_basket,
--     gen_random_uuid () as t_ili_tid,
--     the_geom as geo_obj,
-- 	teilobj_nr,
-- 	cat1.t_id as kategorie_ersatzmassnahme,
-- 	ersatzmassnahme,
-- 	ziellebensraum,
-- 	ebio.t_id as von_ersatzbiotop
-- from prod_gl_ersatzbiotope.ersatzbiotope_pt as pt
-- left join gl_ersatzbiotope.ersatzmassnahme_item as cat1 on trim(pt.kategorie_ersatzmassnahme) = trim(cat1.massnahmenkategorie)
-- left join gl_ersatzbiotope.ersatzbiotop as ebio on pt.objekt_nummer = ebio.objekt_nummer;

-- -- -- Query returned successfully in 206 msec.
