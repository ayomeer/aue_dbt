{{ config(materialized='table') }} 

SELECT 
  nextval('{{target.schema}}.t_ili2db_seq'::regclass) as t_id, -- NOT NULL
  {{ var('pub_gl_biotope_data_basket_t_id') }}::bigint as t_basket, -- NOT NULL
  uuid_generate_v4()::uuid as t_ili_tid, -- generate on insert

  f.objekt_nummer::text, -- NOT NULL
  f.teilobj_nr::text as teilobj_nummer, -- NOT NULL
  f.objekt_name::text, 
  f.teilobj_name::text as teilobjekt_name, 

  f.bund_nr::text as bund_nummer, 
  f.bund_teilobj_nr::text  as bund_teilobj_nr, 
  f.bund_name::text, 
  f.bund_typ::text, 
    
  f.biotopart::text, -- NOT NULL
  f.beschreibung_de::text as beschreibung, 
  f.bedeutung::text, -- NOT NULL
  array_to_string(a.arr_art_deutsch, ', ')::text as spezielle_arten,
  
  f.geometrie::geometry(MultiPolygon,2056), -- NOT NULL
  (ST_Area(f.geometrie) / 100)::numeric(12,3) as flaeche_ha

FROM {{ ref('stg_biotope_to_sf') }} as f
LEFT JOIN {{ ref('spezielle_arten') }} as a
  ON a.sf_gid = f.gid
WHERE f.publikation_biotopverzeichnis is true