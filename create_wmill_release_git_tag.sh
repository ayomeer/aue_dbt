#!/bin/bash

# -- argument parsing -----------------------------------------------------
while getopts "p:n:" opt; do
  case "$opt" in
    p)
      project_path="$OPTARG"
      ;;
    n)
      release_name="$OPTARG"
      ;;
    \?)
      echo "Usage: $0 -p project_path -n release_name"
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument."
      exit 1
      ;;
  esac
done

if [[ -z "$project_path" || -z "$release_name" ]]; then
    echo "Usage: $0 -p project_path -n release_name"
    exit 1
fi

# -- main script -----------------------------------------------------------
echo "Project Path: $project_path"
echo "Release Name: $release_name"

rm -rf -i "${project_path}/dbt_packages/*/.git"
git add -f "${project_path}/dbt_packages"
git commit -m "wmill release commit"
git tag $release_name 
git push origin $release_name 
git rm -rf "${project_path}/dbt_packages"
git commit -m "removing dbt_packages after wmill release"