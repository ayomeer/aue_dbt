-- Publication Data: pub_gl_biotope.biotope_flaechen / .biotope_linien / .biotope_punkte / .hochlagenbiotope

-- INSERT INTO pub_gl_biotope.t_ili2db_dataset(t_id,datasetname) SELECT 1,'biotope';
-- INSERT INTO pub_gl_biotope.t_ili2db_basket(t_id,dataset,topic,t_ili_tid,attachmentkey) SELECT 2,1,'GL_Biotope_Publikation_V1.Bio','590a9c3f-6730-4606-bf96-b350d1d72e29','x';
ALTER SEQUENCE pub_gl_biotope.t_ili2db_seq RESTART WITH 10;

TRUNCATE pub_gl_biotope.biotope_flaechen CASCADE;
TRUNCATE pub_gl_biotope.biotope_linien CASCADE;
TRUNCATE pub_gl_biotope.biotope_punkte CASCADE;
TRUNCATE pub_gl_biotope.hochlagenbiotope CASCADE;

/* BIOTOPE FLAECHEN */

INSERT INTO pub_gl_biotope.biotope_flaechen 
  (
    t_basket
    ,t_ili_tid
    ,flaeche_ha,geometrie -- Spezialisierung Geometrie
    ,kanton,objekt_nummer,objekt_name -- Basisobjekt "Biotop"
    ,bund_nummer,bund_name,bund_teilobjekt_nummer,bund_typ -- Nationale Objekte
    ,teilobjekt_nummer
    ,teilobjekt_name
    ,biotopart
    ,beschreibung
    ,herkunft
    ,kartierungsgrundlage
    ,bedeutung
    ,rechtsstatus
    ,spezielle_arten
    ,entscheid
  )
  WITH 
    nat_c AS (
      SELECT
        n.t_id
        ,n.bund_nr
        ,n.bund_name
        ,n.bund_teilobj_nr
        ,c.bezeichnung as bund_typ -- Katalog "biotyp_catalogue"
      FROM gl_biotope.nationales_objekt n 
      LEFT JOIN gl_biotope.biotyp_catalogue c ON n.bund_typ = c.t_id
    )
    ,tonb AS (
      SELECT
        t.*
        ,array_to_string(array_agg(DISTINCT n.bund_nr),', ') AS bund_nr
        ,array_to_string(array_agg(DISTINCT n.bund_name),', ') AS bund_name
        ,array_to_string(array_agg(DISTINCT n.bund_teilobj_nr),', ') AS bund_teilobj_nr
        ,array_to_string(array_agg(DISTINCT n.bund_typ),', ') AS bund_typ
      FROM gl_biotope.teilobjekt t 
      LEFT JOIN gl_biotope.ueberschneidungnatobjekte u ON u.ueberlagert_teilobjekt = t.t_id
      LEFT JOIN nat_c n ON u.hat_ueberlagerung = n.t_id
      WHERE
        t.publikation='TRUE'
      GROUP BY
        t.t_id,t.t_basket,t_type,t.t_ili_tid,t.teilobj_nr,t.teilobj_name,t.biotopart,t.beschreibung,t.herkunft,t.kartierungsgrundlage,t.bedeutung,t.rechtsstatus,t.spezart,t.entscheid,t.von_biotop,t.flaeche_ha,t.geo_obj,t.laenge_m,t.geo_obj1,t.geo_obj2
    )
  SELECT 
    2
    ,t.t_ili_tid::uuid
    ,round((ST_Area(t.geo_obj)/10000)::numeric,3)
    ,t.geo_obj
    ,b.kanton
    ,b.objekt_nummer
    ,b.objekt_name
    ,t.bund_nr
    ,t.bund_name
    ,t.bund_teilobj_nr
    ,t.bund_typ
    ,t.teilobj_nr
    ,t.teilobj_name
    ,c2.bezeichnung -- Katalog "biotopart_catalogue"
    ,c3.lebensraumnummer || ' - ' || c3.beschreibung_de || '/' || c3.beschreibung_la -- Katalog "beschreibung_catalogue"
    ,c4.herkunft -- Katalog "datenherkunft_catalogue"
    ,c5.kcode || ' - ' || c5.bezeichnung_de -- Katalog "kartierungsgrundlage_catalogue"
    ,c6.bcode || ' - ' || c6.beschrieb_de -- Katalog "bedeutung_catalogue"
    ,c7.rstatus -- Katalog "rechtsstatus_catalogue"
    ,t.spezart
    ,t.entscheid
  FROM tonb t LEFT JOIN gl_biotope.biotop b ON t.von_biotop = b.t_id
  LEFT JOIN gl_biotope.biotopart_catalogue c2 ON t.biotopart = c2.t_id
  LEFT JOIN gl_biotope.beschreibung_catalogue c3 ON t.beschreibung = c3.t_id
  LEFT JOIN gl_biotope.datenherkunft_catalogue c4 ON t.herkunft = c4.t_id
  LEFT JOIN gl_biotope.kartierungsgrundlage_catalogue c5 ON t.kartierungsgrundlage = c5.t_id
  LEFT JOIN gl_biotope.bedeutung_catalogue c6 ON t.bedeutung = c6.t_id
  LEFT JOIN gl_biotope.rechtsstatus_catalogue c7 ON t.rechtsstatus = c7.t_id
  WHERE 
    t.geo_obj IS NOT NULL
