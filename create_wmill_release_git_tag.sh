#!/bin/bash

# -- argument parsing -----------------------------------------------------
usage() {
    echo "Usage: $0 -p project_path -n release_name"
    echo ""
    echo "Options:"
    echo "  -p project_path   Path to dbt project root"
    echo "  -n release_name   Name to give the git release"
    echo "  -h                Show this help message"
}

while getopts "p:n:h" opt; do
  case "$opt" in
    p)
      project_path="$OPTARG"
      ;;
    n)
      release_name="$OPTARG"
      ;;
    h)
      usage
      exit 0
      ;;
    \?)
      usage >&2
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