{{ config(materialized='table', enabled=false) }} 

SELECT 
  t_id::bigint, -- NOT NULL
  t_basket::bigint, -- NOT NULL
  t_ili_tid::character varying(200), 
  aname::text, 
  aname_de::text, 
  aname_fr::text, 
  aname_rm::text, 
  aname_it::text, 
  aname_en::text, 
  abkuerzung::text, 
  abkuerzung_de::text, 
  abkuerzung_fr::text, 
  abkuerzung_rm::text, 
  abkuerzung_it::text, 
  abkuerzung_en::text, 
  beschreibung::text, 
  beschreibung_de::text, 
  beschreibung_fr::text, 
  beschreibung_rm::text, 
  beschreibung_it::text, 
  beschreibung_en::text, 
  gueltig_von::date, -- NOT NULL
  gueltig_bis::date -- NOT NULL
FROM {{ ref('placeholder') }}