;

/* BIOTOPE LINIEN */

INSERT INTO pub_gl_biotope.biotope_linien 
  (
    t_basket
    ,t_ili_tid
    ,laenge_m,geometrie -- Spezialisierung Geometrie
    ,kanton,objekt_nummer,objekt_name -- Basisobjekt "Biotop"
    ,bund_nummer,bund_name,bund_teilobjekt_nummer,bund_typ -- Nationale Objekte
    ,teilobjekt_nummer
    ,teilobjekt_name
    ,biotopart
    ,beschreibung
    ,herkunft
    ,kartierungsgrundlage
    ,bedeutung
    ,rechtsstatus
    ,spezielle_arten
    ,entscheid
  )
  WITH 
    nat_c AS (
      SELECT
        n.t_id
        ,n.bund_nr
        ,n.bund_name
        ,n.bund_teilobj_nr
        ,c.bezeichnung as bund_typ -- Katalog "biotyp_catalogue"
      FROM
        gl_biotope.nationales_objekt n LEFT JOIN gl_biotope.biotyp_catalogue c ON n.bund_typ = c.t_id
    )
    ,tonb AS (
      SELECT
        t.*
        ,array_to_string(array_agg(DISTINCT n.bund_nr),', ') AS bund_nr
        ,array_to_string(array_agg(DISTINCT n.bund_name),', ') AS bund_name
        ,array_to_string(array_agg(DISTINCT n.bund_teilobj_nr),', ') AS bund_teilobj_nr
        ,array_to_string(array_agg(DISTINCT n.bund_typ),', ') AS bund_typ
      FROM
        (gl_biotope.teilobjekt t LEFT JOIN gl_biotope.ueberschneidungnatobjekte u ON u.ueberlagert_teilobjekt = t.t_id)
          LEFT JOIN nat_c n ON u.hat_ueberlagerung = n.t_id
      WHERE
        t.publikation='TRUE'
      GROUP BY
        t.t_id,t.t_basket,t_type,t.t_ili_tid,t.teilobj_nr,t.teilobj_name,t.biotopart,t.beschreibung,t.herkunft,t.kartierungsgrundlage,t.bedeutung,t.rechtsstatus,t.spezart,t.entscheid,t.von_biotop,t.flaeche_ha,t.geo_obj,t.laenge_m,t.geo_obj1,t.geo_obj2
    )
  SELECT 
    2
    ,t.t_ili_tid::uuid
    ,round(ST_Length(t.geo_obj1)::numeric,3)
    ,t.geo_obj1
    ,b.kanton
    ,b.objekt_nummer
    ,b.objekt_name
    ,t.bund_nr
    ,t.bund_name
    ,t.bund_teilobj_nr
    ,t.bund_typ
    ,t.teilobj_nr
    ,t.teilobj_name
    ,c2.bezeichnung -- Katalog "biotopart_catalogue"
    ,c3.lebensraumnummer || ' - ' || c3.beschreibung_de || '/' || c3.beschreibung_la -- Katalog "beschreibung_catalogue"
    ,c4.herkunft -- Katalog "datenherkunft_catalogue"
    ,c5.kcode || ' - ' || c5.bezeichnung_de -- Katalog "kartierungsgrundlage_catalogue"
    ,c6.bcode || ' - ' || c6.beschrieb_de -- Katalog "bedeutung_catalogue"
    ,c7.rstatus -- Katalog "rechtsstatus_catalogue"
    ,t.spezart
    ,t.entscheid
  FROM 
    ((((((tonb t LEFT JOIN gl_biotope.biotop b ON t.von_biotop = b.t_id)
      LEFT JOIN gl_biotope.biotopart_catalogue c2 ON t.biotopart = c2.t_id)
        LEFT JOIN gl_biotope.beschreibung_catalogue c3 ON t.beschreibung = c3.t_id)
          LEFT JOIN gl_biotope.datenherkunft_catalogue c4 ON t.herkunft = c4.t_id)
            LEFT JOIN gl_biotope.kartierungsgrundlage_catalogue c5 ON t.kartierungsgrundlage = c5.t_id)
              LEFT JOIN gl_biotope.bedeutung_catalogue c6 ON t.bedeutung = c6.t_id)
                LEFT JOIN gl_biotope.rechtsstatus_catalogue c7 ON t.rechtsstatus = c7.t_id
  WHERE 
    t.geo_obj1 IS NOT NULL
