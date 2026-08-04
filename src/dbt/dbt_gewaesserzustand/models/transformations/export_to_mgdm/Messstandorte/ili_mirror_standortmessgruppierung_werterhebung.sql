{{ config(materialized='table', enabled=false) }} 

SELECT 
  t_id::bigint, -- NOT NULL
  t_basket::bigint, -- NOT NULL
  standort::bigint, -- NOT NULL
  m_w_messgruppierung::bigint, 
  m_w_werterhebung::bigint, 
  typ::text, -- NOT NULL
  beschreibung::text, 
  beschreibung_de::text, 
  beschreibung_fr::text, 
  beschreibung_rm::text, 
  beschreibung_it::text, 
  beschreibung_en::text 
FROM {{ ref('placeholder') }}