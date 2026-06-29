{{ config(materialized='table') }} 

SELECT 
  nextval('{{target.schema}}.t_ili2db_seq'::regclass)::bigint as t_id, -- NOT NULL
  {{ var('data_basket')['t_id'] }}::bigint as t_basket, -- NOT NULL
  -- t_ili_tid::character varying(200), 
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