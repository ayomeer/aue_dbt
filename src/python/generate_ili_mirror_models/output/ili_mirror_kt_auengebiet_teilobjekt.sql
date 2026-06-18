{{ config(materialized='table', enabled=false) }} 

SELECT 
  t_id::bigint,
  t_basket::bigint,
  t_ili_tid::uuid,
  teilobj_nr::character varying(30),
  geo_obj::geometry(MultiSurface,2056),
  kt_auengebiet::bigint
FROM {{ ref('placeholder') }}