SELECT 
  nextval('dbt_ersatzbiotope.t_ili2db_seq'::regclass) as t_id,
  '{{ var('baskets')['basket_data']['t_id'] }}'::bigint as t_basket,
  uuid_generate_v4() as t_ili_tid,
  flaeche_m2::numeric(12,3),
  geo_obj::geometry(MultiPolygon,2056),
  objekt_nummer::integer,
  teilobj_nr::integer,
  kategorie_ersatzmassnahme::character varying(255),
  ersatzmassnahme::character varying(255),
  ziellebensraum::character varying(255),
  entscheide::text
FROM { ref('placeholder') }