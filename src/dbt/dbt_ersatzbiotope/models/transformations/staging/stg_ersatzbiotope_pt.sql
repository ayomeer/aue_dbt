SELECT 
  gid::bigint, -- NOT NULL
  objekt_nummer::bigint, 
  teilobjekt_nummer::bigint, 
  ersatzmassnahme::character varying, 
  kategorie_ersatzmassnahme::character varying, 
  ziellebensraum::character varying, 
  flaeche_m2::bigint, 
  entscheide::character varying, 
  projekttraeger::character varying, 
  dokumente::character varying, 
  bemerkungen_intern::character varying, 
  geometrie::geometry(MultiPoint, 2056) as geometrie_pt
FROM {{ source('prod_gl_ersatzbiotope', 'ersatzbiotope_pt') }}