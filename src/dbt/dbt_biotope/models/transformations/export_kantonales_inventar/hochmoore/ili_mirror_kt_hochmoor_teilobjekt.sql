{{ config(materialized='table') }} 

SELECT 
  t_id::bigint, -- NOT NULL
  {{ var('data_basket')['t_id'] }}::bigint as t_basket,
  '{{ var('data_dataset')['datasetname'] }}'::character varying(200) as t_datasetname, -- NOT NULL
  oid_uuid::character varying(200) as t_ili_tid, 
  teilobj_nr::character varying(30),
  -- hm_to::integer, (optional) 
  t_id_biotop::bigint as kt_hochmoor
FROM {{ ref('teilobjekte_sf') }}
WHERE biotopart = 'Hochmoor'