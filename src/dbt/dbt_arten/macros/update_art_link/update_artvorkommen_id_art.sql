
{% macro update_artvorkommen_id_art(source_model) %}
  {% if execute and var('enable_transfer', false)  %}

    {{ log("Updating prod_gl_arten.artvorkommen_gl_pt",info=True) }}

    UPDATE prod_gl_arten.artvorkommen_gl_pt as art
    SET 
      id_from_cat_arten = s.id_art,
      art_deutsch = s.name_deutsch
    FROM {{ source_model }} as s
    WHERE lower(s.name_lateinisch) = lower(art.art_wiss)
      AND id_from_cat_arten is null -- just to make sure we're not overwriting anythign
  {% else %}
    SELECT 1
  {% endif %}
{% endmacro %}