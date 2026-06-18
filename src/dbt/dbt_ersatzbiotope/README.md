

# dbt_ersatzbiotope

## Export to gl_ersatzbiotope

### t_id spacing

To be able to add elements to datasets, baskets and catalogues, it can be nice to leave some t_id values unused. For the initial data loading, the t_id ranges are spaced out as follws:

| t_id range | object |
| --- | --- |
| 1..9  | datasets and baskets |
| 10..99 | catalogue values |
| 100..* | data |

These spacings are configured in dbt_project.yml using the project variables `datasets` and `baskets` and `t_id_starting_values`. In the former two, `t_id`s are set manuall for each entry and in the latter, starting values for catalogues and data can be configured.
