{{ config(materialized='table', enabled=true) }} 

SELECT 
  t_id::bigint,
  datasetname::character varying(200)
FROM {{ ref('auengebiete_dataset') }}