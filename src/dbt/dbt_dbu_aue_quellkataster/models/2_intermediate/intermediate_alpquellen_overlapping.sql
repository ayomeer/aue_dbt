{# This model describes alpquellen objects, which are very close to
access_objektdaten objects and are thus assumed to be the same real-world
object. The MGDM-information contained within these objects are to be merged
into access_objektdaten objects, whereas alpquellen information takes 
priority over access_objektdaten information 
(COALESCE(alpquellen_column, access_objektdaten_column ))  #}

{% set buffer_radius = 5 %} 

WITH access_geoms AS (
  SELECT 
    access.t_id,
    geometrie,
    ST_buffer(geometrie, {{buffer_radius}}, 16) as geom_buffer
  FROM {{ ref('intermediate_access_objektdaten') }} as access
)
SELECT 
  access_geoms.t_id as access_t_id,
  alpquelle.*,
  ST_Within(alpquelle.geometrie, access_geoms.geom_buffer) as distance
FROM {{ ref('intermediate_alpquellen') }} as alpquelle,
     access_geoms
 