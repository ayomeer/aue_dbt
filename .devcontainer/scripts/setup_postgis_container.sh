docker run --name postgis-container-test --user=postgres --network=devnet -p 5432:5432 -e POSTGRES_PASSWORD=postgres -d postgis/postgis:17-3.5-alpine
