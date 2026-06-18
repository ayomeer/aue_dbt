SELECT 
  id_btyp::integer,
  biotopart::character varying,
  last_modified::date,
  last_user::character varying,
  oid_uuid::uuid
FROM {{ source('prod_gl_biotope', 'cat_biotopart') }}