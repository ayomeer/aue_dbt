-- Managing INTERLIS Boundary ---------------------------------------

{% macro run_start_parsing() %}
  -- reset dbt schema's t_ili2db_seq
  {{ reset_ili_sequence(target.schema) }}
  
  {% if var('reset_target', false) %}
    {{ reset_target_schema(var('target_ili_schema')) }}
  {% endif %}
{%- endmacro %}


{% macro reset_target_schema(schema_name) %}
  {{ reset_ili_sequence(schema_name) }}

  -- Clear truncate tables
  {% set sql_truncate %}
    TRUNCATE TABLE {{schema_name}}.t_ili2db_basket CASCADE;
    -- NOTE:
    -- Also truncates all tables referencing basket such as main data tables
  {% endset %}
  {% do run_query(sql_truncate) %}


  -- TODO: Populate dataset table

  -- Populate basket table
  {{ setup_baskets(schema_name) }}
{%- endmacro %}


{% macro setup_baskets(schema_name) %}
  -- Populate basket table based on project configuration:
  -- Add a row (i.e.) a basket for each basket defined in dbt_project.yml
  {% for key, value_dict in var('baskets').items() %}
    {{ log(
        "Writing " ~ key ~ "into " ~ schema_name ~ ".t_ili2db_basket"
    )}}
    {% set sql_basket_row %}
      INSERT INTO {{schema_name}}.t_ili2db_basket(
        t_id,         -- NOT NULL
        dataset,
        topic,        -- NOT NULL
        t_ili_tid,
        attachmentkey,-- NOT NULL (but also not used -> write '-')
        domains
      )
      VALUES (
        {{ value_dict['t_id'] }},
        NULL, --{{ value_dict['dataset_t_id'] }},
        '{{ value_dict['topic'] }}',
        uuid_generate_v4(),
        '-',
        NULL
      );
      -- advance t_ili2db_seq to make up for manually set t_id
      SELECT nextval('{{schema_name}}.t_ili2db_seq'::regclass);
    {% endset %}
    {% set query_return = run_query(sql_basket_row)%}
  {% endfor %}
{%- endmacro %}



-- Export dbt table to target table
{% macro transfer_table(schema_name, table_name) %}

  {% set insert_query %}
    INSERT INTO {{schema_name}}.{{table_name}}(
      -- Get list of column names present in boundary model
      -- assumption: boundary model column names match target column names 
      {{ dbt_utils.get_filtered_columns_in_relation(this) | join(',\n  ') }}
    )
    SELECT
      *
    FROM {{this}}
  {% endset %}
  {% set query_return = run_query(insert_query)%}

{%- endmacro %}


-- Managing INTERLIS concepts on dbt side -------------------------------------

-- Create t_ili2db_sequence
-- intended use: first time dbt schema setup
--  call through run-operations e.g.:
--  dbt run-operation create_ili_sequence --args '{schema: dbt_quellkataster}'
{% macro create_ili_sequence(schema) -%}
  -- create sequence
  {% set query %}
    CREATE SEQUENCE IF NOT EXISTS {{schema}}.t_ili2db_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
  {% endset %}
  {% set query_return = run_query(query) %}

{%- endmacro %}

-- Reset 't_ili2db_seq' in target schema
{% macro reset_ili_sequence(ili_schema) -%}

ALTER SEQUENCE {{ili_schema}}.t_ili2db_seq RESTART WITH 1;

{%- endmacro %}


