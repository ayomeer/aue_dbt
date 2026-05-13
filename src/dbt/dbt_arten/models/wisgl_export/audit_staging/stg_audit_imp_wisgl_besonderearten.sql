{{ config(
  enabled=var("enable_audits", false)
)}}

SELECT 
  id,
  id_art,
  name_deutsch,
  name_lateinisch,
  organismengruppe,
  schutz_ch,
  schutz_gl,
  roteliste,
  radius,
  genau,
  substrat,
  foerdermassnahmen,
  finder,
  funddatum,
  hinzugefuegt_am,
  kantonsintern,
  verwaltungsintern,
  status,
  bemerkungen,
  fotos,
  geometrie,
  i.audit_link_id
FROM {{ ref('stg_imp_wisgl_besonderearten') }} as old
LEFT JOIN {{ ref('stg_audit_id_relations') }} as i
  ON old.id = i.old_id