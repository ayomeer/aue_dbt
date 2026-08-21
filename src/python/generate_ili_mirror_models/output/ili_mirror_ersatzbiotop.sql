{{ config(materialized='table', enabled=false) }} 

SELECT 
  t_id::bigint, -- NOT NULL
  t_basket::bigint, -- NOT NULL
  t_ili_tid::uuid, 
  kanton::character varying(255), -- NOT NULL
  objekt_nummer::integer, -- NOT NULL
  projekttraeger::character varying(255)
FROM {{ ref('placeholder') }}