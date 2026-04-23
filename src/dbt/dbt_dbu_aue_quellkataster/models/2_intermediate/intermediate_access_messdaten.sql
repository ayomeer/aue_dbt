
SELECT
  nextval('dbu_aue_quellkataster.t_ili2db_seq'::regclass) as t_id,
  {{ var('baskets')['basket_quellkataster_access']['t_id'] }} as t_basket,
  s.*,
  o.t_id as von_quelle
FROM {{ ref('staging_access_messdaten') }} as s
LEFT JOIN {{ ref('intermediate_access_objektdaten') }} as o 
  ON s.fkey_quelle_src = o.pkey_src 

