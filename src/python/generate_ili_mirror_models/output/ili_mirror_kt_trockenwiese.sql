{{ config(materialized='table', enabled=false) }} 

SELECT 
  t_id::bigint, -- NOT NULL
  t_basket::bigint, -- NOT NULL
  t_ili_tid::character varying(200), 
  kanton::character varying(255), -- NOT NULL
  objnummer::character varying(30), -- NOT NULL
  aname::character varying(80), 
  obj_gisflaeche::numeric(12,3), -- NOT NULL
  herkunft::character varying(250), -- NOT NULL
  kartierungsgrundlage::bigint, 
  aufnahmedatum::date, 
  mutationsdatum::date, 
  mutationsgrund::text, 
  mutationsgrund_de::text, 
  mutationsgrund_fr::text, 
  mutationsgrund_rm::text, 
  mutationsgrund_it::text, 
  mutationsgrund_en::text, 
  bedeutung::bigint 
FROM {{ ref('placeholder') }}