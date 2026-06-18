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
  'catref',
  'localised',
  'multilingual'
]

# --- parse input arguments -------------------------------------------------------------

parser = argparse.ArgumentParser(
    description="Create sources.yaml from a source schema.",
    add_help=True,
)
parser.add_argument(
    "--schema_name",
    "-t",
    dest="schema_name",
    type=str,
    required=True,
    help="Name of the target schema to create boundary models for.",
)
parser.add_argument(
    "--output-path",
    "-o",
    dest="output_path",
    type=str,
    required=True,
    help="Path to output directory for generated files.",
)
parser.add_argument(
    "--table-name",
    "-n",
    dest="table_name",
    type=str,
    required=False,
    help="""Optional: Name of table to generate model for. 
            If omitted, models are build for ALL tables in the schema."""
)
parser.add_argument(
    "--source-mode",
    "-s",
    action="store_true",
    dest="source_mode",
    help="""Optional: Generate a source model instead of a target model."""
)
args = parser.parse_args()

# debugging args
# class DebuggingArgs:
#   def __init__(self, schema_name, output_path, table_list):
#     self.schema_name = schema_name
#     self.output_path = output_path
#     self.table_list = table_list
    
# args = DebuggingArgs(
#   schema_name='prod_gl_biotope', 
#   output_path='/project/src/python/generate_ili_mirror_models/output',
#   table_list=['biotope_to_sf']
# )


# --- DB Connection Setup ------------------------------------------------------------

metadata_obj = MetaData()
engine = create_engine(conn_url)

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

def get_table_names_for_schema(schema_name):
  # get list of tables in schema
  tbl_info_table_names = Table(
    "tables",  
    metadata_obj,
    schema="information_schema",
    autoload_with=engine
  )
  sql_get_table_names = (
    select(tbl_info_table_names.c.table_name)
    .where(tbl_info_table_names.c.table_schema == schema_name )
  )
  with engine.connect() as conn:
    result = conn.execute(sql_get_table_names)
    table_names = [row.table_name for row in result]

  # filter out tables managed by interlis
  data_table_names = [
    name for name in table_names 
    if not any(pattern in name for pattern in INTERLIS_TABLE_NAME_PATTERNS)
  ]
  return data_table_names

# --- Build Boundary Models ---------------------------------------------------

if args.table_name is None:
  data_table_names = get_table_names_for_schema(args.schema_name)  

else:
  data_table_names = [args.table_name]

# for each target table, get column list
for table_name in data_table_names:
  # get column list  
  with engine.connect() as conn:
    result = conn.execute(
      sql_get_column_info,
      {"schema": args.schema_name, "table": table_name,}
    )
    column_info = [(row.column_name, row.data_type) for row in result]

  # create list of SQL strings corresponding to columns
  str_column_list = []
  for column_name, data_type in column_info:
    str_column_list.append(f"  {column_name}::{data_type},\n")
 
  str_column_list[-1] = str_column_list[-1].replace(",", "") # get rid of comma in last column string
  
  # create dbt model stump

  if args.source_mode:
    filename = f"stg_{table_name}.sql"
  else:
    filename = f"ili_mirror_{table_name}.sql"

  output_file = Path(args.output_path) / filename
  with output_file.open('w', encoding='utf-8') as f:
    if args.source_mode:
      f.write("SELECT \n")
      f.writelines(str_column_list)
      f.write(f"FROM {{{{ source('{args.schema_name}', '{table_name}') }}}}") # {{ -> {
    
    else:
      f.write("{{ config(materialized='table', enabled=false) }} \n\n")
      f.write("SELECT \n")
      f.writelines(str_column_list)
      f.write(f"FROM {{{{ ref('placeholder') }}}}") # {{ -> {


