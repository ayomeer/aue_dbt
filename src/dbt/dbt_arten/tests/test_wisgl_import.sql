{{ config(enabled=false) }}

SELECT
	imp.id_art,
	w.wis
FROM dbt_arten.imp_wisgl_besonderearten as imp
LEFT JOIN prod_gl_arten.besondere_waldarten as w
	ON c.id_art = imp.id_art
WHERE w.wis is not true