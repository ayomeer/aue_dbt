

with source as (
        select * from {{ source('src_prod_gl_ersatzbiotope', 'cat_kategorie_ersatzmassnahme') }}
  ),
  renamed as (
      select
        {{ adapter.quote("id") }},
        {{ adapter.quote("kategorie_ersatzmassnahme") }}
      from source
  )
  select 
    *,
    {{ var('catalogues')['kategorie_catalogue']['t_id_starting_at'] }} + row_number() over() as future_t_id 
  from renamed
