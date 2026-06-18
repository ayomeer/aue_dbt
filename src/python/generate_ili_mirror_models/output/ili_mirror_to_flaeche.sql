{{ config(materialized='table') }} 

SELECT 
  t_id::bigint,
  t_basket::bigint,
  t_ili_tid::uuid,
  flaeche_m2::numeric(12,3),
  geo_obj::geometry(MultiPolygon,2056),
  objekt_nummer::integer,
  teilobj_nr::integer,
  kategorie_ersatzmassnahme::character varying(255),
  ersatzmassnahme::character varying(255),
  ziellebensraum::character varying(255),
  entscheide::text
FROM {{ ref('placeholder') }}