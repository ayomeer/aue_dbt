select 
  objekt_nummer,
  array_agg(distinct objekt_name) as agg_distinct_objekt_name,
  array_agg(distinct herkunft) as agg_distinct_herkunft,
  array_agg(distinct intern_mutationsgrund) as agg_distinct_mutationsgrund
from {{ ref('stg_biotope_to_sf') }}
group by objekt_nummer
having 
  count(distinct objekt_name) > 1 
  -- OR count(distinct intern_mutationsgrund) > 1
  