import os
import pandas as pd
import psycopg2


# --- Constants ----------------------------------------------------------------------
# DB-Table
SCHEMA = "dbu_aue_quellkataster"      # schema we're working in
SRC_TABLE = "src_access_objektdaten"  # source table to introspect on

# Introspection logic
TOP_N = 3

# --- DB Connection Setup ------------------------------------------------------------

conn = psycopg2.connect(
    host="localhost",
    port="5432",
    dbname="test-db",
    user="postgres",
    password=str(os.environ['DB_PASSWORD'])
)

# --- Querying -----------------------------------------------------------------------

# get columns
columns_query = f"""
select column_name
from information_schema.columns
where table_schema = '{SCHEMA}'
and table_name = '{SRC_TABLE}'
"""
columns = pd.read_sql(columns_query, conn)["column_name"].tolist()

results = []
for col in columns:
    query = f"""
        select "{col}" as value, count(*) as cnt
        from "{SCHEMA}"."{SRC_TABLE}"
        group by "{col}"
        order by cnt desc
        limit {TOP_N}
    """
    
    df_top = pd.read_sql(query, conn)
    
    results.append({
        "column_name": col,
        "top_values": df_top["value"].to_numpy(),
        "top_counts": df_top["cnt"].to_numpy()
    })
result_df = pd.DataFrame(results)

# --- Displaying Results ------------------------------------------------------------

print(f"\nDisplaying most occuring values and their corresponding counts for table {SCHEMA}.{SRC_TABLE}:\n")
print(result_df)