-- depends_on: {{ ref('wait_on_catalogue_ili_mirrors') }}

{{ config(materialized='table') }}

select
  nextval('dbt_ersatzbiotope.t_ili2db_seq'::regclass) as t_id,
  '{{ var('baskets')['basket_data']['t_id'] }}'::bigint as t_basket,
  14::integer as kanton,
  objekt_nummer,
  projekttraeger
from {{ ref('aggregate_into_ersatzbiotop') }}