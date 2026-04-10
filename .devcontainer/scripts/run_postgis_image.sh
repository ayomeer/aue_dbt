docker run --name postgis-container --user=postgres --network=host -e POSTGRES_PASSWORD=postgres -d postgis/postgis:17-3.5-alpine
