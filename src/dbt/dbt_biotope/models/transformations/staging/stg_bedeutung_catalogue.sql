SELECT 
  t_id::bigint,
  t_basket::bigint,
  t_ili_tid::character varying(200),
  acode::character varying(3),
  adescription::text,
  adescription_de::text,
  adescription_fr::text,
  adescription_rm::text,
  adescription_it::text,
  adescription_en::text
FROM {{ source('ch_kt_auengebiete', 'bedeutung_catalogue') }}