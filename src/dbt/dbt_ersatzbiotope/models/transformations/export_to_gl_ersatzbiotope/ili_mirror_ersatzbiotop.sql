{{ config(materialized='table') }}

select
  nextval('dbt_ersatzbiotope.t_ili2db_seq'::regclass) as t_id,
  '{{ var('export_config_gl')['data_basket_tid'] }}'::bigint as t_basket,
  'GL'::varchar as kanton,
  objekt_nummer::integer,
  projekttraeger::varchar
from {{ ref('aggregate_into_ersatzbiotop') }}