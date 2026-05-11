{{ config(
  materialized='table',
  enabled=var('enable_audits', false)
)}}


{% set besonderearten_old %}
  select
    *
  from {{source('src_dbt_arten', 'imp_wisgl_besonderearten')}}
{% endset %}

{% set besonderearten_new %}
  select
    *
  from {{source('src_gl_besonderewaldarten', 'besonderearten')}}
{% endset %}

{{ 
  audit_helper.compare_and_classify_query_results(
    artvorkommen_old, 
    artvorkommen_new, 
    primary_key_columns=['geometrie', 'funddatum', 'name_lat'], 
    columns=dbt_utils.get_filtered_columns_in_relation(
      from=source('src_gl_besonderewaldarten', 'besonderearten'),
      except=['t_id', 't_ili_tid']
    ),
    sample_limit=20
  )
}}