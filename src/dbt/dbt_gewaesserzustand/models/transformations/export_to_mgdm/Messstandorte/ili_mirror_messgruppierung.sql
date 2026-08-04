{{ config(materialized='table', enabled=false) }} 

SELECT 
  t_id::bigint, -- NOT NULL
  t_basket::bigint, -- NOT NULL
  t_ili_tid::character varying(200), 
  gewaessername::text, -- NOT NULL
  ortsbezeichnung::text, -- NOT NULL
  acode::text, -- NOT NULL
  gueltig_von::date, -- NOT NULL
  gueltig_bis::date, -- NOT NULL
  art_gruppierung::bigint, 
  gewaessertyp::bigint, 
  einzugsgebietsgroesse::numeric(10,1), 
  mittlere_hoehe::integer, 
  vergletscherungsgrad::numeric(4,1), 
  url_datenblatt_kanton::character varying(1023) 
FROM {{ ref('placeholder') }}