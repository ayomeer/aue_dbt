{{ config(materialized='table') }} 

SELECT 
  nextval('{{target.schema}}.t_ili2db_seq'::regclass) as t_id, -- NOT NULL
  {{ var('pub_gl_biotope_data_basket_t_id') }}::bigint as t_basket, -- NOT NULL
  uuid_generate_v4()::uuid as t_ili_tid, -- generate on insert

  (ST_Area(f.geometrie) / 100)::numeric(12,3) as flaeche_ha, 
  f.geometrie::geometry(MultiPolygon,2056), -- NOT NULL
  f.kanton::character varying(255), -- NOT NULL
  f.objekt_nummer::text, -- NOT NULL
  f.objekt_name::text, 

  f.bund_nr::text as bund_nummer, 
  f.bund_name::text, 
  f.bund_teilobj_nr::text  as bund_teilobjekt_nummer, 
  f.bund_typ::text, 
  
  f.teilobj_nr::text as teilobjekt_nummer, -- NOT NULL
  f.teilobj_name::text as teilobjekt_name, 
  
  f.biotopart::text, -- NOT NULL
  f.beschreibung_de::text as beschreibung, 
  f.herkunft::text, -- NOT NULL
  f.kartierungsgrundlage::text, -- NOT NULL
  f.bedeutung::text, -- NOT NULL
  f.status_biotopverzeichnis::text as rechtsstatus, -- NOT NULL 
  array_to_string(a.arr_art_deutsch, ', ')::text as spezielle_arten, 
  NULL::text as entscheid
FROM {{ ref('stg_biotope_to_sf') }} as f
LEFT JOIN {{ ref('spezielle_arten') }} as a
  ON a.sf_gid = f.gid

-- TODO: Abklären ob Feld rechtsstatus ok so als "Stand"