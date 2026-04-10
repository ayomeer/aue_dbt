import os
import argparse
import psycopg2

# --- parse input arguments -------------------------------------
parser = argparse.ArgumentParser()
parser.add_argument("source_schema_name", type=str)

args = parser.parse_args()




print(f"Creating sources.yaml from schema {args.source_schema_name}...")

