{{ config(materialized='table', enabled=false) }} 

SELECT 
  itfcode::integer, -- NOT NULL
  ilicode::character varying(1024), -- NOT NULL
  seq::integer, 
  inactive::boolean, -- NOT NULL
  dispname::character varying(250), -- NOT NULL
  description::character varying(1024) 
FROM {{ ref('placeholder') }}