SELECT 
  t_id::bigint, -- NOT NULL
  t_basket::bigint, -- NOT NULL
  t_ili_tid::character varying(200), 
  organisation::text, 
  abkuerzung::text, 
  abteilung::text, 
  sektion::text, 
  email::character varying(1023), 
  link::character varying(1023), -- NOT NULL
  bezeichnung::text, -- NOT NULL
  beschreibung::text, 
  adresse::bigint 
FROM {{ source('prod_gl_gewaesserzustand', 'verantwortlichkeit') }}