select 
  objekt_nummer,
  array_agg(distinct objekt_name) as agg_distinct_objekt_name,
  array_agg(distinct herkunft) as agg_distinct_herkunft,
  array_agg(distinct bafu_bio_typ) as agg_bio_typ,
  array_agg(distinct intern_mutationsgrund) as agg_distinct_mutationsgrund
from {{ ref('stg_biotope_to_sf') }}
group by 
  -- attributes that are supposed to lead to distinct groupings  
  objekt_nummer, 
  biotopart, 
  bedeutung,
  kartierungsgrundlage,
  herkunft
having 
  -- attributes that are assumed to NOT lead to differ within groupings
  count(distinct objekt_name) > 1 OR
  count(distinct bafu_bio_typ) > 1
  -- OR count(distinct intern_mutationsgrund) > 1
  