with source as (
        select * from "test_db"."prod_gl_arten"."artvorkommen_gl_pt"
  ),
  staging as (
      select
        -- columns mirroring besonderearten
        "gid",
        -- info related to cat_art
        "art_deutsch",
        "art_wiss",
        "id_from_cat_arten", 

        -- info held only in artvorkommen_gl_pt
        "radius",
        "substrat",
        "funddatum",
        "finder",
        "kantonsintern",
        "verwaltungsintern",
        "bemerkungen",
        "fotos",
        "genauigkeit_ausreichend",
        "biotopstatus",
        "id_gl_aus_import",
        
        "last_modified",       -- automatically set by trigger function
        "last_user",           -- automatically set by trigger function
        "dat_hinzugefuegt_am", -- automatically set by trigger function
        "e", -- automatically set by trigger function from geom
        "n", -- automatically set by trigger function from geom
        "geometrie",
        -- 19 cols

        -- other columns
        "neobiot",
        "qualitaetskontrolle",
        "taxonidch",
        "ext_hoehe",
        "gemeinde_kt_glarus",
        "oid_uuid",
        "spezart",
        "ext_label",
        "ext_herkunft",
        "copyright",
        "loeschmarkierung"
      from source
  )
  select * from staging