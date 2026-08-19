{{ config(materialized='table', enabled=false) }} 

SELECT 
  t_id::bigint, -- NOT NULL
  t_basket::bigint, -- NOT NULL
  t_ili_tid::uuid, 
  bezeichnung::character varying(20), 
  erhebungsjahr::integer, 
  beschreibung_lebensraeume::text, 
  anteil_schuetzenswerte_lebensraeume::integer, -- NOT NULL
  geometrie::geometry(MultiPolygon2056) -- NOT NULL
FROM {{ ref('placeholder') }}