import os
import sys
import shutil
import subprocess
from pathlib import Path

from dataclasses import dataclass
from jinja2 import Environment, FileSystemLoader

# other modules in the project
from util_user_input import UserInput
from util_render_template import JinjaRenderer


# -- Classes -------------------------------------------------------------------------------------
@dataclass
class Inputs:
    # dbt project
    project_name: str = None

    db_read_role: str = None
    db_owner_role: str = None

    target_data_basket_tid: int = None
    starting_data_tid: int = None

    # dbt schema
    create_dbt_schema: bool = None

    # export job
    export_setup: bool = None
    target_schema: str = None
    target_export_name: str = None

# -- Helper Functions ----------------------------------------------------------------------------
def coalesce(value, default):
    return default if value is None else value

# -- Debugging Constants -------------------------------------------------------------------------
DEBUG_MODE = False

debugging_inputs=Inputs(
    project_name='dbt_proj',
    db_read_role='read_role',
    db_owner_role='owner_role',
    target_data_basket_tid=2,
    export_setup=False,
    starting_data_tid=None,
    target_schema=None,
    target_export_name=None,
    create_dbt_schema=True
)

# -- Paths Constants------------------------------------------------------------------------------
DBT_PROJECTS_PATH =Path('/project/src/dbt')
TEMPLATES_PATH = Path(__file__).parent / 'templates'


# -- Get Inputs ----------------------------------------------------------------------------------
# Prepare dataclass object for inputs to go in

if not DEBUG_MODE:
    inp = Inputs()

    # Info
    print("""
    This is an interactive dbt project generation wizard. It will generate a new dbt project 
    at src/dbt/ using your inputs.
    """)

    # Project Name
    print("\nEnter project name (format: 'dbt_<topic>'):")
    inp.project_name = input().strip()

    # Read/Write Roles
    print("\nWhich DB-Role shall get READ priviledges on dbt models and artifacts?")
    inp.db_read_role = input().strip()

    print("""
    Which DB-Role shall be OWNER of on dbt models and artifacts?
    This role should match the source schema's owner role to avoid permission issues.
    """)
    inp.db_owner_role = input().strip()

    print("""
    Set up export transform?
    """)
    inp.export_setup = UserInput.yes_no()

    if inp.export_setup:
        # Target Schema
        print("\nWhat is the target schema for the transformation to be modeled?")
        inp.target_schema = input().strip()

        # Target Export Name
        print("\nWhat shall the transformation job be named?")
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
            inp.starting_data_tid = int(input_str)

if DEBUG_MODE:
    inp = debugging_inputs

# -- Create directory structure ------------------------------------------------------------------
# Create project root
new_project_root = (DBT_PROJECTS_PATH / inp.project_name)
try:
    new_project_root.mkdir(parents=True)
except OSError:
    print(f"Could not create directory {new_project_root}. Make sure the directory doesn't already exist.")
    sys.exit(1) 

# create subdirectories
(new_project_root / "analyses").mkdir()
(new_project_root / "dbt_packages").mkdir()
(new_project_root / "macros").mkdir()
(new_project_root / "models").mkdir()
(new_project_root / "models/staging").mkdir()
(new_project_root / "models/transformations").mkdir()
(new_project_root / f"models/transformations/{inp.target_export_name}").mkdir()
(new_project_root / "models/audits").mkdir()

(new_project_root / "ref").mkdir()
(new_project_root / "tests").mkdir()

# -- Create Project Configuration Files from Templates -------------------------------------------
# Set up jinja environment

jinja_renderer = JinjaRenderer(TEMPLATES_PATH)

# Render dbt_project.yml
dbt_project_render_args = {
    "project_name": inp.project_name,
    "starting_data_tid": coalesce(inp.starting_data_tid, 100),
    "export_variables_key": inp.target_export_name,
    "target_data_basket_tid": inp.target_data_basket_tid,
    "read_role": inp.db_read_role,
    "owner_role": inp.db_owner_role
}

jinja_renderer.render_template(
    template_name="t_dbt_project.yml.j2",
    render_args=dbt_project_render_args,
    output_path=new_project_root / "dbt_project.yml"
)

# Render profiles.yml
dbt_profiles_render_args = {
    "project_name": inp.project_name
}

jinja_renderer.render_template(
    template_name="t_profiles.yml.j2",
    render_args=dbt_profiles_render_args,
    output_path=new_project_root / "profiles.yml"
)

# Copy packages.yml
shutil.copy2(TEMPLATES_PATH / "packages.yml", new_project_root)

# Success Message
print(f"Successfully created dbt project at {new_project_root}!")


# -- Run Checks ----------------------------------------------------------------------------------
print(f"Running checks for new project {inp.project_name}...")
print("Loading dependencies...")
subprocess.run(
    ["dbt", "deps"],
    cwd=new_project_root,
    check=True
)

print("Running dbt debug...")
subprocess.run(
    ["dbt", "debug"],
    cwd=new_project_root,
    check=True
)

# -- Set up dbt Schema on IAP Server -------------------------------------------------------------
# Doing this through dbt run-operation macros defined in ili_utils package

# Give Option to skip
print("""
Create dbt schema on IAP server? [Y/n] 
(You will have to do this manually if you select 'No')
""")
inp.create_dbt_schema = UserInput.yes_no()

if inp.create_dbt_schema:
    print("Creating dbt_schema...")
    subprocess.run(
        [
            "dbt", "run-operation", "ili_utils.create_dbt_schema", "--args", 
            f"{{ schema_name: {inp.project_name}, owner_role: {inp.db_owner_role}, read_role: {inp.db_read_role} }}"
        ],
        cwd=new_project_root,
        check=True
    )
    subprocess.run(
        [
            "dbt", "run-operation", "ili_utils.create_ili_sequence", "--args", 
            f"{{ schema_name: {inp.project_name} }}"
        ],
        cwd=new_project_root,
        check=True
    )
    print(f"Succesfully created schema {inp.project_name} on IAP!")

else:
    print("Skipping dbt schema creation.")


print("""
dbt Project setup complete!

Next steps:
- add tables you want to work with in dbt to sources to models/sources.yml
- generate staging and ili_mirror models using the 'generate_models.py' utility
- define your transform!

Note: 
VsCode will show problems with the newly created project. 
They should go away if you reload the window (Ctr + Shift + P > Reload Window).
""")