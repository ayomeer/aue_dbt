# dbt_aue

Testing environment for dbt + PostgreSQL.

## Docker Setup
Based on this guide:
https://medium.com/@oyekanmiakande/building-a-modern-data-pipeline-with-dbt-postgresql-and-docker-a68fe2d19a3c


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




### dbt devcontainer
The dbt Core image is the development environment for this project. As such, is run by VS Code when opening the directory in the configured devcontainer.

The source files are mounted onto the dev container (./src/dbt).

> ⚠️ _**Note:**_ If the devcontainer is opened for the first time, or rebuild, you need to set the DB connection password as an environment variable as follows: `echo 'export DB_PASSWORD="password"' >> ~/.bashrc`

#### First time setup

1) Save DB password in environment variable `DB_PASSWORD`
```bash
echo 'export DB_PASSWORD="password"' >> ~/.bashrc
```
2) Load dbt packages
```bash
dbt deps
```

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

## Data Source

For dbt to work smoothly, make sure of the following:
- source tables only use SQL-safe naming
  - no umlauts
  - no spaces
  - no capital characters

## Power User for dbt Extension

- Model documentation yaml files -> generate w/ Documentation Editor in bottom pane (part of Power User for dbt extension)

Conditions for Documentation Editor to work as expected:
- Model needs to exist on database -> `dbt run --select <model_name>`


## dbt Flow Lineage Extension

Conditions for lineage graph to look as expected:
- `dbt compile` and `dbt docs generate` have been run
- model columns are documented in yaml file


## Project Scope

Not part of project(?):
- Catalogues: Need to be present in target schema and included as dbt source in `models/sources.yaml`

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


## TODO

- Look up how(/if) `_catref` tables are meant to be filled


python scripts:
- **export mirrors:** 
  - use dbt concept of _contract_ to generat boundary layer stump?
    - using dbt-codegen package
```bash
dbt run-operation generate_source --args \
'{"schema_name": "dbu_aue_quellkataster", "table_names": ["quelle"], "generate_columns": true}'
```

  - using custom python script
  
```python
print("models:")
print("  - name: quelle")
print("    config:")
print("      contract:")
print("        enforced: true")
print("    columns:")

for name, dtype in cols:
  print(f"      - name: {name}")
  print(f"        data_type: {dtype}")
```
  - _test_ maybe also helpful
  - for each model in mirros, get corresponding table and list of columns
  - for each table 
  - change constant db connection string to arguments needed to build it passed to script
