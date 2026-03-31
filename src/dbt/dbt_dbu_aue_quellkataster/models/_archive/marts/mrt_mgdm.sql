{{ config(
     post_hook="{{ post_hook_export('ili2pg_schema', 'quelle') }}"
)
}}

select * from {{ ref('stg_mgdm_data') }}