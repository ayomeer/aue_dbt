
  create view "test_db"."dbt_arten"."bdry_wisgl_export_transfer__dbt_tmp"
    
    
  as (
    

SELECT * FROM "test_db"."dbt_arten"."bdry_wisgl_export"
  );