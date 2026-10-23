SELECT
  ids.t_id as t_id,
  {{ var('baskets')['basket_quellkataster_alpquellen']['t_id'] }}::bigint as t_basket,
  uuid_generate_v4() as t_ili_tid, 
  a.*
FROM {{ ref('staging_alpquellen') }} as a
LEFT JOIN {{ ref('intermediate_alpquellen_ids') }} as ids
  ON ids.pkey_src = a.pkey_src