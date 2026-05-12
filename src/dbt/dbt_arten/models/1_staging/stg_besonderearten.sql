with source as (
        select * from {{ source('src_gl_besonderewaldarten', 'besonderearten') }}
  ),
  renamed as (
      select
        {{ adapter.quote("t_id") }} as id,
        {{ adapter.quote("t_basket") }},
        {{ adapter.quote("t_ili_tid") }},
        {{ adapter.quote("id_art") }},
        {{ adapter.quote("name_d") }} as name_deutsch,
        {{ adapter.quote("name_lat") }} as name_lateinisch,
        {{ adapter.quote("organismengruppe") }},
        {{ adapter.quote("schutz_ch") }},
        {{ adapter.quote("schutz_gl") }},
        {{ adapter.quote("roteliste") }},
        {{ adapter.quote("radius") }},
        {{ adapter.quote("genau") }},
        {{ adapter.quote("substrat") }},
        {{ adapter.quote("foerdermassnahmen") }},
        {{ adapter.quote("finder") }},
        {{ adapter.quote("funddatum") }},
        {{ adapter.quote("hinzugefuegt_am") }},
        {{ adapter.quote("kantonsintern") }},
        {{ adapter.quote("verwaltungsintern") }},
        {{ adapter.quote("astatus") }},
        {{ adapter.quote("bemerkungen") }},
        {{ adapter.quote("fotos") }},
        {{ adapter.quote("geometrie") }}
      from source
  )
  select * from renamed
    