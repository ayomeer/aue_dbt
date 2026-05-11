{{ config(
  materialized='table',
  enabled=var('enable_audits', false)
)}}



{% set besonderearten_old %}
  select
    id_from_cat_arten as id_art,
    name_deutsch as name_d,
    name_lateinisch as name_lat,
    organismengruppe,
    schutz_ch,
    schutz_gl,
    roteliste,
    radius,
    genauigkeit_ausreichend as genau,
    substrat,
    foerdermassnahmen,
    finder,
    funddatum,
    hinzugefuegt_am,
    kantonsintern,
    verwaltungsintern,
    biotopstatus as astatus,
    bemerkungen,
    fotos,
    geometrie
  from {{ ref('stg_imp_wisgl_besonderearten') }}
{% endset %}

{% set besonderearten_new %}
  select
    id_art,
    name_d,
    name_lat,
    organismengruppe,
    schutz_ch,
    schutz_gl,
    roteliste,
    radius,
    genau,
    substrat,
    foerdermassnahmen,
    finder,
    funddatum,
    hinzugefuegt_am,
    kantonsintern,
    verwaltungsintern,
    astatus,
    bemerkungen,
    fotos,
    geometrie
  from {{source('src_gl_besonderewaldarten', 'besonderearten')}}
{% endset %}

{{ 
  audit_helper.compare_and_classify_query_results(
    besonderearten_old, 
    besonderearten_new, 
    primary_key_columns=['geometrie', 'funddatum', 'name_lat'], 
    columns=dbt_utils.get_filtered_columns_in_relation(
      from=source('src_gl_besonderewaldarten', 'besonderearten'),
      except=['t_id', 't_ili_tid', 't_basket']
    ),
    sample_limit=0
  )
}}