select 
  objekt_nummer,
  array_agg(distinct objekt_name) as agg_distinct_objekt_name,
  array_agg(distinct herkunft) as agg_distinct_herkunft,
  array_agg(distinct kartierungsgrundlage) as agg_distinct_kartierungsgrundlage,
array_agg(distinct bedeutung) as agg_distinct_bedeutung
from {{ ref('stg_biotope_to_sf') }}
group by objekt_nummer
having 
  count(distinct objekt_name) > 1 OR
  count(distinct herkunft) > 1 OR
  count(distinct kartierungsgrundlage) > 1 OR
  count(distinct bedeutung) > 1
  