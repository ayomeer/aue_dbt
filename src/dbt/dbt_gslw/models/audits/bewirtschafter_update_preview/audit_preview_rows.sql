{{ config(materialized='table')}}

{% set cols_to_compare = [
  'bewirtschafternummer',
  'banrede',
  'bansprech',
  'bname',
  'bvorname',
  'badresse',
  'bwohnort',
  'bplz'
]%}

{{ audit_utils.audit_rows_with_col_mismatched(
	cols_to_compare, 
	ref('audit_preview_rows_raw')
) }}

