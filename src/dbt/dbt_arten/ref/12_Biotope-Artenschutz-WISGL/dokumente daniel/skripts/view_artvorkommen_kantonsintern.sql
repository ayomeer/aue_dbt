-- View: prod_gl_arten.view_artvorkommen_kantonsintern

-- DROP VIEW prod_gl_arten.view_artvorkommen_kantonsintern;

CREATE OR REPLACE VIEW prod_gl_arten.view_artvorkommen_kantonsintern AS 
 SELECT row_number() OVER ()::integer AS vid,
    c.artengruppe AS a_artengruppe,
    c.bez_art_deutsch AS a_bez_art_deutsch,
    c.bez_art_latein AS a_bez_art_latein,
    c.rl_status AS a_rl_status,
    c.schutz_ch AS a_schutz_ch,
    c.schutz_gl AS a_schutz_gl,
    c.foerdermassnahmen AS a_foerdermassnahmen_allgemein,
    f.substrat,
    f.radius,
    f.copyright,
    f.funddatum,
    f.bemerkungen,
    c.id_art AS a_id,
    c.vorkommen_publiziert AS a_vorkommen_publiziert,
    f.geometrie
   FROM prod_gl_arten.cat_art c
     JOIN prod_gl_arten.artvorkommen_gl_pt f ON c.id_art = f.id_from_cat_arten
  ORDER BY c.artengruppe, c.bez_art_latein;

ALTER TABLE prod_gl_arten.view_artvorkommen_kantonsintern
  OWNER TO prod_gl_arten_write;
GRANT ALL ON TABLE prod_gl_arten.view_artvorkommen_kantonsintern TO prod_gl_arten_write;
GRANT SELECT ON TABLE prod_gl_arten.view_artvorkommen_kantonsintern TO prod_gl_arten_foerster;
GRANT ALL ON TABLE prod_gl_arten.view_artvorkommen_kantonsintern TO postgres;
