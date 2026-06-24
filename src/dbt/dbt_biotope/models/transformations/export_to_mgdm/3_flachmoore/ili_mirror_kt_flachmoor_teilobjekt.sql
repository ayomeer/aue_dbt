{{ config(materialized='table') }} 

SELECT 
  t_id::bigint, -- NOT NULL
  {{ var('data_basket')['t_id'] }}::bigint as t_basket, -- NOT NULL
  --t_ili_tid::uuid, (letting this be auto-generated on insert)
  teilobj_nr::character varying(30), -- NOT NULL
  geo_obj::geometry(MultiPolygon,2056), -- NOT NULL
  t_id_biotop::bigint as kt_flachmoor-- NOT NULL
FROM {{ ref('teilobjekte_sf') }}
WHERE biotopart = 'Flachmoor'