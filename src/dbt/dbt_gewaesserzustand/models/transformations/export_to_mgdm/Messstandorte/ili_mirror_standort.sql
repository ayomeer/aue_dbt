{{ config(materialized='table', enabled=false) }} 

SELECT 
  t_id::bigint, -- NOT NULL
  t_basket::bigint, -- NOT NULL
  t_ili_tid::character varying(200), 
  punkt::geometry(PointZ,2056), 
  apolygon::geometry(Polygon2056) 
FROM {{ ref('placeholder') }}