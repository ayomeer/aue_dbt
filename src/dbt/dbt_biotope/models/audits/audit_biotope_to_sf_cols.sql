{{ config(materialized='table')}}


{% set old = source('_tmp_copy_prod_gl_biotope', 'biotope_to_sf') %}

{% set new = source('prod_gl_biotope', 'biotope_to_sf')  %}

{{ audit_helper.compare_all_columns(
    a_relation = old,
    b_relation = new,
    primary_key = "gid"
) }}