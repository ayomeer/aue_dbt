with source as (
        select * from "test_db"."dbt_arten"."imp_wisgl_besonderearten"
  ),
  staging as (
      select
        "id",
        "t_ili_tid",
        -- info related to cat_art
        "name_deutsch",
        "name_lateinisch",
        "id_art" as id_from_cat_arten, 

        -- info that's mirrored in prod_gl_arten.artvorkommen_pt_gl
        "radius",
        "substrat",
        "foerdermassnahmen",
        "finder",
        "funddatum",
        "hinzugefuegt_am",
        "kantonsint"::boolean as kantonsintern,
        "verwaltung"::boolean as verwaltungsintern,
        "status"::boolean as biotopstatus,
        "bemerkungen",
        "fotos",
        "genau"::boolean as genauigkeit_ausreichend,
        "x_koord",
        "y_koord",
        "geometry" as geometrie
      from source
  )
  select * from staging