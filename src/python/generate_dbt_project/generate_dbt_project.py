import os
from pathlib import Path

from dataclasses import dataclass



# -- Get Inputs ----------------------------------------------------------------------------------
# Print Info
print("""
This is an interactive dbt project generation wizard. It will generate a new dbt project 
at src/dbt/ using your inputs.
""")

# Prepare dataclass object for inputs to go in
@dataclass
class Inputs:
    project_name: str = None
    dbt_schema_name: str = None

inp = Inputs()


# Get Project Name
print("Enter project name (format: 'dbt_<topic>'):")
inp.project_name = input()





print("""
Create dbt schema on IAP server? [Y/n] 
(You will have to do this manually if you select 'No')
""")
if input() in ['Yes', 'Y', 'y']:
    # TODO: Call ili_utils run-operation scripts to set up dbt_schema
