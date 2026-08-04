{{ config(materialized='table', enabled=false) }} 

SELECT 
  t_id::bigint, -- NOT NULL
  t_basket::bigint, -- NOT NULL
  t_ili_tid::character varying(200), 
  aparameter::bigint, 
  gueltig_von::date, -- NOT NULL
  gueltig_bis::date, -- NOT NULL
  erhebung::bigint, 
  periodizitaet::bigint, 
  vorgaenger::text, 
  messgruppierung::bigint -- NOT NULL
FROM {{ ref('placeholder') }}