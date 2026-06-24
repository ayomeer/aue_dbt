{{ config(materialized='table', enabled=false) }} 

SELECT 
  t_id::bigint, -- NOT NULL
  t_basket::bigint, -- NOT NULL
  t_ili_tid::character varying(200), 
  teilobj_nr::character varying(30), -- NOT NULL
  bewertungseinheit::integer, 
  tww_tobj::integer, 
  geo_obj::geometry(PolygonZ,2056), -- NOT NULL
  kt_trockenwiese::bigint -- NOT NULL
FROM {{ ref('placeholder') }}