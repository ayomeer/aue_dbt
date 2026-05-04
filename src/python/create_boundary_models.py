import os
import argparse
import pandas as pd
import psycopg2
from sqlalchemy import Table, Column, select, create_engine, MetaData

# --- Constants -----------------------------------------------------------------------

conn_url = (
  "postgresql+psycopg2://postgres:"
  f"{os.environ['DB_PASSWORD']}@localhost:5432/test_db" 
)

INTERLIS_TABLES = [
  't_ili2db',
  'referenz'
]


# --- parse input arguments -------------------------------------------------------------
parser = argparse.ArgumentParser(
    description="Create sources.yaml from a source schema.",
    add_help=True,
)
parser.add_argument(
    "--target_schema",
    "-t",
    dest="target_schema",
    type=str,
    required=True,
    help="Name of the target schema to create boundary models for.",
)
args = parser.parse_args()



# --- DB Connection Setup ------------------------------------------------------------

metadata_obj = MetaData()
engine = create_engine(conn_url)

# prepare general use table definitions
tbl_info_column_names = Table(
  "columns",  
  metadata_obj,
  schema="information_schema",
  autoload_with=engine
)


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
  if not any(pattern in name for pattern in INTERLIS_TABLES)
]

# --- Build Boundary Models ---------------------------------------------------

# for each target table, get column list

for table_name in table_names:
  # get column list
  sql_get_column_names = (
    select(tbl_info_column_names.c.column_name)
    .where(tbl_info_column_names.c.table_schema == args.target_schema)
    .where(tbl_info_column_names.c.table_name == table_name)
  )
  with engine.connect() as conn:
    result = conn.execute(sql_get_column_names)
    column_names = [row.column_name for row in result]

  # create model stump
  






