with source as (
        select * from {{ source('prod_gl_ersatzbiotope', 'ersatzbiotope_sf') }}
  ),
  renamed as (
      select
        {{ adapter.quote("gid") }},
        {{ adapter.quote("objekt_nummer") }},
        {{ adapter.quote("teilobjekt_nummer") }},
        trim(REPLACE(ersatzmassnahme, E'\t', '  ')) as ersatzmassnahme,
        trim(REPLACE(kategorie_ersatzmassnahme, E'\t', '  ')) as kategorie_ersatzmassnahme,
        {{ adapter.quote("ziellebensraum") }},
        {{ adapter.quote("flaeche_m2") }},
        {{ adapter.quote("entscheide") }},
        {{ adapter.quote("projekttraeger") }},
        {{ adapter.quote("dokumente") }},
        {{ adapter.quote("bemerkungen_intern") }},
        ST_RemoveRepeatedPoints("geometrie", tolerance=>0.01) as geometrie
      from source
  )
  select 
  *,
  ST_IsValidReason("geometrie") as isvalid 
  from renamed
    