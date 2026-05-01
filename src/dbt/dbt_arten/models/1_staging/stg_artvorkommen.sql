with source as (
        select * from {{ source('src_prod_gl_arten', 'artvorkommen_gl_pt') }}
  ),
  staging as (
      select
      -- columns mirroring besonderearten
        {{ adapter.quote("gid") }},
        {{ adapter.quote("art_deutsch") }},
        {{ adapter.quote("art_wiss") }},
        {{ adapter.quote("id_from_cat_arten") }}, 
        {{ adapter.quote("radius") }},
        {{ adapter.quote("substrat") }},
        {{ adapter.quote("funddatum") }},
        {{ adapter.quote("finder") }},
        {{ adapter.quote("kantonsintern") }},
        {{ adapter.quote("verwaltungsintern") }},
        {{ adapter.quote("bemerkungen") }},
        {{ adapter.quote("fotos") }},
        {{ adapter.quote("genauigkeit_ausreichend") }},
        {{ adapter.quote("biotopstatus") }},
        {{ adapter.quote("id_gl_aus_import") }},
        {{ adapter.quote("last_modified") }},
        {{ adapter.quote("last_user") }},
        {{ adapter.quote("dat_hinzugefuegt_am") }},
        {{ adapter.quote("e") }},
        {{ adapter.quote("n") }},
        {{ adapter.quote("geometrie") }},
        
        -- other columns
        {{ adapter.quote("neobiot") }},
        {{ adapter.quote("qualitaetskontrolle") }},
        {{ adapter.quote("taxonidch") }},
        {{ adapter.quote("ext_hoehe") }},
        {{ adapter.quote("gemeinde_kt_glarus") }},
        {{ adapter.quote("oid_uuid") }},
        {{ adapter.quote("spezart") }},
        {{ adapter.quote("ext_label") }},
        {{ adapter.quote("ext_herkunft") }},
        {{ adapter.quote("copyright") }},
        {{ adapter.quote("loeschmarkierung") }}
      from source
  )
  select * from staging
    