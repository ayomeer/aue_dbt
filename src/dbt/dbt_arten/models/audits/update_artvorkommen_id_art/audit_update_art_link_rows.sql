{{ config(
  materialized='table'
)}}


{% set artvorkommen_old %}
  select
    *
  from {{ ref('snapshot_artvorkommen_pre_update_id_art') }}
{% endset %}

{% set artvorkommen_current %}
  select
    *
  from {{source('src_prod_gl_arten', 'artvorkommen_gl_pt')}}
{% endset %}

{{ 
  audit_helper.compare_and_classify_query_results(
    artvorkommen_old, 
    artvorkommen_current, 
    primary_key_columns=['gid'],
    columns=dbt_utils.get_filtered_columns_in_relation(
      source('src_prod_gl_arten', 'artvorkommen_gl_pt'),
      except=['last_modified']
    ),
    sample_limit=0
  )
}}