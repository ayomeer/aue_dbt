{{ config(materialized='table') }} 

SELECT 
  t_id::bigint, -- NOT NULL
  {{ var('data_basket')['t_id'] }}::bigint as t_basket, -- NOT NULL
  '{{ var('data_dataset')['datasetname'] }}'::character varying(200) as t_datasetname, -- NOT NULL
  oid_uuid::character varying(200) as t_ili_tid, 
  teilobj_nr::character varying(20), -- NOT NULL
  -- am_l_bereich::bigint, 
  ST_Force3D(geo_obj)::geometry(MultiPolygonZ,2056) as geo_obj, -- NOT NULL
  t_id_biotop as kt_amphibiengebiet -- NOT NULL
FROM {{ ref('teilobjekte_sf') }}
WHERE biotopart IN ('Amphibienlaichgebiet, Kernbereich', 'Amphibienlaichgebiet')