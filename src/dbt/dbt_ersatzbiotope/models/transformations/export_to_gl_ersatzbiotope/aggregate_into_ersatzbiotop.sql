-- Here, we create what corresponds to "Ersatzbiotop"-Object 
-- in gl_ersatzbiotope target schema

select
  objekt_nummer,
  projekttraeger
from {{ ref('stg_union_all') }}
group by objekt_nummer, projekttraeger
order by objekt_nummer