with source as (
        -- select * from {{ source('src_prod_gl_arten', 'artvorkommen_gl_pt') }}
        select * from {{ source('src_prod_gl_arten', 'artvorkommen_gl_pt') }}
  ),
  staging as (
      select
        -- columns mirroring besonderearten
        {{ adapter.quote("gid") }},
        -- info related to cat_art
        {{ adapter.quote("art_deutsch") }},
        {{ adapter.quote("art_wiss") }},
        {{ adapter.quote("id_from_cat_arten") }}, 

        -- info held only in artvorkommen_gl_pt
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

        {{ adapter.quote("ext_naturzentrum_id") }},
        {{ adapter.quote("ext_vdc_id") }},
        {{ adapter.quote("ext_naturzentrum_id") }},
        
        {{ adapter.quote("last_modified") }},       -- automatically set by trigger function
        {{ adapter.quote("last_user") }},           -- automatically set by trigger function
        {{ adapter.quote("dat_hinzugefuegt_am") }}, -- automatically set by trigger function
        {{ adapter.quote("e") }}, -- automatically set by trigger function from geom
        {{ adapter.quote("n") }}, -- automatically set by trigger function from geom
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
    