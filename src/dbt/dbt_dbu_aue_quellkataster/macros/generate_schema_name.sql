
{% macro generate_schema_name(custom_schema_name, node) -%}
    -- Overrides standard schema naming behavior:
    -- Argumens:
    -- custom_schema_name: schema name explicitly defined dusing 
    --                     'schema' model configuration
    -- node: dbt model metadata

    -- default schema is the one defined in 'profiles.yml'
    {%- set default_schema = target.schema -%}

    {%- if custom_schema_name is none -%}
        {{ default_schema }}
    {%- else -%}
        -- if custom schema configuration set, use that value directly
        -- instead of default behaviour, which is to prefixing it 
        -- with profile name
        {{ custom_schema_name | trim }}
    {%- endif -%}
{%- endmacro %}