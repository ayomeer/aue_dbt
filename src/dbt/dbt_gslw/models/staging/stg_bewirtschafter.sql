SELECT 
  t_id::bigint, -- NOT NULL
  t_basket::bigint, -- NOT NULL
  t_ili_tid::uuid, 
  bewirtschafternummer::character varying, -- NOT NULL
  bname::character varying(40), 
  bvorname::character varying(40), 
  badresse::character varying(40), 
  bwohnort::character varying(20), 
  bplz::integer, 
  ablagenr::integer, 
  bemerkungen::text, 
  orgname::character varying(40), 
  orgtyp::character varying(40), 
  gws_relevant::boolean, -- NOT NULL
  created::date, 
  lastmodified::date, 
  banrede::character varying, 
  bansprech::character varying, 
  old_id::integer, 
  gws_ersterhebung_io::boolean
FROM {{ source('dbu_aue_gslw', 'bewirtschafter') }}