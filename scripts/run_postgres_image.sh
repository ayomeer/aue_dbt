docker run --name postgres-container --user=postgres --network=host -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 postgres
