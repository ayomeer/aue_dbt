import os
import argparse
import psycopg2

# --- parse input arguments -------------------------------------
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




print(f"Creating sources.yaml from schema {args.target_schema}...")

