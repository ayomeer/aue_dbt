{{ config(materialized='table', enabled=false) }} 

SELECT 
  t_id::bigint, -- NOT NULL
  t_basket::bigint, -- NOT NULL
  t_ili_tid::uuid, 
  laenge_m::integer, 
  geo_obj::geometry(MultiLineString,2056), -- NOT NULL
  objekt_nummer::integer, -- NOT NULL
  teilobj_nr::integer, -- NOT NULL
  kategorie_ersatzmassnahme::character varying(255), 
  ziellebensraum::character varying(255), 
  entscheide::text
FROM {{ ref('placeholder') }}