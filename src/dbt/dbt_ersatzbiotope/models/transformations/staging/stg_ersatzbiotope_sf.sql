with source as (
        select * from {{ source('src_prod_gl_ersatzbiotope', 'ersatzbiotope_sf') }}
  ),
  renamed as (
      select
        {{ adapter.quote("gid") }},
        {{ adapter.quote("objekt_nummer") }},
        {{ adapter.quote("teilobjekt_nummer") }},
        {{ adapter.quote("ersatzmassnahme") }},
        {{ adapter.quote("kategorie_ersatzmassnahme") }},
        {{ adapter.quote("ziellebensraum") }},
        {{ adapter.quote("flaeche_m2") }},
        {{ adapter.quote("entscheide") }},
        {{ adapter.quote("projekttraeger") }},
        {{ adapter.quote("dokumente") }},
        {{ adapter.quote("bemerkungen_intern") }},
        {{ adapter.quote("geometrie") }}
      from source
  )
  select * from renamed
    