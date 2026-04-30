-- View: prod_gl_arten.view_artenliste_gl_kategorisiert

-- DROP VIEW prod_gl_arten.view_artenliste_gl_kategorisiert;

CREATE OR REPLACE VIEW prod_gl_arten.view_artenliste_gl_kategorisiert AS 
 SELECT f.art_wiss,
    f.art_deutsch,
    f.spezart,
    f.kantonsintern,
    f.verwaltungsintern,
    f.id_from_cat_arten,
    c.id_art AS a_id,
    c.artengruppe AS a_artengruppe,
    c.schutzstatus AS a_schutzstatus,
    c.rl_status AS a_rl_status,
    c.vorkommen_publiziert AS a_vorkommen_publiziert,
    c.foerdermassnahmen AS a_foerdermassnahmen,
    c.schutz_ch AS a_schutz_ch,
    c.schutz_gl AS a_schutz_gl,
    c.bafu_prioritaet AS a_spez_art_bafu_prioritaet,
    c.verantwortung_ch AS a_verantwortung_ch,
    c.smaragd_art AS a_smaragd_art,
    c.endemit AS a_endemit,
    c.lw_uzl_art AS a_lw_uzl_art,
    c.art_aus_waldbiostrategie AS a_art_aus_waldbiostrategie,
    c.waldzielart_ch AS a_waldzielart_ch,
    c.datenherkunft AS a_datenherkunft,
    c.ext_id_daten AS a_ext_id_daten,
    c.bez_art_latein AS a_bez_art_latein,
    c.bez_art_deutsch AS a_bez_art_deutsch,
    f.gattung,
    f.spezies,
    f.subspezies,
    c.genus AS a_genus,
    c.species AS a_species,
    c.subspecies AS a_subspecies
   FROM prod_gl_arten.cat_art c
     RIGHT JOIN prod_gl_arten.view_artvorkommen_pt_artnamen f ON btrim(c.genus::text) = btrim(f.gattung) AND btrim(c.species::text) = btrim(f.spezies)
  GROUP BY f.art_wiss, f.art_deutsch, f.spezart, f.kantonsintern, f.verwaltungsintern, f.id_from_cat_arten, f.gattung, f.spezies, f.subspezies, c.bez_art_latein, c.bez_art_deutsch, c.id_art, c.artengruppe, c.schutzstatus, c.rl_status, c.vorkommen_publiziert, c.foerdermassnahmen, c.schutz_ch, c.schutz_gl, c.bafu_prioritaet, c.verantwortung_ch, c.smaragd_art, c.endemit, c.lw_uzl_art, c.art_aus_waldbiostrategie, c.waldzielart_ch, c.datenherkunft, c.ext_id_daten, c.genus, c.species, c.subspecies
  ORDER BY c.artengruppe, f.art_wiss;

ALTER TABLE prod_gl_arten.view_artenliste_gl_kategorisiert
  OWNER TO prod_gl_arten_write;
GRANT ALL ON TABLE prod_gl_arten.view_artenliste_gl_kategorisiert TO prod_gl_arten_write;
GRANT SELECT, REFERENCES ON TABLE prod_gl_arten.view_artenliste_gl_kategorisiert TO prod_gl_arten_read;
GRANT SELECT ON TABLE prod_gl_arten.view_artenliste_gl_kategorisiert TO prod_gl_arten_foerster;
COMMENT ON VIEW prod_gl_arten.view_artenliste_gl_kategorisiert
  IS 'View Kategorisierte Liste der im Kanton gefundenen Arten';
