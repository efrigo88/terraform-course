#!/bin/bash

# Get current workspace
WORKSPACE=$(terraform workspace show)

# Check if the workspace-specific tfvars file exists
if [ -f "${WORKSPACE}.tfvars" ]; then
    echo "Destroying with workspace-specific variables from ${WORKSPACE}.tfvars"
    terraform destroy  -auto-approve -var-file="${WORKSPACE}.tfvars"
else
    echo "No workspace-specific variables found for ${WORKSPACE}, destroying with default variables"
    terraform destroy -auto-approve
fi