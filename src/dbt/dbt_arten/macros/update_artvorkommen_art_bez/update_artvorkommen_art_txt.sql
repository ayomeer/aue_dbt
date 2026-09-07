-- specifically for use in model: update_artvorkommen_art_txt
{% macro update_artvorkommen_art_txt(source_model) %}
  {% if execute and var('enable_transfer', false)  %}

    {{ log(
        """Updating prod_gl_arten.artvorkommen_gl_pt art_wiss and art_deutsch columns with info 
        from linked cat_art entry""",
        info=True
    ) }}

    UPDATE prod_gl_arten.artvorkommen_gl_pt as art
    SET 
      art_wiss = s.new_art_wiss,
      art_deutsch = s.new_art_deutsch
    FROM {{ source_model }} as s
    WHERE s.gid = art.gid
  {% else %}
    SELECT 1 -- dummy for valid SQL return when criteria not met
  {% endif %}
{% endmacro %}