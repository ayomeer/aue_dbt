{{ config(
    enabled= not var('enable_transfer', false), 
    materialized='table',
    post_hook='ALTER TABLE {{this}} ADD PRIMARY KEY (bewirtschafternummer)'
) }}

SELECT
    * 
FROM {{ ref('stg_bewirtschafter') }}
WHERE bewirtschafternummer <> 'keine'
ORDER BY bewirtschafternummer