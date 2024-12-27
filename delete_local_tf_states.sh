# Find and delete all .terraform directories
find . -type d -name ".terraform" -exec rm -rf {} +

# Find and delete specific terraform state files
find . -type f \( \
    -name ".terraform.lock.hcl" \
    -o -name ".terraform.tfstate.lock.info" \
    -o -name "terraform.tfstate.backup" \
    -o -name "terraform.tfstate" \
    # deletes any plans we might have saved
    -o -name "myplan" \
\) -exec rm -f {} +