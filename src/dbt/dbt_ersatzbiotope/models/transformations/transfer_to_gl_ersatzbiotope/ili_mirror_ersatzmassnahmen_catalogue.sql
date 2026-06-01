{{ config(materialized='table') }}

SELECT
  future_t_id as t_id,
  '{{ var('baskets')['catalogues_basket']['t_id'] }}'::character varying as t_basket,
  uuid_generate_v4() as t_ili_tid,
  kategorie_ersatzmassnahme as kategorie
FROM {{ ref('stg_cat_kategorie_ersatzmassnahme') }}
