SELECT 
  t_id::bigint, -- NOT NULL
  t_basket::bigint, -- NOT NULL
  t_ili_tid::character varying(200), 
  strasse::text, -- NOT NULL
  hausnummer::text, 
  adresszusatz::text, 
  postfach::text, 
  plz::text, -- NOT NULL
  ort::text, -- NOT NULL
  kanton::character varying(255), 
  land::character varying(255) -- NOT NULL
FROM {{ source('prod_gl_gewaesserzustand', 'adresse') }}