;

/* BIOTOPE PUNKTE */

INSERT INTO pub_gl_biotope.biotope_punkte
  (
    t_basket
    ,t_ili_tid
    ,geometrie -- Spezialisierung Geometrie
    ,kanton,objekt_nummer,objekt_name -- Basisobjekt "Biotop"
    ,bund_nummer,bund_name,bund_teilobjekt_nummer,bund_typ -- Nationale Objekte
    ,teilobjekt_nummer
    ,teilobjekt_name
    ,biotopart
    ,beschreibung
    ,herkunft
    ,kartierungsgrundlage
    ,bedeutung
    ,rechtsstatus
    ,spezielle_arten
    ,entscheid
  )
  WITH 
    nat_c AS (
      SELECT
        n.t_id
        ,n.bund_nr
        ,n.bund_name
        ,n.bund_teilobj_nr
        ,c.bezeichnung as bund_typ -- Katalog "biotyp_catalogue"
      FROM
        gl_biotope.nationales_objekt n LEFT JOIN gl_biotope.biotyp_catalogue c ON n.bund_typ = c.t_id
    )
    ,tonb AS (
      SELECT
        t.*
        ,array_to_string(array_agg(DISTINCT n.bund_nr),', ') AS bund_nr
        ,array_to_string(array_agg(DISTINCT n.bund_name),', ') AS bund_name
        ,array_to_string(array_agg(DISTINCT n.bund_teilobj_nr),', ') AS bund_teilobj_nr
        ,array_to_string(array_agg(DISTINCT n.bund_typ),', ') AS bund_typ
      FROM
        (gl_biotope.teilobjekt t LEFT JOIN gl_biotope.ueberschneidungnatobjekte u ON u.ueberlagert_teilobjekt = t.t_id)
          LEFT JOIN nat_c n ON u.hat_ueberlagerung = n.t_id
      WHERE
        t.publikation='TRUE'
      GROUP BY
        t.t_id,t.t_basket,t_type,t.t_ili_tid,t.teilobj_nr,t.teilobj_name,t.biotopart,t.beschreibung,t.herkunft,t.kartierungsgrundlage,t.bedeutung,t.rechtsstatus,t.spezart,t.entscheid,t.von_biotop,t.flaeche_ha,t.geo_obj,t.laenge_m,t.geo_obj1,t.geo_obj2
    )
  SELECT 
    2
    ,t.t_ili_tid::uuid
    ,t.geo_obj2
    ,b.kanton
    ,b.objekt_nummer
    ,b.objekt_name
    ,t.bund_nr
    ,t.bund_name
    ,t.bund_teilobj_nr
    ,t.bund_typ
    ,t.teilobj_nr
    ,t.teilobj_name
    ,c2.bezeichnung -- Katalog "biotopart_catalogue"
    ,c3.lebensraumnummer || ' - ' || c3.beschreibung_de || '/' || c3.beschreibung_la -- Katalog "beschreibung_catalogue"
    ,c4.herkunft -- Katalog "datenherkunft_catalogue"
    ,c5.kcode || ' - ' || c5.bezeichnung_de -- Katalog "kartierungsgrundlage_catalogue"
    ,c6.bcode || ' - ' || c6.beschrieb_de -- Katalog "bedeutung_catalogue"
    ,c7.rstatus -- Katalog "rechtsstatus_catalogue"
    ,t.spezart
    ,t.entscheid
  FROM 
    ((((((tonb t LEFT JOIN gl_biotope.biotop b ON t.von_biotop = b.t_id)
      LEFT JOIN gl_biotope.biotopart_catalogue c2 ON t.biotopart = c2.t_id)
        LEFT JOIN gl_biotope.beschreibung_catalogue c3 ON t.beschreibung = c3.t_id)
          LEFT JOIN gl_biotope.datenherkunft_catalogue c4 ON t.herkunft = c4.t_id)
            LEFT JOIN gl_biotope.kartierungsgrundlage_catalogue c5 ON t.kartierungsgrundlage = c5.t_id)
              LEFT JOIN gl_biotope.bedeutung_catalogue c6 ON t.bedeutung = c6.t_id)
                LEFT JOIN gl_biotope.rechtsstatus_catalogue c7 ON t.rechtsstatus = c7.t_id
  WHERE 
    t.geo_obj2 IS NOT NULL
