{% macro update_lebensraumnummer(source_model, target_table) %}
  {% if execute and var('enable_transfer', false)  %}

    {{ log("Updating prod_gl_biotope." ~ target_table, info=True) }}

    UPDATE prod_gl_biotope.{{target_table}} as sf
    SET 
      lebensraumnummer = u.split_part_1,
      beschreibung = u.substring_beschreibung
    FROM {{ source_model }} as u
    WHERE sf.gid = u.gid
      AND sf.lebensraumnummer is null -- just to make sure we're not overwriting anything
  {% else %}
    SELECT 1
  {% endif %}
{% endmacro %}