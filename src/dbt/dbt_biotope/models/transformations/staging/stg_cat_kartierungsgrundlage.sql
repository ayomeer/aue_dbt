SELECT 
  id_kg::integer,
  kartierungsgrundlage::character varying,
  last_modified::date,
  last_user::character varying,
  oid_uuid::uuid,
  code_bund::character varying
FROM {{ source('prod_gl_biotope', 'cat_kartierungsgrundlage') }}