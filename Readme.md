# dbt_aue

Testing environment for dbt + PostgreSQL.

## Table of Contents

- [dbt\_aue](#dbt_aue)
  - [Table of Contents](#table-of-contents)
  - [Docker Setup](#docker-setup)
    - [dbt devcontainer](#dbt-devcontainer)
      - [First time setup](#first-time-setup)
    - [PostGIS Container](#postgis-container)
      - [First Time Setup](#first-time-setup-1)
      - [Using the image in development/testing](#using-the-image-in-developmenttesting)
  - [Connecting pgAdmin to postgres Server](#connecting-pgadmin-to-postgres-server)
- [dbt](#dbt)
  - [Setting up dbt Core Project](#setting-up-dbt-core-project)
  - [dbt Workflow](#dbt-workflow)
      - [Usage Examples](#usage-examples)
    - [Deployment](#deployment)
      - [Profiles](#profiles)
      - [Windmill](#windmill)
      - [Run Variables](#run-variables)
    - [Data Sources](#data-sources)
    - [The dbt-INTERLIS Boundary](#the-dbt-interlis-boundary)
      - [Boundary Models](#boundary-models)
      - [Transfer Models](#transfer-models)
    - [Macros](#macros)
      - [Available Macros](#available-macros)
      - [Debugging Macros](#debugging-macros)
    - [Extensions](#extensions)
      - [Power User for dbt Extension](#power-user-for-dbt-extension)
      - [dbt Flow Lineage Extension](#dbt-flow-lineage-extension)
  - [Docs](#docs)
  - [Importing Schemas to localhost DB](#importing-schemas-to-localhost-db)
  - [Troubleshooting](#troubleshooting)
      - [There are problems highlighted (often in dbt\_project.yml) that I've already solved.](#there-are-problems-highlighted-often-in-dbt_projectyml-that-ive-already-solved)
  - [TODO](#todo)


## Docker Setup
Based on this guide:
https://medium.com/@oyekanmiakande/building-a-modern-data-pipeline-with-dbt-postgresql-and-docker-a68fe2d19a3c


### dbt devcontainer
The dbt Core image is the development environment for this project. As such, is run by VS Code when opening the directory in the configured devcontainer.

The source files are mounted onto the dev container (./src/dbt).

#### First time setup

Save DB password in environment variable `DB_PASSWORD`. 
```bash
echo 'export DB_PASSWORD="password"' >> ~/.bashrc
```
Afterwards, reload window (`Ctr` + `Shift` + `P` > `Reload Windown`)

Load dbt packages. While in the dbt project directory, run:
```bash
dbt deps
```


### PostGIS Container

Using image: `postgis/postgis:17-3.5-alpine`
- PostgreSQL version 17: Higher than version 16 that is used in production (backwards compatible)
- PostGIS version 3.5, same as production version 

#### First Time Setup

To set up the server, user and default database, the container has to be run with arguments passing configuration values as options. For convenience, this process has been packaged into shell scripts in the `.devcontainer/Scripts`. For the first time setup, enter this directory and run:

```
./run_postgis_image.sh
./check_postgis_container_versions.sh
docker stop postgis-container
docker commit postgis-container postgis:dev
docker rm postgis-container
```


After running it with those flags that set up the user and setting up test and prod databases including target schemas, commit the container to the image used by vscode devcontainer setup: `postgres:dev`.

> ℹ️ _**Note:**_ 
For new databases created, postgis and uuid-ossp extensions need to be added: Right click on `Extensions` category in the pgAdmin browser pane.

#### Using the image in development/testing

The image `postgres:latest` is just the base state after initial setup. The configured test database is continually being saved to `postgres:dev`.

> ⚠️ _**Warning:**_ 
Careful about using the VsCode command _'Rebuild and reopen in container'_ without first committing the changes made on the postgres container to the `postgres:dev` image. Run the command `Reload window` from the VS Code command pallete, to get rid of the highlighted issues. 





## Connecting pgAdmin to postgres Server

hostname / address: localhost
port: 5432
pw: postgres


# dbt
## Setting up dbt Core Project

Open the project within the dbt devcontainer and run
```
dbt init
```

This is essentially an interactive way to create your `profiles.yml` at `~/.dbt`. For this project, it should look like this:
```yaml
dbt_sandbox:
  outputs:
    dev:
      dbname: postgres-test
      host: localhost
      pass: postgress
      port: 5432
      schema: dbt_dev
      threads: 1
      type: postgres
      user: postgres
  target: dev
```

## dbt Workflow
- Ground up, data-first philosophy, Models = Select Queries




#### Usage Examples

```bash
dbt run  --vars '{reset_target: true, enable_transfer: true}'
```
### Deployment

#### Profiles

#### Windmill

On Windmill, the script "dbt run transform" can be used to run dbt models on the live IAP DB. It uses the `windmill-iap` profile output defined in the project's `profiles.yaml`.


#### Run Variables

| Variable | Effect |
| -------- | ------ |
| reset_target | Reset and re-initialize target ili schema (datasets and baskets)
| enable_transfer | Triggers final dbt models to be transferred to their respective targets defined in the their model configuration.


### Data Sources

For dbt to work smoothly, make sure of the following:
- source tables only use SQL-safe naming
  - no umlauts
  - no spaces
  - no capital characters

- the role that dbt is accessing the DB through has been granted
  - `USAGE` priviledges on the schema
  - `SELECT` priviledges on the source tables

### The dbt-INTERLIS Boundary

Since dbt models can only be _SELECT_ statements, writing to the target INTERLIS models is done using [macros](#macros). 

Basket definitions can be defined either in `dbt_project.yml` or a dedicated yaml file (e.g. `baskets.yml`) using variables following the structure:
```yaml
# Example from dbt_dbu_aue_quellkataster > dbt_project.yml
baskets:
  basket_quellkataster_access:
    t_id: 1
    topic: ProdQuellkataster
    dataset_t_id: NULL 
```

#### Boundary Models
Boundary models (prefix `b_`) are the final transformation model managed by dbt. They serve as a dbt-side mirror of their respective corresponding INTERLIS table. The following implicit assumptions are made about these tables:
- For each column of the target table, the boudary model has a corresponding column with
  - the same exact name
  - the same data type (use explicit casting)
- The column are in the same order ⚠️


#### Transfer Models
dbt Models called `transfer`, select everything from a boundary model and call the `write_to_interlis` macro to insert the data into the target INTERLIS schema as a [post-hook](https://docs.getdbt.com/reference/resource-configs/pre-hook-post-hook). 

```SQL
{{ config(
  enable=var('enable_transfer', false),
  post_hook='{{ write_to_interlis("dbu_aue_quellkataster", "quelle") }}'
)}}

SELECT * FROM {{ ref('b_quelle') }}
```

Transfer models are their own seperate models, so they can be configured to be disabled by default for safety and enabled explicitly using a variable.

### Macros
Macros are basically templated SQL-scripts. This is perfect for abstracting INTERLIS-specific tasks like populating basket tables <!-- TODO: more examples -->.

Eventually, these macros should be split off into a seperate repo, so that they can be shared across dbt projects as a package.

#### Available Macros

| Macro | Usage |
|--- | --- |
| `create_ili_sequence` | Add `t_ili2db_seq` to given schema. Used to set up dbt schema with this sequence, such that this sequence is available to prepare data for export to INTERLIS schemas.
<!-- TODO: document all the macros -->

#### Debugging Macros

<!-- TODO: Describe how to see what's going on with macros (make model or analysis + compile) -->


### Extensions
#### Power User for dbt Extension

- Model documentation yaml files -> generate w/ Documentation Editor in bottom pane (part of Power User for dbt extension)

Conditions for Documentation Editor to work as expected:
- Model needs to exist on database -> `dbt run --select <model_name>`


#### dbt Flow Lineage Extension

Conditions for lineage graph to look as expected:
- `dbt compile` and `dbt docs generate` have been run
- model columns are documented in yaml file




## Docs

To view graphs and lineage information, use the docs:

```
dbt docs generate
dbt docs serve --port 0
```

> ⚠️ **_Important:_** The default port, 8080, is used by vscode devcontainer!
`--port 0` ensures, that a free port is used. 


## Importing Schemas to localhost DB

Make sure postgis and uuid-ossp extensions are present on DB!

1) export from live DB as plain w/ UTF8 formatting
2) Remove lines `\restrict ...` and `\unrestrict ...` from plain sql file in editor (e.g. vscode)
3) import on localhost DB by right clicking **database** (not schema) and choosing 'Restore...' or using command line (on host): `psql -h localhost -p 5432 -U postgres -d test-db -f prod_gl_biotope_20260402.sql`


## Troubleshooting

#### There are problems highlighted (often in dbt_project.yml) that I've already solved.
Try running `dbt compile` + Command Palette > Reload Window 

## TODO

- Look up how(/if) `_catref` tables are meant to be filled



