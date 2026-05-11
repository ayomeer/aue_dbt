

{% macro aggregate_cols(col_list) %}
  
  {% set return_cols = [] %}

  {% for col in col_list %}
    {% do return_cols.append("array_agg(" ~ col ~ ") as " ~ col) %}
  {% endfor %}

  {{ return(
    return_cols 
    | join(',\n')
  )}}
{%- endmacro %}


{% macro mismatched_cols(col_list) %}

  {% set return_cols = [] %}

  {% for col in col_list %}
    {% do return_cols.append(col ~ "[1] <> " ~ col ~ "[2] as mismatch_" ~ col) %}
  {% endfor %}

  {{ return(
    return_cols 
    | join(',\n')
  )}}
{%- endmacro %}