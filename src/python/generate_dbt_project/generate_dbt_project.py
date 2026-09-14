import os
from pathlib import Path

from dataclasses import dataclass
from jinja2 import Environment, FileSystemLoader

# -- Paths Constants------------------------------------------------------------------------------

DBT_PROJECTS_PATH =Path('/project/src/dbt')

JINJA_TEMPLATES_PATH = Path(__file__).parent / 'templates'

# -- Helper Functions ----------------------------------------------------------------------------
def coalesce(value, default):
    return default if value is None else value

# -- Get Inputs ----------------------------------------------------------------------------------
# Print Info
print("""
This is an interactive dbt project generation wizard. It will generate a new dbt project 
at src/dbt/ using your inputs.
""")

# Prepare dataclass object for inputs to go in
@dataclass
class Inputs:
    # dbt project
    project_name: str = None

    db_read_role: str = None
    db_owner_role: str = None

    target_data_basket_tid: int = None
    starting_data_tid: int = None

    # wizard flow control
    create_dbt_schema: bool = None

    # export job
    target_schema: str = None
    target_export_name: str = None

    

inp = Inputs()


# Project Name
print("Enter project name (format: 'dbt_<topic>'):")
inp.project_name = input().strip()

# Read/Write Roles
print("Which DB-Role shall get READ priviledges on dbt models and artifacts?")
inp.db_read_role = input().strip()

print("""
Which DB-Role shall be OWNER of on dbt models and artifacts?
This role should match the source schema's owner role to avoid permission issues.
""")
inp.db_owner_role = input().strip()



# Target Schema
print("What is the target schema for the transformation to be modelled?")
inp.target_schema = input().strip()

# Target Export Name
print("What shall the transformation job be named?")
inp.target_export_name = input().strip()

# Target basket config
print("""
What is the t_id for the basket data is written to on export?
""")
inp.target_data_basket_tid = int(input().strip())

# Starting data t_id
print("""
What t_id should data that gets exported start with? Press Enter to use default value of 100.
This value needs to be higher than the current value of 't_ili2db_seq' in the target schema after
all preliminary imports, such as catalogues, are done.

""")
if (input_str := input().strip()) == '': # user hit enter to use default
    inp.starting_data_tid = 100
else:
    inp.dbt_schema_name = int(input_str)





print(inp)



# -- Set up directory structure ------------------------------------------------------------------

new_project_root = (DBT_PROJECTS_PATH / inp.project_name).mkdir(parents=True)


# -- Set up dbt Project (Render Templates) -------------------------------------------------------

jinja_env = Environment(
    loader=FileSystemLoader(JINJA_TEMPLATES_PATH),
    variable_start_string="<",
    variable_end_string=">"
)

dbt_project_template = jinja_env.get_template("t_dbt_project.yml.j2")

dbt_project_render_args = {
    "starting_data_tid": coalesce(inp.starting_data_tid, 100),
    "export_variables_key": inp.target_export_name,
    "target_data_basket_tid": inp.starting_data_tid,
    "read_role": inp.db_read_role,
    "owner_role": inp.db_owner_role
}

dbt_project_yml = dbt_project_template.render(**dbt_project_render_args)
output_file = Path()

# -- Set up dbt Schema on IAP Server -------------------------------------------------------------
# Doing this through dbt run-operation macros defined in ili_utils package

# Give Option to skip
print("""
Create dbt schema on IAP server? [Y/n] 
(You will have to do this manually if you select 'No')
""")
while True:
    inp_str = input().strip().lower()
    if inp_str in ['yes', 'y']:
        inp.create_dbt_schema = True
        break

    elif inp_str in ['no', 'n']:
        inp.create_dbt_schema = False
        print("Skipping dbt schema creation.")
        break

    else:
        print("Unrecognized input. Try again.")