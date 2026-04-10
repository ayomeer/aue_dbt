
SELECT 
  id_lr, 
  beschreibung_de
FROM {{ source('src_prod_gl_biotope', 'cat_beschreibung') }}