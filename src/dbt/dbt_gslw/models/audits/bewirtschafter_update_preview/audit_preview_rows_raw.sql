
{% set old %}
  select
    *
  from {{ ref('stg_bewirtschafter') }}
{% endset %}

{% set new %}
  select
    *
  from {{ ref('preview_bewirtschafter_update') }}
{% endset %}

{{ 
  audit_helper.compare_and_classify_query_results(
    old, 
    new, 
    primary_key_columns=['bewirtschafternummer'], 
    columns=dbt_utils.get_filtered_columns_in_relation(
      from=ref('preview_bewirtschafter_update'),
      except=[]
    ),
    sample_limit=0
  )
}}