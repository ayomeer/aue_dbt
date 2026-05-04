with source as (
        select * from {{ source('src_dbt_arten', 'imp_wisgl_besonderearten') }}
  ),
  staging as (
      select
        {{ adapter.quote("id") }},
        {{ adapter.quote("t_ili_tid") }},
        -- info related to cat_art
        {{ adapter.quote("name_deutsch") }},
        {{ adapter.quote("name_lateinisch") }},
        {{ adapter.quote("id_art") }} as id_from_cat_arten, 

        -- info that's mirrored in prod_gl_arten.artvorkommen_pt_gl
        {{ adapter.quote("radius") }},
        {{ adapter.quote("substrat") }},
        {{ adapter.quote("foerdermassnahmen") }},
        {{ adapter.quote("finder") }},
        {{ adapter.quote("funddatum") }},
        {{ adapter.quote("hinzugefuegt_am") }},
        {{ adapter.quote("kantonsint") }}::boolean as kantonsintern,
        {{ adapter.quote("verwaltung") }}::boolean as verwaltungsintern,
        {{ adapter.quote("status") }}::boolean as biotopstatus,
        {{ adapter.quote("bemerkungen") }},
        {{ adapter.quote("fotos") }},
        {{ adapter.quote("genau") }}::boolean as genauigkeit_ausreichend,
        {{ adapter.quote("x_koord") }},
        {{ adapter.quote("y_koord") }},
        {{ adapter.quote("geometry") }} as geometrie
      from source
  )
  select * from staging
    