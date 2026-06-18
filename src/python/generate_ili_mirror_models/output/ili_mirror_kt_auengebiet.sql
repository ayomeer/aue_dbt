{{ config(materialized='table', enabled=false) }} 

SELECT 
  t_id::bigint,
  t_basket::bigint,
  t_ili_tid::uuid,
  kanton::character varying(255),
  objnummer::character varying(30),
  aname::character varying(80),
  obj_gisflaeche::numeric(12,3),
  au_typ::bigint,
  herkunft::character varying(250),
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