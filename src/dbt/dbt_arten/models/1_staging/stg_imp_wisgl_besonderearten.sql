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
        {{ adapter.quote("id_art") }}, 

        -- info that's mirrored in gl_besonderewaldarten.besonderearten
        {{ adapter.quote("organismen") }} as organismengruppe,
        {{ adapter.quote("schutz_ch") }},
        {{ adapter.quote("schutz_gl") }},
        {{ adapter.quote("roteliste") }},

        -- info that's mirrored in prod_gl_arten.artvorkommen_pt_gl
        {{ adapter.quote("radius") }},
        trim({{ adapter.quote("substrat") }}) substrat,
        trim({{ adapter.quote("foerdermassnahmen") }}) as foerdermassnahmen,
        trim({{ adapter.quote("finder") }}) finder,
        {{ adapter.quote("funddatum") }},
        {{ adapter.quote("hinzugefuegt_am") }},
        {{ adapter.quote("kantonsint") }}::boolean as kantonsintern,
        {{ adapter.quote("verwaltung") }}::boolean as verwaltungsintern,
        {{ adapter.quote("status") }}::boolean,
        trim({{ adapter.quote("bemerkungen") }}) bemerkungen,
        {{ adapter.quote("fotos") }},
        {{ adapter.quote("genau") }}::boolean,
        {{ adapter.quote("x_koord") }},
        {{ adapter.quote("y_koord") }},
        {{ adapter.quote("geometry") }} as geometrie
      from source
  )
  select * from staging
    