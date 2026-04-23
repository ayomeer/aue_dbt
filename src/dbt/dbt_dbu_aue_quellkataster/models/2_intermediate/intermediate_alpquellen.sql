SELECT
  nextval('dbu_aue_quellkataster.t_ili2db_seq'::regclass) as t_id,
  {{ var('baskets')['basket_quellkataster_alpquellen']['t_id'] }}::bigint as t_basket,
  uuid_generate_v4() as t_ili_tid, 
  a.*
FROM {{ ref('staging_alpquellen') }} as a