{{ config(materialized='table')}}

{% set cols_to_compare = dbt_utils.get_filtered_columns_in_relation(
  from= source('prod_gl_biotope', 'biotope_to_sf'),
  except= ['last_modified', 'last_user']
) %}


{{ audit_rows_with_col_mismatched(
	cols_to_compare, 
	ref('audit_biotope_to_sf_rows_raw')
) }}

