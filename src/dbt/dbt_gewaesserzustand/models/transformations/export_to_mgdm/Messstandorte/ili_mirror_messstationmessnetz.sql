{{ config(materialized='table', enabled=false) }} 

SELECT 
  t_id::bigint, -- NOT NULL
  t_basket::bigint, -- NOT NULL
  werterhebung::bigint, -- NOT NULL
  messnetz::bigint -- NOT NULL
FROM {{ ref('placeholder') }}