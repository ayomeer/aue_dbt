{{ config(materialized='table') }} 

SELECT 
  nextval('dbt_bohrkataster.t_ili2db_seq'::regclass)::bigint as t_id, -- NOT NULL
  {{ var('export_pub_gl_bohrkataster')['data_basket_tid'] }}::bigint as t_basket, -- NOT NULL
  uuid_generate_v4() as t_ili_tid, 
  koordinate_e::numeric(10,3), 
  koordinate_n::numeric(10,3), 
  trim(pdf_basename, '.pdf')::character varying(255) as aname, 
  kategorie::character varying(255) as typ, 
  ('https://map.geo.gl.ch/data/gsbohrung_bohrprofile/' || pdf_basename)::text as bohrprofil_pdf, 
  geometrie::geometry(Point,2056)-- NOT NULL
FROM {{ ref('union') }}
WHERE publikation is true
  AND kategorie in (
    'Grundwasserfassung',
    'Grundwasserwärmepume Entnahme',
    'Grundwasserwärmepume Rückgabe',
    'Erdwärmenutzung',
    'Sondierung'
  )