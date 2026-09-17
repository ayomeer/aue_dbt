SELECT 
  gid::integer, -- NOT NULL
  objekt_nummer::character varying(10), 
  teilobjekt_nummer::character varying(10), 
  objekt_name::character varying(255), 
  biotoptyp::character varying(255), 
  the_geom::geometry(MultiPolygon,2056), 
  planart::character varying
FROM {{ source('prod_gl_biotope', 'biotope_national') }}