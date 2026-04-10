import os
import dbt
from dbt.cli.main import dbtRunner


dbt_proj_root = "/src/dbt/dbt_dbu_aue_quellkataster"
os.chdir(dbt_proj_root) 

runner = dbtRunner()
run_result = runner.invoke(["compile"])

print('Run was successful? -> ', run_result.success)