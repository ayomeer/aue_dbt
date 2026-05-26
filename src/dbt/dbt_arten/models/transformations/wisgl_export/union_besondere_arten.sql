-- Script by Peter Zopfi integrated into dbt wholesale. Might be reworked later.
with union_cte as (
  -- alles ausser waldameisen
  SELECT *
  FROM {{ ref('extract_and_reformat_besondere_arten_allgemein') }}

  UNION

  -- waldameisen
  SELECT *
  FROM {{ ref('extract_and_reformat_besondere_arten_waldameisen') }}

)
SELECT
  row_number() over() as id,
  * 
FROM union_cte
WHERE genau is true