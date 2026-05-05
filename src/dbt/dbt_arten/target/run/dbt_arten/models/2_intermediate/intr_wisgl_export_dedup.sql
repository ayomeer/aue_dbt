
  create view "test_db"."dbt_arten"."intr_wisgl_export_dedup__dbt_tmp"
    
    
  as (
    SELECT DISTINCT ON (geometrie, funddatum, name_lateinisch)
	*
FROM "test_db"."dbt_arten"."intr_wisgl_export"
ORDER BY geometrie, funddatum, name_lateinisch, id DESC
  );