;

/* HOCHLAGENBIOTOPE */

INSERT INTO pub_gl_biotope.hochlagenbiotope
  (
    t_basket
    ,t_ili_tid
    ,bezeichnung
    ,erhebungsjahr
    ,beschreibung_lebensraeume
    ,anteil_schuetzenswerte_lebensraeume
    ,geometrie

  )
  WITH 
    h1 AS (
      SELECT 
        hlr.t_id
        ,c.lebensraumnummer || ' - ' || c.beschreibung_de || '/' || c.beschreibung_la || ' (' || hlr.flaechen_anteil_proz || '%)' AS lebensraum_beschreibung
        ,CASE 
          WHEN c.lebensraumnummer IN ( 
            '0.0',
            '4.3.3.2', -- Rostseggenhalde (artenarm)
            '4.3.5.2', -- Borstgrasweiden (artenarm)
            '4.5.2',   -- Goldhaferwiese
            '4.5.3',   -- Kammgrasweide
            '4.5.3.2', -- Kammgrasweide (artenarm)
            '4.5.4',   -- Milchkrautweide
            '4.5.4.2', -- Milchkrautweide (artenarm)
            '5.2.3',   -- Hochgrasflur des Gebirges
            '5.2.3.2', -- Hochgrasflur (artenarm)
            '5.2.5',   -- Adlerfarnflur
            '6',       -- Wald
            '7.1.7'    -- Lägerflur
          ) THEN 0
          ELSE hlr.flaechen_anteil_proz
        END AS prozent_anrechenbar
        ,hlr.gehoert_zu
      FROM
        gl_biotope.hochlagen_lebensraum hlr LEFT JOIN gl_biotope.beschreibung_hl_catalogue c ON hlr.beschreibung = c.t_id
    )
  SELECT 
    2
    ,hef.t_ili_tid
    ,hef.bezeichnung
    ,hef.erhebungsjahr
    ,array_to_string(array_agg(h1.lebensraum_beschreibung),E'\n')
    ,CASE WHEN sum(h1.prozent_anrechenbar) > 100 THEN 100 ELSE sum(h1.prozent_anrechenbar) END
    ,hef.geo_obj
  FROM
    h1 LEFT JOIN gl_biotope.hochlagen_einheitsflaeche hef ON h1.gehoert_zu = hef.t_id
  GROUP BY 
    hef.t_id,hef.t_ili_tid,hef.bezeichnung,hef.erhebungsjahr,hef.geo_obj
;
