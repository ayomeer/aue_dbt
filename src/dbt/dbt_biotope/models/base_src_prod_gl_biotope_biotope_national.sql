with source as (
        select * from {{ source('src_prod_gl_biotope', 'biotope_national') }}
  ),
  renamed as (
      select
          {{ adapter.quote("gid") }},
        {{ adapter.quote("objekt_nr") }},
        {{ adapter.quote("teilobjekt_nr") }},
        {{ adapter.quote("objekt_name") }},
        {{ adapter.quote("biotoptyp") }},
        {{ adapter.quote("planart") }},
        {{ adapter.quote("detailkartierung_kanton") }},
        {{ adapter.quote("umsetzung") }},
        {{ adapter.quote("letzte_mutation") }},
        {{ adapter.quote("geaendert_durch") }},
        {{ adapter.quote("the_geom") }}

      from source
  )
  select * from renamed
    