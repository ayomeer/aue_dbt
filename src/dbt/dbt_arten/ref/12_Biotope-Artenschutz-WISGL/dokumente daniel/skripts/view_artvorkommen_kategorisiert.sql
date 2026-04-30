-- View: prod_gl_biotope.view_artvorkommen_kategorisiert

-- DROP VIEW prod_gl_biotope.view_artvorkommen_kategorisiert;

CREATE OR REPLACE VIEW prod_gl_biotope.view_artvorkommen_kategorisiert AS 
 SELECT row_number() OVER ()::integer AS vid,
    f.art_wiss,
    f.art_deutsch,
    f.spezart,
    f.substrat,
    f.radius,
    f.ext_label,
    f.ext_herkunft,
    f.copyright,
    f.funddatum,
    f.finder,
    f.kantonsintern,
    f.verwaltungsintern,
    f.bemerkungen,
    f.fotos,
    f.genauigkeit_ausreichend,
    f.biotopstatus,
    f.last_modified,
    f.last_user,
    f.oid_uuid,
    f.id_from_cat_arten,
    f.gattung,
    f.spezies,
    f.subspezies,
    c.bez_art_latein AS a_bez_art_latein,
    c.bez_art_deutsch AS a_bez_art_deutsch,
    c.id_art AS a_id,
    c.artengruppe AS a_artengruppe,
    c.schutzstatus AS a_schutzstatus,
    c.rl_status AS a_rl_status,
    c.vorkommen_publiziert AS a_vorkommen_publiziert,
    c.foerdermassnahmen AS a_foerdermassnahmen,
    c.schutz_ch AS a_schutz_ch,
    c.schutz_gl AS a_schutz_gl,
    c.spez_art_bafu_prioritaet AS a_spez_art_bafu_prioritaet,
    c.verantwortung_ch AS a_verantwortung_ch,
    c.smaragd_art AS a_smaragd_art,
    c.endemit AS a_endemit,
    c.lw_uzl_art AS a_lw_uzl_art,
    c.art_aus_waldbiostrategie AS a_art_aus_waldbiostrategie,
    c.waldzielart_ch AS a_waldzielart_ch,
    c.datenherkunft AS a_datenherkunft,
    c.ext_id_daten AS a_ext_id_daten,
    c.genus AS a_genus,
    c.species AS a_species,
    c.subspecies AS a_subspecies,
    c.last_modified AS a_last_modified,
    c.last_user AS a_last_user,
    c.oid_uuid AS a_oid_uuid,
    f.geometrie
   FROM prod_gl_biotope.cat_arten c
     LEFT JOIN prod_gl_biotope.view_artvorkommen_pt_artnamen f ON c.id_art = f.id_from_cat_arten
  ORDER BY c.artengruppe, c.bez_art_latein;

ALTER TABLE prod_gl_biotope.view_artvorkommen_kategorisiert
  OWNER TO prod_gl_biotope_write;
GRANT ALL ON TABLE prod_gl_biotope.view_artvorkommen_kategorisiert TO prod_gl_biotope_write;
GRANT SELECT, REFERENCES ON TABLE prod_gl_biotope.view_artvorkommen_kategorisiert TO prod_gl_biotope_read;
COMMENT ON VIEW prod_gl_biotope.view_artvorkommen_kategorisiert
  IS 'View verknuepfte Funddaten mit Kategorien';
