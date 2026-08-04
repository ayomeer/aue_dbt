{{ config(materialized='table', enabled=false) }} 

SELECT 
  t_id::bigint, -- NOT NULL
  t_basket::bigint, -- NOT NULL
  t_ili_tid::character varying(200), 
  nummer::character varying(20), 
  typ::bigint, 
  verantwortlichkeit::bigint 
FROM {{ ref('placeholder') }}