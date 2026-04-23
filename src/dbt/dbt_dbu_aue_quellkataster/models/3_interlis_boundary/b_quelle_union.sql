WITH union_cte AS (
  SELECT 
    *
  FROM {{ ref('b_access_objektdaten') }}
  UNION
  SELECT 
    *
  FROM {{ ref('b_alpquellen') }}
)

SELECT
  'GL_' || Row_Number() OVER (ORDER BY t_basket)::character varying as identifikator,
  u.*
FROM union_cte as u