{{ config(materialized='table', enabled=true) }} 

SELECT 
  nextval('dbt_ersatzbiotope.t_ili2db_seq'::regclass) as t_id,
  {{ var('baskets')['catalogues']['t_id'] }}::bigint as t_basket,
  uuid_generate_v4()::character varying(200) as t_ili_tid,
  acode::character varying(3),
  adescription::text,
  adescription_de::text,
  adescription_fr::text,
  --adescription_rm::text,
  adescription_it::text
  --adescription_en::text
FROM {{ ref('kartierungsgrundlage_catalogue') }}