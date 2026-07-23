
SELECT 
  t_id,
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
  ST_AsEWKB(geometrie)::varchar as geometrie
FROM {{ ref('stg_imp_wisgl_besonderearten') }}

