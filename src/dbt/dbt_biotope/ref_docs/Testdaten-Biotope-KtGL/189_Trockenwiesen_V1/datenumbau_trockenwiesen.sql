/* 189 Trockenwiesen und -weiden
   Datenumbau kantonale Biotopdaten Kt. GL in MGDM BAFU
   2022-12-12, PS/GS KGK-CGC
   ------------------------------------------------------------------------------------------------
*/


/* VORBEREITUNG:
   temp. Hilfsfeld in kt_trockenwiese erstellen (biotop.t_id zur FKEY-Realisierung)
*/
ALTER TABLE IF EXISTS kt_trockenwiesen.kt_trockenwiese ADD COLUMN tmp_fkey character varying;


/* ERSTER TEIL: Hauptobjekte "kt_Trockenwiese" erzeugen.
   Katalogeintraege zu Teilobjekten joinen,
   dann Teilobjekte mit Hauptobjekten verbunden, Hektarflaechen summieren, Daten in Zieltabelle schreiben.
*/
WITH tcat AS (
  SELECT
	teil.von_biotop
	,teil.teilobj_nr
	,ba_cat.bezeichnung AS biotopart
	,hk_cat.herkunft
	,kg_cat.bezeichnung AS kartierungsgrundlage
	,be_cat.beschrieb AS bedeutung
	,teil.flaeche_ha
  FROM
	gl_biotope.teilobjekt teil
	LEFT JOIN gl_biotope.biotopart_catalogue ba_cat ON teil.biotopart = ba_cat.t_id
	  LEFT JOIN gl_biotope.datenherkunft_catalogue hk_cat ON teil.herkunft = hk_cat.t_id
	    LEFT JOIN gl_biotope.kartierungsgrundlage_catalogue kg_cat ON teil.kartierungsgrundlage = kg_cat.t_id
	      LEFT JOIN gl_biotope.bedeutung_catalogue be_cat ON teil.bedeutung = be_cat.t_id
  WHERE
	teil.biotopart IN /* Katalogeintraege 130, 131 aus biotopart_catalogue */ (130,131)
)
INSERT INTO kt_trockenwiesen.kt_trockenwiese(t_basket,t_datasetname,t_ili_tid,kanton,objnummer,aname,obj_gisflaeche,herkunft,kartierungsgrundlage,bedeutung,tmp_fkey)
  SELECT
    3
	,'kt_gl'
	,uuid_generate_v4()
	,bio.kanton
	,bio.objekt_nummer
	,bio.objekt_name
	,sum(tcat.flaeche_ha) /* kuenstliche Vergroesserung wegen Modellfehler */ +1
	,tcat.herkunft
	,CASE
	  WHEN tcat.kartierungsgrundlage = 'Landeskarte 1:25000'     THEN 8
	  WHEN tcat.kartierungsgrundlage = 'Andere Landeskarte'      THEN 9
	  WHEN tcat.kartierungsgrundlage = 'Kantonale Plangrundlage' THEN 10
	  WHEN tcat.kartierungsgrundlage = 'Luftbild, Orthophoto'    THEN 11
	  WHEN tcat.kartierungsgrundlage = 'andere'                  THEN 13
	  WHEN tcat.kartierungsgrundlage = 'unbekannt'               THEN 14
	END
	,CASE
	  WHEN tcat.bedeutung = 'National' THEN 5
	  WHEN tcat.bedeutung = 'Regional' THEN 5
	  WHEN tcat.bedeutung = 'Lokal'    THEN 6
	END
	,tcat.von_biotop
  FROM
    tcat LEFT JOIN gl_biotope.biotop bio ON tcat.von_biotop = bio.t_id
  GROUP BY 
    tcat.von_biotop
	,bio.kanton,bio.objekt_nummer,bio.objekt_name,tcat.biotopart,tcat.herkunft,tcat.kartierungsgrundlage,tcat.bedeutung
  ORDER BY
    tcat.von_biotop
;


/* ZWEITER TEIL: 
   Teilobjekte "kt_Trockenwiese_Teilobjekt" erzeugen und den Hauptobjekten zuordnen (via tmp_fkey)
*/
INSERT INTO kt_trockenwiesen.kt_trockenwiese_teilobjekt(t_basket,t_datasetname,t_ili_tid,teilobj_nr,geo_obj,kt_trockenwiese)
  SELECT
    3
	,'kt_gl'
	,uuid_generate_v4()
	,teil.teilobj_nr
	,ST_Force3D(ST_ForceCurve((ST_Dump(teil.geo_obj)).geom))
	,tww.t_id
  FROM
    gl_biotope.teilobjekt teil, kt_trockenwiesen.kt_trockenwiese tww
  WHERE
    teil.biotopart IN /* Katalogeintaege 130, 131 aus biotopart_catalogue */ (130,131) AND teil.von_biotop::character varying = tww.tmp_fkey
;


/* ABSCHLUSS:
   temp. Hilfsfeld wieder loeschen
*/
ALTER TABLE kt_trockenwiesen.kt_trockenwiese DROP COLUMN tmp_fkey CASCADE
;

-- ------------------------------------------------------------------------------------------------
