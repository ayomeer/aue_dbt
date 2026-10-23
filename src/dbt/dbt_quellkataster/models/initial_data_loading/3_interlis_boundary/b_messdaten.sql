  
{{ config(materialized='table')}} -- so type casts are actually done and checked

SELECT  
  t_id,
  t_basket,
  t_ili_tid,
  entnahmedatum::date,
  entnahmezeit::time,
  witterung::varchar,
  schuettungsmenge::numeric(9,2),
  wassertemperatur::numeric(4,1),
  ph_wert::varchar,
  sauerstoff::varchar,
  sauerstoffsaettigung::varchar,
  chemische_analysen::varchar,
  bemerkungen::varchar,
  von_quelle::bigint
FROM {{ ref('intermediate_access_messdaten') }} as i
