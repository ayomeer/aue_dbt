/* 27 Hochmoore
   Datenumbau kantonale Biotopdaten Kt. GL in MGDM BAFU
   2022-12-15, PS/GS KGK-CGC
   ------------------------------------------------------------------------------------------------
*/


/* VORBEREITUNG:
   temp. Hilfsfeld in kt_hochmoor und kt_hochmoor_teilobjekt erstellen (biotop.t_id zur FKEY-Realisierung)
*/
ALTER TABLE IF EXISTS kt_hochmoore.kt_hochmoor ADD COLUMN tmp_fkey character varying
;
ALTER TABLE IF EXISTS kt_hochmoore.kt_hochmoor_teilobjekt ADD COLUMN tmp_fkey character varying
;


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
	teil.biotopart IN /* Katalogeintraege 128 aus biotopart_catalogue */ (128)
)
INSERT INTO kt_hochmoore.kt_hochmoor(t_basket,t_datasetname,t_ili_tid,kanton,objnummer,aname,obj_gisflaeche,herkunft,kartierungsgrundlage,bedeutung,tmp_fkey)
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
	  WHEN tcat.kartierungsgrundlage = 'Landeskarte 1:25000'     THEN 37
	  WHEN tcat.kartierungsgrundlage = 'Andere Landeskarte'      THEN 38
	  WHEN tcat.kartierungsgrundlage = 'Kantonale Plangrundlage' THEN 39
	  WHEN tcat.kartierungsgrundlage = 'Luftbild, Orthophoto'    THEN 40
	  WHEN tcat.kartierungsgrundlage = 'andere'                  THEN 41
	  WHEN tcat.kartierungsgrundlage = 'unbekannt'               THEN 42
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
   Teilobjekte "kt_Hochmoor_Teilobjekt" erzeugen und den Hauptobjekten zuordnen (via tmp_fkey)
*/
INSERT INTO kt_hochmoore.kt_hochmoor_teilobjekt(t_basket,t_datasetname,t_ili_tid,teilobj_nr,kt_hochmoor,tmp_fkey)
  SELECT
    1000
	,'kt_gl'
	,uuid_generate_v4()
	,teil.teilobj_nr
	,hm.t_id
	,teil.t_id -- PK der Quell-Teilobjekte
  FROM
    gl_biotope.teilobjekt teil, kt_hochmoore.kt_hochmoor hm
  WHERE
    teil.biotopart IN /* Katalogeintaege 128 aus biotopart_catalogue */ (128) AND teil.von_biotop::character varying = hm.tmp_fkey
;


/* DRITTER TEIL:
   Geometrie-Objekte "kt_Hochmoore_Geometrie" erzeugen und den Teilobjekten zuordnen (via tmp_fkey)
   Im MGDM des BAFU können mehrere Geometrien zu einem Teilobjekt gebildet werden. In den Quelldaten ist das 1:1
*/
INSERT INTO kt_hochmoore.kt_hochmoor_geometrie(t_basket,t_datasetname,t_ili_tid/*,hm_typ,hm_ke*/,geo_obj,kt_hochmoor_teilobjekt)
  SELECT
    1000
	,'kt_gl'
	,uuid_generate_v4()
	/*, */ -- Abbildung der Hochmoor-Typen offen... (Attribut optional)
	/*, */ -- Abbildung der Kartiereinheiten offen... (Attribut optional)
	,ST_ForceCurve(teil.geo_obj)
	,hmt.t_id
  FROM
    gl_biotope.teilobjekt teil, kt_hochmoore.kt_hochmoor_teilobjekt hmt
  WHERE
    teil.biotopart IN (128) AND teil.t_id::character varying = hmt.tmp_fkey -- damit die Geometrien 1:1 den Teilobjekten zugeordnet werden.
;


/* ABSCHLUSS:
   temp. Hilfsfeld wieder loeschen
*/
ALTER TABLE kt_hochmoore.kt_hochmoor DROP COLUMN tmp_fkey CASCADE
;
ALTER TABLE kt_hochmoore.kt_hochmoor_teilobjekt DROP COLUMN tmp_fkey CASCADE
;

-- ------------------------------------------------------------------------------------------------
