{{ config(materialized='table', enabled=false) }} 

SELECT 
  t_id::bigint, -- NOT NULL
  t_basket::bigint, -- NOT NULL
  t_ili_tid::character varying(200), 
  organisation::text, 
  organisation_de::text, 
  organisation_fr::text, 
  organisation_rm::text, 
  organisation_it::text, 
  organisation_en::text, 
  abkuerzung::text, 
  abkuerzung_de::text, 
  abkuerzung_fr::text, 
  abkuerzung_rm::text, 
  abkuerzung_it::text, 
  abkuerzung_en::text, 
  abteilung::text, 
  abteilung_de::text, 
  abteilung_fr::text, 
  abteilung_rm::text, 
  abteilung_it::text, 
  abteilung_en::text, 
  sektion::text, 
  sektion_de::text, 
  sektion_fr::text, 
  sektion_rm::text, 
  sektion_it::text, 
  sektion_en::text, 
  email::character varying(1023), 
  link::character varying(1023), -- NOT NULL
  adresse::bigint 
FROM {{ ref('placeholder') }}