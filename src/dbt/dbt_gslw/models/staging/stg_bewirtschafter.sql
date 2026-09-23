SELECT 
  t_id::bigint, -- NOT NULL
  t_basket::bigint, -- NOT NULL
  t_ili_tid::uuid, 
  
  -- Felder, welche von Export Landwirtschaft aktuelisiert werden
  bewirtschafternummer::character varying, -- NOT NULL
  banrede::character varying, 
  bansprech::character varying, 
  bname::character varying(40), 
  bvorname::character varying(40), 
  badresse::character varying(40), 
  bwohnort::character varying(20), 
  bplz::integer, 

  -- Andere, intern genutzte Felder
  bemerkungen::text, 
  orgname::character varying(40), 
  orgtyp::character varying(40), 
  ablagenr::integer, 
  gws_relevant::boolean, -- NOT NULL
  old_id::integer, 
  gws_ersterhebung_io::boolean,
  created::date, 
  lastmodified::date
FROM {{ source('dbu_aue_gslw', 'bewirtschafter') }}