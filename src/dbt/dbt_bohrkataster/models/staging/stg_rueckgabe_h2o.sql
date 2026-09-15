SELECT 
  gid::integer, -- NOT NULL
  the_geom::geometry(Point,2056), 
  location_x::real, 
  location_y::real, 
  id_konzession::integer, -- NOT NULL
  typ::dbu_aue_gsbohrung.dbu_aue_gsbohrung_rueckgabe_h2o_typ, 
  status::dbu_aue_gsbohrung.dbu_aue_gsbohrung_rueckgabe_h2o_status, 
  last_modified::timestamp without time zone, 
  bezeichnung::character varying, 
  bemerkungen::text, 
  sickerversuch::real, 
  id::integer, -- NOT NULL
  bohrprofil_pdf::character varying, 
  publikation::boolean,

  -- additional derived attributes
  'Grundwasserwärmepume Rückgabe' as kategorie,
  string_to_array(bohrprofil_pdf, '\') as arr_pdf
FROM {{ source('dbu_aue_gsbohrung', 'rueckgabe_h2o') }}