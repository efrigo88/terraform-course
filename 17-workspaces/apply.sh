#!/bin/bash

# Get current workspace
WORKSPACE=$(terraform workspace show)

# Check if the workspace-specific tfvars file exists
if [ -f "${WORKSPACE}.tfvars" ]; then
    echo "Applying with workspace-specific variables from ${WORKSPACE}.tfvars"
    terraform apply -auto-approve -var-file="${WORKSPACE}.tfvars"
else
    echo "No workspace-specific variables found for ${WORKSPACE}, applying with default variables"
    terraform apply -auto-approve
fi