{% macro clean_column_name(col_name) %}
    {{ return(
        col_name
        | lower
        | replace(' ', '_')
        | replace('-', '_')
    ) }}
{% endmacro %}

{% macro select_clean_columns(relation) %}
    {%- set cols = adapter.get_columns_in_relation(relation) -%}

    select
    {%- for col in cols %}
        "{{ col.name }}" as {{ clean_column_name(col.name) }}
        {%- if not loop.last %}, {% endif %}
    {%- endfor %}
    from {{ relation }}
{% endmacro %}