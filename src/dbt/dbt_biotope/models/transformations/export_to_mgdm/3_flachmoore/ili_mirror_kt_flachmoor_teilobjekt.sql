{{ config(materialized='table') }} 

SELECT 
  nextval('{{target.schema}}.t_ili2db_seq'::regclass)::bigint as t_id,
  {{ var('data_basket')['t_id'] }}::bigint as t_basket, -- NOT NULL
  uuid_generate_v4()::character varying(200) as t_ili_tid, , (letting this be auto-generated on insert)
  teilobj_nr::character varying(30), -- NOT NULL
  geo_obj::geometry(MultiPolygon,2056), -- NOT NULL
  t_id_biotop::bigint as kt_flachmoor-- NOT NULL
FROM {{ ref('teilobjekte_sf') }}
WHERE biotopart = 'Flachmoor'