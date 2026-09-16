{{ config(materialized='table') }} 

SELECT 
  nextval('{{target.schema}}.t_ili2db_seq'::regclass) as t_id, -- NOT NULL
  {{ var('pub_gl_biotope_data_basket_t_id') }}::bigint as t_basket, -- NOT NULL
  uuid_generate_v4()::uuid as t_ili_tid, -- generate on insert
  
  p.objekt_nummer::text, -- NOT NULL
  p.teilobj_nr::text as teilobj_nummer, -- NOT NULL
  p.objekt_name::text, 
  p.teilobj_name::text as teilobjekt_name, 

  p.bund_nr::text as bund_nummer, 
  p.bund_name::text, 
  p.bund_teilobj_nr::text as bund_teilobj_nr, 
  p.bund_typ::text, 

  p.biotopart::text, -- NOT NULL
  p.beschreibung_de::text as beschreibung, 

  p.geometrie::geometry(MultiPoint,2056) -- NOT NULL
FROM {{ ref('stg_biotope_to_pt') }} as p
WHERE p.publikation_biotopverzeichnis is true