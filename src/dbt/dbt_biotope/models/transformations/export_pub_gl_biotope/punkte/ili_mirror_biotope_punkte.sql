{{ config(materialized='table') }} 

SELECT 
  nextval('{{target.schema}}.t_ili2db_seq'::regclass) as t_id, -- NOT NULL
  {{ var('pub_gl_biotope_data_basket_t_id') }}::bigint as t_basket, -- NOT NULL
  uuid_generate_v4()::uuid as t_ili_tid, -- generate on insert
  
  p.geometrie::geometry(MultiPoint,2056), -- NOT NULL
  p.kanton::character varying(255), -- NOT NULL
  p.objekt_nummer::text, -- NOT NULL
  p.objekt_name::text, 

  p.bund_nr::text as bund_nummer, 
  p.bund_name::text, 
  p.bund_teilobj_nr::text as bund_teilobjekt_nummer, 
  p.bund_typ::text, 

  p.teilobj_nr::text as teilobjekt_nummer, -- NOT NULL
  p.teilobj_name::text as teilobjekt_name, 

  p.biotopart::text, -- NOT NULL
  p.beschreibung_de::text as beschreibung, 
  p.bedeutung::text -- NOT NULL

FROM {{ ref('stg_biotope_to_pt') }} as p
WHERE p.publikation_biotopverzeichnis is true