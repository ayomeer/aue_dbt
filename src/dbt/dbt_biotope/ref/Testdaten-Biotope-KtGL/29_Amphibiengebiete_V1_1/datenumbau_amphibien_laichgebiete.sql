/* 29.1 Amphibien-Laichgebiete
   Datenumbau kantonale Biotopdaten Kt. GL in MGDM BAFU
   2022-12-15, PS/GS KGK-CGC
   ------------------------------------------------------------------------------------------------
*/


/* VORBEREITUNG:
   temp. Hilfsfeld in kt_amphibiengebiet erstellen (biotop.t_id zur FKEY-Realisierung)
*/
ALTER TABLE IF EXISTS kt_amphibien_laichgebiete.kt_amphibiengebiet ADD COLUMN tmp_fkey character varying;


/* ERSTER TEIL: Hauptobjekte "kt_Amphibiengebiet" erzeugen.
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
	,CASE
	  WHEN teil.flaeche_ha IS NULL THEN 1.000
	  ELSE teil.flaeche_ha
	END
  FROM
	gl_biotope.teilobjekt teil
	LEFT JOIN gl_biotope.biotopart_catalogue ba_cat ON teil.biotopart = ba_cat.t_id
	  LEFT JOIN gl_biotope.datenherkunft_catalogue hk_cat ON teil.herkunft = hk_cat.t_id
	    LEFT JOIN gl_biotope.kartierungsgrundlage_catalogue kg_cat ON teil.kartierungsgrundlage = kg_cat.t_id
	      LEFT JOIN gl_biotope.bedeutung_catalogue be_cat ON teil.bedeutung = be_cat.t_id
  WHERE
	teil.biotopart IN /* Katalogeintraege 126, 167 aus biotopart_catalogue */ (126,127)
)
INSERT INTO kt_amphibien_laichgebiete.kt_amphibiengebiet(t_basket,t_datasetname,t_ili_tid,kanton,objnummer,aname,obj_gisflaeche,herkunft,kartierungsgrundlage,bedeutung,tmp_fkey)
  SELECT
    1000
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
	  WHEN tcat.kartierungsgrundlage = 'andere'                  THEN 12
	  WHEN tcat.kartierungsgrundlage = 'unbekannt'               THEN 13
	END
	,CASE
	  WHEN tcat.bedeutung = 'National' THEN 3
	  WHEN tcat.bedeutung = 'Regional' THEN 4
	  WHEN tcat.bedeutung = 'Lokal'    THEN 5
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
   Teilobjekte "kt_Amphibiengebiet_Teilobjekt" erzeugen und den Hauptobjekten zuordnen (via tmp_fkey)
*/
INSERT INTO kt_amphibien_laichgebiete.kt_amphibiengebiet_teilobjekt(t_basket,t_datasetname,t_ili_tid,teilobj_nr,am_l_bereich,geo_obj,kt_amphibiengebiet)
  SELECT
    1000
	,'kt_gl'
	,uuid_generate_v4()
	,teil.teilobj_nr
	,CASE /* Kern- und angrenzende Bereiche differenzieren */
	  WHEN teil.biotopart = 126 THEN 6
	  WHEN teil.biotopart = 127 THEN 7
	END
	,ST_Force3D(ST_ForceCurve(teil.geo_obj))
	,ag.t_id
  FROM
    gl_biotope.teilobjekt teil, kt_amphibien_laichgebiete.kt_amphibiengebiet ag
  WHERE
    teil.biotopart IN /* Katalogeintaege 126,127 aus biotopart_catalogue */ (126,127) AND teil.von_biotop::character varying = ag.tmp_fkey
;


/* ABSCHLUSS:
   temp. Hilfsfeld wieder loeschen
*/
ALTER TABLE kt_amphibien_laichgebiete.kt_amphibiengebiet DROP COLUMN tmp_fkey CASCADE
;

-- ------------------------------------------------------------------------------------------------
