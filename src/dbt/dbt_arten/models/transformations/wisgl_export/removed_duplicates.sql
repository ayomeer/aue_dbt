SELECT *
FROM {{ ref('extract_and_reformat_waldarten') }}
WHERE id NOT IN (
  SELECT id FROM {{ ref('deduplicate') }}
)