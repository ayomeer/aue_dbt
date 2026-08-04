SELECT 
  t_id::bigint, -- NOT NULL
  t_basket::bigint, -- NOT NULL
  t_ili_tid::character varying(200), 
  aname::text, -- NOT NULL
  abkuerzung::text, 
  beschreibung::text, 
  gueltig_von::date, -- NOT NULL
  gueltig_bis::date, -- NOT NULL
  verantwortlichkeit::bigint -- NOT NULL
FROM {{ source('prod_gl_gewaesserzustand', 'messnetz') }}