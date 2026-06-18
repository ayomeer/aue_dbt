{{ config(materialized='table') }} 

SELECT 
  nextval('dbt_ersatzbiotope.t_ili2db_seq'::regclass) as t_id,
  {{ var('baskets')['kt_auengebiete']['catalogues']['t_id'] }}::bigint as t_basket,
  uuid_generate_v4()::character varying(200) as t_ili_tid,
  code_bund::character varying(3) as acode,
  kartierungsgrundlage::text as adescription,
  kartierungsgrundlage::text as adescription_de
  --adescription_fr::text,
  --adescription_rm::text,
  --adescription_it::text
  --adescription_en::text
FROM {{ ref('stg_cat_kartierungsgrundlage') }}