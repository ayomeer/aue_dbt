{% macro write_to_interlis(schema_name, table_name) %}

  {% set insert_query %}
    INSERT INTO {{schema_name}}.{{table_name}}(
      {{ dbt_utils.get_filtered_columns_in_relation(this) | join(',\n  ') }}
    )
    SELECT
      *
    FROM {{this}}
  {% endset %}
  {% set query_return = run_query(insert_query)%}

{%- endmacro %}
