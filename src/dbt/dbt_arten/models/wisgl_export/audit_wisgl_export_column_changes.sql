-- depends_on: {{ ref('bdry_wisgl_export_transfer') }}

{{ config(
  materialized='table',
  enabled=var("enable_audits", false)
)}}


{% set old = ref('stg_audit_imp_wisgl_besonderearten') %}

{% set new = ref('stg_audit_besonderearten') %}

{{ audit_helper.compare_all_columns(
    a_relation = old,
    b_relation = new,
    primary_key = "audit_link_id"
) }}