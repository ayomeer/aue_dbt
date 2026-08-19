{{ config(materialized='table', enabled=false) }} 

SELECT 
  t_id::bigint, -- NOT NULL
  t_basket::bigint, -- NOT NULL
  t_ili_tid::uuid, 
  geometrie::geometry(MultiPoint,2056), -- NOT NULL
  kanton::character varying(255), -- NOT NULL
  objekt_nummer::text, -- NOT NULL
  objekt_name::text, 
  bund_nummer::text, 
  bund_name::text, 
  bund_teilobjekt_nummer::text, 
  bund_typ::text, 
  teilobjekt_nummer::text, -- NOT NULL
  teilobjekt_name::text, 
  biotopart::text, -- NOT NULL
  beschreibung::text, 
  herkunft::text, -- NOT NULL
  kartierungsgrundlage::text, -- NOT NULL
  bedeutung::text, -- NOT NULL
  rechtsstatus::text, -- NOT NULL
  spezielle_arten::text, 
  entscheid::text 
FROM {{ ref('placeholder') }}