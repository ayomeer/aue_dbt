-- View: prod_gl_arten.view_artvorkommen_pt_artnamen

-- DROP VIEW prod_gl_arten.view_artvorkommen_pt_artnamen;

CREATE OR REPLACE VIEW prod_gl_arten.view_artvorkommen_pt_artnamen AS 
 SELECT a.gid,
    a.art_wiss,
    a.art_deutsch,
    split_part(a.art_wiss::text, ' '::text, 1) AS gattung,
    split_part(a.art_wiss::text, ' '::text, 2) AS spezies,
    split_part(a.art_wiss::text, ' '::text, 3) AS subspezies,
    a.spezart,
    a.substrat,
    a.radius,
    a.ext_label,
    a.ext_herkunft,
    a.copyright,
    a.funddatum,
    a.finder,
    a.kantonsintern,
    a.verwaltungsintern,
    a.bemerkungen,
    a.fotos,
    a.genauigkeit_ausreichend,
    a.biotopstatus,
    a.id_gl_aus_import AS reserve_1,
    a.last_modified,
    a.last_user,
    a.oid_uuid,
    a.geometrie,
    a.id_from_cat_arten
   FROM prod_gl_arten.artvorkommen_gl_pt a
  ORDER BY a.art_wiss;

ALTER TABLE prod_gl_arten.view_artvorkommen_pt_artnamen
  OWNER TO prod_gl_arten_write;
GRANT ALL ON TABLE prod_gl_arten.view_artvorkommen_pt_artnamen TO prod_gl_arten_write;
GRANT SELECT, REFERENCES ON TABLE prod_gl_arten.view_artvorkommen_pt_artnamen TO prod_gl_arten_read;
GRANT SELECT ON TABLE prod_gl_arten.view_artvorkommen_pt_artnamen TO prod_gl_arten_foerster;
COMMENT ON VIEW prod_gl_arten.view_artvorkommen_pt_artnamen
  IS 'Artvorkommen mit aufgeteilten Gattungs-, Art-, Unterartbezeichnungen';
