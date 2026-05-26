SELECT 
  CASE 
    WHEN w.name_lateinisch = 'Formica cf lugubris' THEN 'Formica lugubris'
    WHEN w.name_lateinisch = 'Formica cf. lugubris' THEN 'Formica lugubris'
    WHEN w.name_lateinisch = 'Formica lugubris' THEN 'Formica lugubris'
    WHEN w.name_lateinisch = 'Formica paralugubris' THEN 'Formica paralugubris'
    WHEN w.name_lateinisch = 'Formica polyctena' THEN 'Formica polyctena'
    WHEN w.name_lateinisch = 'Formica rufa' THEN 'Formica rufa'
    WHEN w.name_lateinisch = 'Formica rufa, Gruppe' THEN 'Formica rufa'
    WHEN w.name_lateinisch = 'Formica rufa x polyctena' THEN 'Formica rufa'
    WHEN w.name_lateinisch = 'Formica sensu stricto' THEN 'Formica sensu stricto'
  END as lateinischer_name,
  CASE 
    WHEN w.name_lateinisch = 'Formica cf lugubris' THEN 'Starkbeborstete Gebirgswaldameise'
    WHEN w.name_lateinisch = 'Formica cf. lugubris' THEN'Starkbeborstete Gebirgswaldameise'
    WHEN w.name_lateinisch = 'Formica lugubris' THEN 'Starkbeborstete Gebirgswaldameise'
    WHEN w.name_lateinisch = 'Formica paralugubris' THEN 'Kurzbeborstete Gebirgswaldameise'
    WHEN w.name_lateinisch = 'Formica polyctena' THEN 'Kahlrücke Waldameise'
    WHEN w.name_lateinisch = 'Formica rufa' THEN 'Rote Waldameise'
    WHEN w.name_lateinisch = 'Formica rufa, Gruppe' THEN 'Rote Waldameise'
    WHEN w.name_lateinisch = 'Formica rufa x polyctena' THEN 'Rote Waldameise'
    WHEN w.name_lateinisch = 'Formica sensu stricto' THEN 'Waldameisen (Untergattung)'
  END as deutscher_name,
  w.organismengruppe, 
  '451.1/2' as schutz_status_schweiz,
  'ja' as schutz_status_kt_gl, 
  CASE 
    WHEN w.name_lateinisch = 'Formica cf lugubris' THEN 'kA'
    WHEN w.name_lateinisch = 'Formica cf. lugubris' THEN'kA'
    WHEN w.name_lateinisch = 'Formica lugubris' THEN 'kA'
    WHEN w.name_lateinisch = 'Formica paralugubris' THEN 'kA'
    WHEN w.name_lateinisch = 'Formica polyctena' THEN 'NT'
    WHEN w.name_lateinisch = 'Formica rufa' THEN 'NT'
    WHEN w.name_lateinisch ='Formica rufa, Gruppe' THEN 'NT'
    WHEN w.name_lateinisch = 'Formica rufa x polyctena' THEN 'NT'
    WHEN w.name_lateinisch = 'Formica sensu stricto' THEN 'kA'
  END as rote_liste_status,
  COALESCE(f.radius, 9999) as radius,
  CASE
    WHEN f.radius > 50 THEN false	
    ELSE true
  END as genau, 
  w.foerdermassnahmen as foerdermassnahmen,
  COALESCE(f.verwaltungsintern, true) as verwaltungsintern,
  COALESCE(f.kantonsintern, false) as kantonsintern,
  f.dat_hinzugefuegt_am as hinzugefuegt_am,
  CASE 
    WHEN w.name_lateinisch = 'Formica cf lugubris' THEN 25288
    WHEN w.name_lateinisch = 'Formica cf. lugubris' THEN 25288
    WHEN w.name_lateinisch = 'Formica lugubris' THEN 25288
    WHEN w.name_lateinisch = 'Formica paralugubris' THEN 25291
    WHEN w.name_lateinisch = 'Formica polyctena' THEN 25292
    WHEN w.name_lateinisch = 'Formica rufa' THEN 86730
    WHEN w.name_lateinisch = 'Formica rufa, Gruppe' THEN 86730
    WHEN w.name_lateinisch = 'Formica rufa x polyctena' THEN 86730
    WHEN w.name_lateinisch = 'Formica sensu stricto' THEN 108121
  END as id_art, 
  geometrie,
  f.bemerkungen, 
  true as status, 
  f.fotos, 
  COALESCE(f.finder, 'keine Angabe') as finder,
  f.funddatum,
  COALESCE(f.substrat, 'keine Angabe') as substrat,
  f.ext_herkunft,
  f.last_modified

FROM {{ ref('stg_artvorkommen') }}  as f 
join {{ ref('stg_besondere_waldarten') }} as w 
  on f.art_wiss = w.name_lateinisch
WHERE w.wis is true 
  and w.organismengruppe = 'Waldameisen'
  and f.funddatum is not null