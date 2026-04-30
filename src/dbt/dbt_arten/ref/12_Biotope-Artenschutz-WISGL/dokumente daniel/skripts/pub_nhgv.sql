-- View: dbu_aue_nhgv.pub_nhgv

-- DROP VIEW dbu_aue_nhgv.pub_nhgv;

CREATE OR REPLACE VIEW dbu_aue_nhgv.pub_nhgv AS 
 SELECT row_number() OVER ()::integer AS vid,
    nhgv_vflaeche.help_vertr_nr AS "Vertragsnr",
    nhgv_vflaeche.fl_bezeich AS "Vertragsteil",
        CASE
            WHEN nhgv_vflaeche.typ_nutz::text = 'Flachmoor beweidet'::text THEN 'Flachmoor beweidet'::character varying
            WHEN nhgv_vflaeche.typ_nutz::text = 'Streuenutzung'::text THEN 'Streuenutzung'::character varying
            WHEN nhgv_vflaeche.typ_nutz::text = 'Flachmoor ungenutzt'::text THEN 'Flachmoor ungenutzt'::character varying
            WHEN nhgv_vflaeche.typ_nutz::text = 'Hochmoor ungenutzt'::text THEN 'Hochmoor ungenutzt'::character varying
            WHEN nhgv_vflaeche.typ_nutz::text = 'Magerheuwiese'::text THEN 'Magerheuwiese'::character varying
            WHEN nhgv_vflaeche.typ_nutz::text = 'Magerweide'::text THEN 'Magerweide'::character varying
            WHEN nhgv_vflaeche.typ_nutz::text = 'Pufferzone'::text THEN 'Pufferzone'::character varying
            WHEN nhgv_vflaeche.typ_nutz::text = 'Rückführungsfläche'::text THEN 'Rückführungsfläche'::character varying
            WHEN nhgv_vflaeche.typ_nutz::text = 'Rückführung in Biotop'::text THEN 'Rückführungsfläche'::character varying
            WHEN nhgv_vflaeche.typ_nutz::text = 'spezielle Nutzung'::text THEN 'Spezielle Nutzung'::character varying
            WHEN nhgv_vflaeche.typ_nutz::text = 'Hochmoor beweidet'::text THEN 'Spezielle Nutzung'::character varying
            ELSE 'Spezielle Nutzung'::character varying
        END AS "Nutzungstyp",
    round(nhgv_vflaeche.fl_aren, 0)::double precision AS "Flaeche_Aren",
    nhgv_vflaeche.schnittztp AS "Schnittzeitpunkt",
    nhgv_vflaeche.beweidung AS "Beweidung",
    nhgv_vflaeche.duengung AS "Duengung",
    nhgv_vflaeche.typ_biotop AS "Biotoptyp",
    nhgv_vflaeche.spez_vorbw AS "Spez_Bewirtschaftungsvorgaben",
    nhgv_vflaeche.jahr_abv AS "Ausgabe_Allg_Bewirtschaftungsvorgaben",
    nhgv_vflaeche.the_geom
   FROM dbu_aue_nhgv.nhgv_vflaeche
  WHERE nhgv_vflaeche.publikation IS TRUE;

ALTER TABLE dbu_aue_nhgv.pub_nhgv
  OWNER TO postgres;
GRANT ALL ON TABLE dbu_aue_nhgv.pub_nhgv TO postgres;
GRANT SELECT ON TABLE dbu_aue_nhgv.pub_nhgv TO dbu_aue_nhgv_read;
GRANT Select on table dbu_aue_nhgv.pub_nhgv TO "roger.pertschy";
COMMENT ON VIEW dbu_aue_nhgv.pub_nhgv
  IS 'Publikationsdaten NHG-Verträge (Naturschutzbewirtschaftungsbeiträge gemäss der Natur- und Heimatschutzgesetzgebung)';
