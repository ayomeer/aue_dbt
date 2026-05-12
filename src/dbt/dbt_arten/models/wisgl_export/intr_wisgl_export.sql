-- Script by Peter Zopfi integrated into dbt wholesale. Might be reworked later.
with union_cte as (
  -- alles ausser waldameisen
  SELECT 
    w.name_lateinisch,
    w.name_deutsch,
    w.organismengruppe, 
    CASE
      WHEN c.schutz_ch IS NULL THEN 'nicht geschuetzt'
      ELSE c.schutz_ch 
    END as schutz_status_schweiz,
    CASE
      WHEN c.schutz_gl IS NULL THEN 'nicht geschuetzt'
      ELSE c.schutz_gl 
    END as schutz_status_kt_gl,
    c.rl_status as rote_liste_status, 
    CASE
      WHEN f.radius IS NULL THEN 9999
      ELSE f.radius
    END as radius, 
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
    CASE
      WHEN f.verwaltungsintern IS NULL THEN true
      ELSE f.verwaltungsintern
    END as verwaltungsintern,
    CASE 
      WHEN f.kantonsintern IS NULL THEN false
      ELSE f.kantonsintern
    END as kantonsintern,
      f.dat_hinzugefuegt_am as hinzugefuegt_am,
      c.id_art,
      ST_SetSRID(ST_Point(f.e,f.n),2056) as geometrie,
      f.bemerkungen, 
      true as status, 
      f.fotos, 
  CASE
    WHEN f.finder IS NULL THEN 'keine Angabe'
    ELSE f.finder
      END as finder, 
      f.funddatum, 
      CASE
    WHEN f.substrat IS NULL THEN 'keine Angabe'
    ELSE f.substrat
  END as substrat,
  f.ext_herkunft,
  f.last_modified


  FROM {{ ref('stg_artvorkommen') }}  as f 
  join {{ ref('stg_besondere_waldarten') }} as w 
      on f.id_from_cat_arten = w.id_art
    left join prod_gl_arten.cat_art as c 
      on f.id_from_cat_arten = c.id_art
  WHERE f.funddatum > '1.1.1980' 
    and f.qualitaetskontrolle is true 
    and w.wis is true 
    and w.organismengruppe != 'Waldameisen'

  UNION

  -- waldameisen
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
      WHEN w.name_lateinisch ='Formica polyctena' THEN 'Kahlrücke Waldameise'
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
        CASE
      WHEN f.radius IS NULL THEN 9999
      ELSE f.radius
        END as radius, 
        CASE
      WHEN f.radius > 50 THEN false	
    ELSE true
        END as genau, 
        w.foerdermassnahmen as foerdermassnahmen,
        CASE
      WHEN f.verwaltungsintern IS NULL THEN true
      ELSE f.verwaltungsintern
        END as verwaltungsintern,
        CASE 
      WHEN f.kantonsintern IS NULL THEN false
      ELSE f.kantonsintern
        END as kantonsintern,
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
    ST_SetSRID(ST_Point(f.e,f.n),2056) as geometrie,
    f.bemerkungen, 
    true as status, 
    f.fotos, 
    CASE
      WHEN f.finder IS NULL THEN 'keine Angabe'
      ELSE f.finder
    END as finder, 
    CASE 
      WHEN f.finder = 'Ruedi Zimmermann' and f.funddatum is NULL THEN '1.1.2019'
      ELSE f.funddatum
      END as funddatum, 
    CASE
      WHEN f.substrat IS NULL THEN 'keine Angabe'
      ELSE f.substrat
    END as substrat,
    f.ext_herkunft,
    f.last_modified

  FROM {{ ref('stg_artvorkommen') }}  as f 
  join {{ ref('stg_besondere_waldarten') }} as w 
    on f.art_wiss = w.name_lateinisch
  WHERE w.wis is true 
    and w.organismengruppe = 'Waldameisen'
)
SELECT
  row_number() over() as id,
  * 
FROM union_cte
WHERE genau is true