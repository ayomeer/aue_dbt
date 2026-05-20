SELECT 
  w.*,
  c.name_deutsch as c_name_deutsch,
  c.name_lateinisch as c_name_lateinisch,
  c.rl_status as c_roteliste
FROM {{ ref('stg_besondere_waldarten') }} as w
LEFT JOIN {{ ref('stg_cat_art') }} as c
  ON w.id_art = c.id_art