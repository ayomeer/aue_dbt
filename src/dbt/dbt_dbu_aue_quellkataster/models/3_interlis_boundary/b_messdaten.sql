  
SELECT  
  nextval('dbu_aue_quellkataster.t_ili2db_seq'::regclass) as t_id,
  {{ var('baskets')['basket_quellkataster_access']['t_id'] }} as t_basket,
  uuid_generate_v4() as t_ili_tid,
  entnahmedatum::date,
  entnahmezeit::time,
  witterung::varchar,
  schuettungsmenge::numeric,
  wassertemperatur::numeric,
  ph_wert::varchar,
  sauerstoff::varchar,
  sauerstoffsaettigung::varchar,
  chemische_analysen::varchar,
  bemerkungen::varchar,
  von_quelle::bigint
FROM {{ ref('staging_access_messdaten') }} 