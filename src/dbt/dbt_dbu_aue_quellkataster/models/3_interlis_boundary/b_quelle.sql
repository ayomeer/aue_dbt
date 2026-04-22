WITH union_cte as (
  SELECT 
    *
  FROM {{ ref('b_access_objektdaten') }}
  UNION
  SELECT 
    *
  FROM {{ ref('b_alpquellen') }}
)

SELECT
  nextval('dbu_aue_quellkataster.t_ili2db_seq'::regclass) as t_id,
  uuid_generate_v4() as t_ili_tid, 
  'GL_' || Row_Number() OVER (ORDER BY t_basket)::character varying as identifikator,
  c.*
FROM union_cte as c