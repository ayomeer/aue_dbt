with source as (
        select * from {{ source('src_dbt_arten', 'imp_wisgl_besonderearten') }}
  ),
  staging as (
      select
        {{ adapter.quote("id") }},
        -- info related to cat_art
        {{ adapter.quote("name_deutsch") }},
        {{ adapter.quote("name_lateinisch") }},
        {{ adapter.quote("id_art") }}, -- corresponds to prod_gl_arten.cat_art
        {{ adapter.quote("organismen") }},
        {{ adapter.quote("schutz_ch") }}, 
        {{ adapter.quote("schutz_gl") }},
        {{ adapter.quote("roteliste") }},
        -- info that's mirrored in prod_gl_arten.artvorkommen_pt_gl
        {{ adapter.quote("radius") }},
        {{ adapter.quote("genau") }},
        {{ adapter.quote("substrat") }},
        {{ adapter.quote("foerdermassnahmen") }},
        {{ adapter.quote("finder") }},
        {{ adapter.quote("funddatum") }},
        {{ adapter.quote("hinzugefuegt_am") }},
        {{ adapter.quote("kantonsint") }},
        {{ adapter.quote("verwaltung") }},
        {{ adapter.quote("status") }},
        {{ adapter.quote("bemerkungen") }},
        {{ adapter.quote("fotos") }},
        {{ adapter.quote("t_ili_tid") }},
        {{ adapter.quote("x_koord") }},
        {{ adapter.quote("y_koord") }},
        {{ adapter.quote("geometry") }}

      from source
  )
  select * from staging
    