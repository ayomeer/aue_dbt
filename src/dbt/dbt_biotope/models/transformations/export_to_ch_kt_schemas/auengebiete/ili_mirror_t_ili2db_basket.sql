-- depends_on {{ ref('ili_mirror_t_ili2db_dataset') }}

{{ config(materialized='table', enabled=true) }} 

SELECT 
  t_id::bigint,
  dataset::bigint,
  topic::character varying(200),
  uuid_generate_v4() as t_ili_tid,
  'x'::character varying(200) as attachmentkey
FROM {{ ref('auengebiete_basket') }}