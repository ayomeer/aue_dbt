

with source as (
  select * from {{ source('prod_gl_ersatzbiotope', 'cat_kategorie_ersatzmassnahme') }}
)
select
  {{ adapter.quote("id") }},
  {{ adapter.quote("kategorie_ersatzmassnahme") }}
from source
