{{ config(materialized='table') }} 

SELECT 
  nextval('dbt_bohrkataster.t_ili2db_seq'::regclass)::bigint as t_id, -- NOT NULL
  {{ var('export_pub_gl_bohrkataster')['data_basket_tid'] }}::bigint as t_basket, -- NOT NULL
  uuid_generate_v4() as t_ili_tid, 
  u.koordinate_e::numeric(10,3), 
  u.koordinate_n::numeric(10,3), 
  trim(u.pdf_basename, '.pdf')::character varying(255) as aname, 
  u.kategorie::character varying(255) as typ, 
  ('https://map.geo.gl.ch/data/gsbohrung_bohrprofile/' || u.pdf_basename)::text as bohrprofil_pdf, 
  u.ablagenummer::integer,
  u.geometrie::geometry(Point,2056)-- NOT NULL
FROM 
  {{ ref('union') }} as u,
  {{ source('ch_av_dm01', 'gemeindegrenze') }} as g
WHERE publikation is true
  AND kategorie in (
    'Grundwasserwärmepumpe Entnahme',
    'Grundwasserwärmepumpe Rückgabe',
    'Grundwasserfassung Trinkwasser',
    'Grundwasserfassung Kühlwasser',
    'Grundwasserfassung Brauchwasser',
    'Erdwärmenutzung',
    'Allgemeine Sondierung'
  )
  AND ST_Within(u.geometrie, g.geometrie)