{{ config(materialized='table') }} 

SELECT 
  t_id::bigint, -- NOT NULL
  {{ var('data_basket')['t_id'] }}::bigint as t_basket, -- NOT NULL
  oid_uuid::character varying(200) as t_ili_tid, 
  teilobj_nr::character varying(30), -- NOT NULL
  geo_obj::geometry(MultiPolygon,2056), -- NOT NULL
  t_id_biotop::bigint as biotop -- NOT NULL
FROM {{ ref('teilobjekte_sf') }}
WHERE biotopart NOT IN (
  'Auengebiet',
  'Hochmoor',
  'Flachmoor',
  'Amphibienlaichgebiet, Kernbereich',
  'Amphibienlaichgebiet',
  'TWW-Magerheuwiese',
  'TWW-Magerweide'
)