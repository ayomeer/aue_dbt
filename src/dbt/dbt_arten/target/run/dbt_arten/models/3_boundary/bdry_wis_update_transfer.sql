
  create view "test_db"."dbt_arten"."bdry_wis_update_transfer__dbt_tmp"
    
    
  as (
    

SELECT * FROM "test_db"."dbt_arten"."bdry_wis_update"
  );