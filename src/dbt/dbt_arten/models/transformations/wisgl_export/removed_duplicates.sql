SELECT *
FROM {{ ref('union_besondere_arten') }}
WHERE id NOT IN (
  SELECT id FROM {{ ref('deduplicate') }}
)