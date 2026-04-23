
SELECT
  ids.t_id as t_id,
  {{ var('baskets')['basket_quellkataster_access']['t_id'] }} as t_basket,
  uuid_generate_v4() as t_ili_tid,
  s.*,
  o.t_id as von_quelle
FROM {{ ref('staging_access_messdaten') }} as s
LEFT JOIN {{ ref('intermediate_access_messdaten_ids') }} as ids
  ON ids.pkey_src = s.pkey_src
LEFT JOIN {{ ref('intermediate_access_objektdaten') }} as o 
  ON s.fkey_quelle_src = o.pkey_src 

