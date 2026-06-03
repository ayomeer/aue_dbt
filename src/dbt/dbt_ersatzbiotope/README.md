

# dbt_ersatzbiotope

## Export to gl_ersatzbiotope

### t_id spacing

To be able to add elements to datasets, baskets and catalogues, it can be nice to leave some t_id values unused. For the initial data loading, the t_id ranges are spaced out as follws:

| t_id range | object |
| --- | --- |
| 1..9  | datasets and baskets |
| 10..99 | catalogue values |
| 100..* | data |

These spacings are defined in dbt_project.yml. For datasets and baskets manually in the variables `datasets` and `baskets` and for the catalogues,
