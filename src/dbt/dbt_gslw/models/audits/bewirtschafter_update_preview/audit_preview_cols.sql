
{{ config(
  enabled= not var('enable_transfer', false),
  materialized='table'
)}}


{% set old = ref('stg_bewirtschafter') %}

{% set new = ref('preview_bewirtschafter_update') %}

{{ audit_helper.compare_all_columns(
    a_relation = old,
    b_relation = new,
    primary_key = "t_id"
) }}
ORDER BY conflicting_values DESC