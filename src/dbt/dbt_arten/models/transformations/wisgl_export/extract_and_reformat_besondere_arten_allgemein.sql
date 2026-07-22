SELECT 
  f.gid,
  w.name_lateinisch,
  w.name_deutsch,
  w.organismengruppe, 
  COALESCE(c.schutz_ch, 'nicht geschuetzt') as schutz_status_schweiz,
  COALESCE(c.schutz_gl, 'nicht geschuetzt') as schutz_status_kt_gl,
  c.rl_status as rote_liste_status, 
  COALESCE(f.radius, 9999) as radius,
  CASE
    WHEN w.organismengruppe = 'Amphibien' and f.radius > 100 THEN false
    WHEN w.organismengruppe = 'Blütenpflanzen' and f.radius > 100 THEN false
    WHEN w.organismengruppe = 'Farne' and f.radius > 100 THEN false
    WHEN w.organismengruppe = 'Flechten' and f.radius > 50 THEN false
    WHEN w.organismengruppe = 'Fledermäuse' and f.radius > 100 THEN false
    WHEN w.organismengruppe = 'Käfer' and f.radius > 50 THEN false
    WHEN w.organismengruppe = 'Moose' and f.radius > 50 THEN false
    WHEN w.organismengruppe = 'Schmetterlinge' and f.radius > 100 THEN false
    WHEN w.organismengruppe = 'Reptilien' and f.radius > 100 THEN false
    WHEN w.organismengruppe = 'Sträucher / Gehölze' and f.radius > 100 THEN false
    WHEN w.organismengruppe = 'Vögel' and f.radius > 1000 THEN false
    WHEN w.organismengruppe = 'Waldameisen' and f.radius > 50 THEN false	
    ELSE true
  END as genau, 
  w.foerdermassnahmen as foerdermassnahmen,
  COALESCE(f.verwaltungsintern, true) as verwaltungsintern,
  COALESCE(f.kantonsintern, false) as kantonsintern,
  f.dat_hinzugefuegt_am as hinzugefuegt_am,
  c.id_art,
  geometrie,
  f.bemerkungen, 
  true as status, 
  f.fotos, 
  COALESCE(f.finder, 'keine Angabe') as finder,
  f.funddatum, 
  COALESCE(f.substrat, 'keine Angabe') as substrat,
  f.ext_herkunft,
  f.last_modified,
  f.wisgl_id

FROM {{ ref('stg_artvorkommen') }}  as f 
join {{ ref('stg_besondere_waldarten') }} as w 
  on f.id_from_cat_arten = w.id_art
left join prod_gl_arten.cat_art as c 
  on f.id_from_cat_arten = c.id_art
WHERE f.funddatum > '1.1.1980' 
  and f.qualitaetskontrolle is true 
  and w.wis is true 
  and w.organismengruppe != 'Waldameisen'