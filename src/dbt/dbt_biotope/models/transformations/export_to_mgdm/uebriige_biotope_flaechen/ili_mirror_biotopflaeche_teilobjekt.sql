{{ config(materialized='table', enabled=false) }} 

SELECT 
  t_id::bigint, -- NOT NULL
  t_basket::bigint, -- NOT NULL
  t_ili_tid::character varying(200), 
  teilobj_nr::character varying(30), -- NOT NULL
  geo_obj::geometry(MultiPolygon,2056), -- NOT NULL
  biotop::bigint -- NOT NULL
FROM {{ ref('placeholder') }}