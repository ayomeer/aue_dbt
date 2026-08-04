SELECT 
  t_id::bigint, -- NOT NULL
  t_basket::bigint, -- NOT NULL
  t_ili_tid::character varying(200), 
  aparameter::bigint, 
  gueltig_von::date, -- NOT NULL
  gueltig_bis::date, -- NOT NULL
  erhebung::bigint, 
  periodizitaet::bigint, 
  vorgaenger::text, 
  messgruppierung::bigint, -- NOT NULL
  messnetz::bigint, -- NOT NULL
  verantwortlichkeit::bigint -- NOT NULL
FROM {{ source('prod_gl_gewaesserzustand', 'werterhebung') }}