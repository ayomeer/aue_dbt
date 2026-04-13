/* 26 Auengebiete
   Datenumbau kantonale Biotopdaten Kt. GL in MGDM BAFU
   2022-12-15, PS/GS KGK-CGC
   ------------------------------------------------------------------------------------------------
*/


/* VORBEREITUNG:
   temp. Hilfsfeld in kt_auengebiet erstellen (biotop.t_id zur FKEY-Realisierung)
*/
ALTER TABLE IF EXISTS kt_auengebiete.kt_auengebiet ADD COLUMN tmp_fkey character varying;


/* ERSTER TEIL: Hauptobjekte "kt_Auengebiet" erzeugen.
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
	teil.biotopart IN /* Katalogeintraege 132 aus biotopart_catalogue */ (132)
)
INSERT INTO kt_auengebiete.kt_auengebiet(t_basket,t_datasetname,t_ili_tid,kanton,objnummer,aname,obj_gisflaeche/*,au_typ*/,herkunft,kartierungsgrundlage,bedeutung,tmp_fkey)
  SELECT
    1000
	,'kt_gl'
	,uuid_generate_v4()
	,bio.kanton
	,bio.objekt_nummer
	,bio.objekt_name
	,sum(tcat.flaeche_ha) /* kuenstliche Vergroesserung wegen Modellfehler */ +1
	/*, */ -- Abbildung der Auengebiet-Typen offen... (Attribut optional)
	,tcat.herkunft
	,CASE
	  WHEN tcat.kartierungsgrundlage = 'Landeskarte 1:25000'     THEN 11
	  WHEN tcat.kartierungsgrundlage = 'Andere Landeskarte'      THEN 12
	  WHEN tcat.kartierungsgrundlage = 'Kantonale Plangrundlage' THEN 13
	  WHEN tcat.kartierungsgrundlage = 'Luftbild, Orthophoto'    THEN 14
	  WHEN tcat.kartierungsgrundlage = 'andere'                  THEN 15
	  WHEN tcat.kartierungsgrundlage = 'unbekannt'               THEN 16
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
   Teilobjekte "kt_Auengebiet_Teilobjekt" erzeugen und den Hauptobjekten zuordnen (via tmp_fkey)
*/
INSERT INTO kt_auengebiete.kt_auengebiet_teilobjekt(t_basket,t_datasetname,t_ili_tid,teilobj_nr,geo_obj,kt_auengebiet)
  SELECT
    1000
	,'kt_gl'
	,uuid_generate_v4()
	,teil.teilobj_nr
	,ST_ForceCurve(teil.geo_obj)
	,au.t_id
  FROM
    gl_biotope.teilobjekt teil, kt_auengebiete.kt_auengebiet au
  WHERE
    teil.biotopart IN /* Katalogeintaege 132 aus biotopart_catalogue */ (132) AND teil.von_biotop::character varying = au.tmp_fkey
;


/* ABSCHLUSS:
   temp. Hilfsfeld wieder loeschen
*/
ALTER TABLE kt_auengebiete.kt_auengebiet DROP COLUMN tmp_fkey CASCADE
;

-- ------------------------------------------------------------------------------------------------
