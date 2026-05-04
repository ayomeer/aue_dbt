
  create view "test_db"."dbt_arten"."stg_cat_art__dbt_tmp"
    
    
  as (
    with source as (
        select * from "test_db"."prod_gl_arten"."cat_art"
  ),
  renamed as (
      select
        "id_art",
        "bez_art_latein" as name_lateinisch,
        "bez_art_deutsch" as name_deutsch,
        "artengruppe",
        "schutzstatus",
        "rl_status",
        "foerdermassnahmen",
        "schutz_ch",
        "schutz_gl",
        "bafu_prioritaet",
        "verantwortung_ch",
        "smaragd_art",
        "endemit",
        "lw_uzl_art",
        "art_aus_waldbiostrategie",
        "waldzielart_ch",
        "datenherkunft",
        "ext_id_daten",
        "genus",
        "species",
        "subspecies",
        "last_modified",
        "last_user",
        "oid_uuid",
        "vdc_taxon_id",
        "update_status",
        "link_ch",
        "spez_art",
        "pub_in_biotopverzeichnis",
        "jahre_biovz",
        "biotop_vz"

      from source
  )
  select * from renamed
  );