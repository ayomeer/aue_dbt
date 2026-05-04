with source as (
        select * from {{ source('src_prod_gl_arten', 'besondere_waldarten') }}
  ),
  renamed as (
      select
        {{ adapter.quote("id") }},
        {{ adapter.quote("organismengruppe") }},
        {{ adapter.quote("deutscher name") }} as name_deutsch,
        {{ adapter.quote("lateinischer name") }} as name_lateinisch,
        {{ adapter.quote("id_art") }},
        {{ adapter.quote("wis") }},
        {{ adapter.quote("foerdermassnahmen") }},
        {{ adapter.quote("aufnahmegrund") }}

      from source
  )
  select * from renamed
    