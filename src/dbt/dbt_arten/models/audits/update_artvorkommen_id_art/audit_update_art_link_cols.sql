
{{ config(
  materialized='table'
)}}


{% set old = ref('snapshot_artvorkommen_pre_update_id_art') %}

{% set current = source('src_prod_gl_arten', 'artvorkommen_gl_pt') %}

{{ audit_helper.compare_all_columns(
    a_relation = old,
    b_relation = current,
    exclude_columns=['geometrie'] 
    primary_key = 'gid'
) }}