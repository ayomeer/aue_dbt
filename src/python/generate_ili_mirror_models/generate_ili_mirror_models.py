import os
from pathlib import Path
import argparse
import pandas as pd
import psycopg2
from sqlalchemy import Table, Column, select, create_engine, MetaData, text
from sqlalchemy.dialects import postgresql
# --- Constants -----------------------------------------------------------------------

conn_url = (
  "postgresql+psycopg2://postgres:"
  f"{os.environ['DB_PASSWORD']}@postgis-container:5432/test_db" 
)

INTERLIS_TABLE_NAME_PATTERNS = [
  't_ili2db',
  'referenz',
  'pointstructure',
  'linestructure',
  'surfacestructure',
  'amultipoint',
  'multiline',
  'multisurface',
]

# --- parse input arguments -------------------------------------------------------------

# parser = argparse.ArgumentParser(
#     description="Create sources.yaml from a source schema.",
#     add_help=True,
# )
# parser.add_argument(
#     "--target_schema",
#     "-t",
#     dest="target_schema",
#     type=str,
#     required=True,
#     help="Name of the target schema to create boundary models for.",
# )
# args = parser.parse_args()

# debugging args
class DebuggingArgs:
  def __init__(self, target_schema, output_path):
    self.target_schema = target_schema
    self.output_path = output_path
    
args = DebuggingArgs(
  target_schema='pub_gl_ersatzbiotope', 
  output_path='/project/src/python/generate_ili_mirror_models/output'
)


dummy = 1
# --- DB Connection Setup ------------------------------------------------------------

metadata_obj = MetaData()
engine = create_engine(conn_url)

# prepare general use table definitions
# tbl_info_column_names = Table(
#   name="columns",  
#   metadata=metadata_obj,
#   schema="information_schema",
#   autoload_with=engine
# )

# execute the selected query using the existing engine
sql_get_column_info = text("""
SELECT
    a.attname AS column_name,
    format_type(a.atttypid, a.atttypmod) AS data_type
FROM pg_attribute a
JOIN pg_class as c ON c.oid = a.attrelid
JOIN pg_namespace n ON n.oid = c.relnamespace
WHERE n.nspname = :schema
  AND c.relname = :table
  AND a.attnum > 0
  AND NOT a.attisdropped
ORDER BY a.attnum;
""")

# --- Querying -----------------------------------------------------------------------

# get list of tables in target schema
tbl_info_table_names = Table(
  "tables",  
  metadata_obj,
  schema="information_schema",
  autoload_with=engine
)
sql_get_table_names = (
  select(tbl_info_table_names.c.table_name)
  .where(tbl_info_table_names.c.table_schema == args.target_schema)
)
with engine.connect() as conn:
  result = conn.execute(sql_get_table_names)
  table_names = [row.table_name for row in result]

# filter out tables managed by interlis
data_table_names = [
  name for name in table_names 
  if not any(pattern in name for pattern in INTERLIS_TABLE_NAME_PATTERNS)
]

# --- Build Boundary Models ---------------------------------------------------

# for each target table, get column list
for table_name in data_table_names:
  # get column list  
  with engine.connect() as conn:
    result = conn.execute(
      sql_get_column_info,
      {"schema": args.target_schema, "table": "to_flaeche",}
    )
    column_info = [(row.column_name, row.data_type) for row in result]

  str_column_list = []
  
  # add ili columns


  for column_name, data_type in column_info:
    str_column_list.append(f"  {column_name}::{data_type},\n")
 
  str_column_list[-1] = str_column_list[-1].replace(",", "") # get rid of comma in last column string
  
  # create dbt model stump
  output_file = Path(args.output_path) / f"ili_mirror_{table_name}.sql"
  with output_file.open('w', encoding='utf-8') as f:
    f.write("{{ config(materialized='table') }} \n\n")

    f.write("SELECT \n")
    f.writelines(str_column_list)
    f.write(f"FROM {{{{ ref('placeholder') }}}}") # {{ -> {


