{{ config(materialized='table') }} 

SELECT 
  nextval('{{target.schema}}.t_ili2db_seq'::regclass)::bigint as t_id,
  {{ var('data_basket')['t_id'] }}::bigint as t_basket,
  --t_ili_tid::uuid, (letting this be auto-generated on insert)
  teilobj_nr::character varying(30),
  -- hm_to::integer, (optional) 
  t_id_biotop::bigint as kt_hochmoor
FROM {{ ref('teilobjekte_sf') }}
WHERE biotopart = 'Hochmoor'