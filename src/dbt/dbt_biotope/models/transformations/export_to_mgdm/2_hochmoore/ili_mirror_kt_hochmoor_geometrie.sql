{{ config(materialized='table') }} 

SELECT 
  nextval('{{target.schema}}.t_ili2db_seq'::regclass) as t_id,
  {{ var('data_basket')['t_id'] }}::bigint as t_basket,
  -- t_ili_tid::character varying(200),
  -- hm_typ::bigint, --optional
  -- hm_ke::bigint, --optional
  geo_obj::geometry(MultiPolygon,2056),
  t_id as kt_hochmoor_teilobjekt
FROM {{ ref('teilobjekte_sf') }} 
WHERE biotopart = 'Hochmoor'