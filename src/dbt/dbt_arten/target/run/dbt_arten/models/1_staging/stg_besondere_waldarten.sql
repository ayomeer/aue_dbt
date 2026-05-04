
  create view "test_db"."dbt_arten"."stg_besondere_waldarten__dbt_tmp"
    
    
  as (
    with source as (
        select * from "test_db"."prod_gl_arten"."besondere_waldarten"
  ),
  renamed as (
      select
        "id",
        "organismengruppe",
        "deutscher name" as name_deutsch,
        "lateinischer name" as name_lateinisch,
        "id_art",
        "wis",
        "foerdermassnahmen",
        "aufnahmegrund"

      from source
  )
  select * from renamed
  );