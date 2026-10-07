{{ config(materialized='table') }} 

SELECT 
  nextval('{{target.schema}}.t_ili2db_seq'::regclass) as t_id, -- NOT NULL
  {{ var('pub_gl_biotope_data_basket_t_id') }}::bigint as t_basket, -- NOT NULL
  uuid_generate_v4()::uuid as t_ili_tid, -- generate on insert

  l.objekt_nummer::text, -- NOT NULL
  l.teilobj_nr::text as teilobj_nummer, -- NOT NULL
  l.objekt_name::text, 
  l.teilobj_name::text as teilobjekt_name, 

  l.bund_nr::text as bund_nummer, 
  l.bund_teilobj_nr::text  as bund_teilobj_nr, 
  l.bund_name::text, 
  l.bund_typ::text, 

  l.biotopart::text, -- NOT NULL
  l.beschreibung_de::text as beschreibung, 

  l.geometrie::geometry(MultiLineString,2056), -- NOT NULL
  ST_Length(l.geometrie)::integer as laenge_m

FROM {{ ref('stg_biotope_to_li') }} as l
WHERE l.publikation_biotopverzeichnis is true