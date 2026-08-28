{{ config(materialized='table', enabled=false) }} 

SELECT 
  nextval('{{target.schema}}.t_ili2db_seq'::regclass) as t_id, -- NOT NULL
  {{ var('data_basket')['t_id'] }}::bigint as t_basket, -- NOT NULL
  uuid_generate_v4()::uuid as t_ili_tid, -- generate on insert

  (ST_Area() / 100)::numeric(12,3) as flaeche_ha, 
  f.geometrie::geometry(MultiPolygon,2056), -- NOT NULL
  f.kanton::character varying(255), -- NOT NULL
  f.objekt_nummer::text, -- NOT NULL
  f.objekt_name::text, 

  f.bund_nummer::text, 
  f.bund_name::text, 
  f.bund_teilobjekt_nummer::text, 
  f.bund_typ::text, 
  
  f.teilobjekt_nummer::text, -- NOT NULL
  f.teilobjekt_name::text, 
  
  f.biotopart::text, -- NOT NULL
  f.beschreibung_de as beschreibung::text, 
  f.herkunft::text, -- NOT NULL
  f.kartierungsgrundlage::text, -- NOT NULL
  f.bedeutung::text, -- NOT NULL
  f.status_biotopverzeichnis as rechtsstatus::text, -- NOT NULL
  spezielle_arten::text, 
  entscheid::text 
FROM {{ ref('placeholder') }} as f