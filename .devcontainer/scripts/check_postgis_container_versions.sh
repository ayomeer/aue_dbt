docker exec -it postgis-container psql  -U postgres -d postgres -c 'select version()'
docker exec -it postgis-container psql  -U postgres -d postgres -c 'select postgis_version()'


