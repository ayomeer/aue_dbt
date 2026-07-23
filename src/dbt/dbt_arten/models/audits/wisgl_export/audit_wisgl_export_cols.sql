
{{ config(
  materialized='table'
)}}


{% set old = ref('stg_audit_imp_wisgl_besonderearten') %}

{% set new = ref('stg_audit_besonderearten') %}

{{ audit_helper.compare_all_columns(
    a_relation = old,
    b_relation = new,
    primary_key = "t_id"
) }}