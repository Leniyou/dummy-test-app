#!/bin/bash

set -e

# Vars
current_version="0.0.0"

# --
# Function to obtain current project version
#  by reading package.json file
# Arguments:
#   $1: package.json path
# Returns:
#   $current_version: Current project version
# --
get_current_version() {
    package_json_path="$1"
    current_version=$(jq -r '.version' "$package_json_path/package.json")
    
    if [ -z "$current_version" ]; then
        echo "Error: Current project version is invalid: $current_version"
        exit 1
    fi

    echo "Current project version is: $current_version"
    echo "##vso[build.updatebuildnumber]$current_version"
}

if [ -z "$1" ]; then
    echo "Error: Invalid path: $1"
    exit 1
else
    package_json_path="$1"
    if [ ! -f "$package_json_path/package.json" ]; then
        echo "Error: package.json not found in path: $package_json_path"
        exit 1
    else
        echo "Getting current version..."
        get_current_version "$package_json_path"
    fi
fi
