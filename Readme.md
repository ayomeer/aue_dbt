# dbt_sandbox

Testing environment for dbt + PostgreSQL.

## Docker Setup
Based on this guide:
https://medium.com/@oyekanmiakande/building-a-modern-data-pipeline-with-dbt-postgresql-and-docker-a68fe2d19a3c


### PostgreSQL
Using image pulled directly from Postgres' Docker Hub:

```
docker login dhi.io
docker pull dhi.io/postgres:18-alpine3.22-dev
docker tag dhi.io/postgres:18-alpine3.22-dev postgres
```

Running the image:
```
docker run --name postgres-container --user=postgres --network=host -e POSTGRES_PASSWORD=postgres -d postgres
```

> **Note**:
The `postgres:latest` image is just the base setup. The configured test database is continually being saved to `postgres:dev`.


### dbt Core
The dbt Core image is the development environment for this project. As such, is run by VS Code when opening the directory in the configured devcontainer.

The source files are mounted onto the dev container (./src/dbt).


## Connecting pgAdmin to postgres Server

hostname / address: localhost
port: 5432
pw: postgres


## Setting up dbt Core Project

Open the project within the dbt devcontainer and run
```
dbt init
```

This is essentially an interactive way to create your `profiles.yml`.