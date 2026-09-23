SELECT 
  id::integer, -- NOT NULL
  badrnummer::integer, 
  
  
  kt_id::character varying as bewirtschafternummer, 
  banrede::character varying, 
  bansprech::character varying, 
  bname::character varying, 
  bvorname::character varying, 
  bstrasse::character varying as badresse, 
  bwohnort::character varying, 
  bplz::integer, 
  
  -- nicht für gslw genutzt
  e_mail::character varying, 
  bank_name::character varying, 
  bank_kt_nr::character varying, 
  iban::character varying, 
  bank_name1::character varying, 
  bank_name2::character varying, 
  bank_plz::integer, 
  bank_ort::character varying, 
  telefon_nr::character varying, 
  telefon_nr3::character varying, 
  dz::character varying
FROM {{ source('dbt_gslw', 'imp_bew_agricola') }}
WHERE kt_id LIKE '%/ 1/%'
   OR kt_id LIKE '%/50/%'