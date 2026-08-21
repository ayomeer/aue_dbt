{{ config(materialized='table', enabled=false) }} 

SELECT 
  t_id::bigint, -- NOT NULL
  t_basket::bigint, -- NOT NULL
  t_ili_tid::uuid, 
  geo_obj::geometry(MultiPoint,2056), -- NOT NULL
  teilobj_nr::integer, -- NOT NULL
  kategorie_ersatzmassnahme::bigint, 
  ersatzmassnahme::text, -- NOT NULL
  ziellebensraum::character varying(255), 
  entscheide::text, 
  dokumente::text, 
  von_ersatzbiotop::bigint
FROM {{ ref('placeholder') }}