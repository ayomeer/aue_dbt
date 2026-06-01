select 
  objekt_nummer,
  array_agg(distinct projekttraeger) as agg_distinct_projektraeger
from {{ ref('aggregate_into_ersatzbiotop') }}
group by objekt_nummer
having count(distinct projekttraeger) > 1