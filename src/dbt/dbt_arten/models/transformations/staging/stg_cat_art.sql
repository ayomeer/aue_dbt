with source as (
        select * from {{ source('src_prod_gl_arten', 'cat_art') }}
  ),
  renamed as (
      select
        {{ adapter.quote("id_art") }},
        {{ adapter.quote("bez_art_latein") }} as name_lateinisch,
        {{ adapter.quote("bez_art_deutsch") }} as name_deutsch,
        {{ adapter.quote("artengruppe") }},
        {{ adapter.quote("schutzstatus") }},
        {{ adapter.quote("rl_status") }},
        {{ adapter.quote("foerdermassnahmen") }},
        {{ adapter.quote("schutz_ch") }},
        {{ adapter.quote("schutz_gl") }},
        {{ adapter.quote("bafu_prioritaet") }},
        {{ adapter.quote("verantwortung_ch") }},
        {{ adapter.quote("smaragd_art") }},
        {{ adapter.quote("endemit") }},
        {{ adapter.quote("lw_uzl_art") }},
        {{ adapter.quote("art_aus_waldbiostrategie") }},
        {{ adapter.quote("waldzielart_ch") }},
        {{ adapter.quote("datenherkunft") }},
        {{ adapter.quote("ext_id_daten") }},
        {{ adapter.quote("genus") }},
        {{ adapter.quote("species") }},
        {{ adapter.quote("subspecies") }},
        {{ adapter.quote("last_modified") }},
        {{ adapter.quote("last_user") }},
        {{ adapter.quote("oid_uuid") }},
        {{ adapter.quote("vdc_taxon_id") }},
        {{ adapter.quote("update_status") }},
        {{ adapter.quote("link_ch") }},
        {{ adapter.quote("spez_art") }},
        {{ adapter.quote("pub_in_biotopverzeichnis") }},
        {{ adapter.quote("jahre_biovz") }},
        {{ adapter.quote("biotop_vz") }}

      from source
  )
  select * from renamed
    