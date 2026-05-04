{{ config(materialized='table')}}
-- depends_on: {{ ref('bdry_wis_update_transfer') }}

{% set artvorkommen_old %}
  select
    *
  from {{source('src_prod_gl_arten', 'bkp_artvorkommen')}}
{% endset %}

{% set artvorkommen_new %}
  select
    *
  from {{source('src_prod_gl_arten', 'artvorkommen_gl_pt')}}
{% endset %}

{{ 
  audit_helper.compare_and_classify_query_results(
    artvorkommen_old, 
    artvorkommen_new, 
    primary_key_columns=['geometrie', 'funddatum', 'art_wiss'], 
    columns=dbt_utils.get_filtered_columns_in_relation(
      source('src_prod_gl_arten', 'artvorkommen_gl_pt'),
      except=['last_modified']
    ),
    sample_limit=20
  )
}}