{{ config(materialized='table')}}

{% set old = source('_tmp_copy_prod_gl_biotope', 'biotope_to_sf') %}

{% set new = source('prod_gl_biotope', 'biotope_to_sf') %}

{{ audit_helper.compare_and_classify_relation_rows(
    a_relation = old,
    b_relation = new,
    primary_key_columns = ["gid"],
    columns =   dbt_utils.get_filtered_columns_in_relation(
                    from= source('prod_gl_biotope', 'biotope_to_sf'),
                    except= ['last_modified', 'last_user', 'geometrie']
                ),
    sample_limit=0
) }}