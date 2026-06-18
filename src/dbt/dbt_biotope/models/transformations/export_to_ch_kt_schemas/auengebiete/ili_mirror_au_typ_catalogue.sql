{{ config(materialized='table') }} 

SELECT 
  t_id::bigint,
  t_basket::bigint,
  t_ili_tid::character varying(200),
  acode::character varying(8),
  adescription::text,
  adescription_de::text,
  adescription_fr::text,
  adescription_rm::text,
  adescription_it::text,
  adescription_en::text
FROM {{ ref('placeholder') }}