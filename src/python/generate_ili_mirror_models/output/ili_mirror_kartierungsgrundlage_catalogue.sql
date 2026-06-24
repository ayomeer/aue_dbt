{{ config(materialized='table', enabled=false) }} 

SELECT 
  t_id::bigint, -- NOT NULL
  t_basket::bigint, -- NOT NULL
  t_ili_tid::character varying(200), 
  acode::character varying(3), -- NOT NULL
  adescription::text, 
  adescription_de::text, 
  adescription_fr::text, 
  adescription_rm::text, 
  adescription_it::text, 
  adescription_en::text 
FROM {{ ref('placeholder') }}