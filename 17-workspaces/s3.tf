/*
Terraform Workspaces
-------------------
Workspaces allow you to manage multiple states for the same configuration. This is useful for managing multiple environments
(e.g., dev, staging, prod) or multiple feature branches.

Basic Workspace Commands:
1. List workspaces:
   terraform workspace list

2. Create a new workspace:
   terraform workspace new <workspace_name>

3. Switch to an existing workspace:
   terraform workspace select <workspace_name>

4. Show current workspace:
   terraform workspace show

5. Delete a workspace:
   terraform workspace delete <workspace_name>

Note: The default workspace is always named "default" and cannot be deleted.

In this example, we're using terraform.workspace to include the workspace name in the S3 bucket name,
making it unique per workspace.
*/

/*
To apply and destroy infrastructure in different workspaces:

1. Apply changes:
   ./apply.sh
   - If a workspace-specific tfvars file exists (e.g., dev.tfvars for dev workspace),
     it will use those variables
   - Otherwise falls back to default variables

2. Destroy infrastructure:
   ./destroy.sh  
   - Similarly uses workspace-specific tfvars if available
   - Otherwise uses default variables

Example:
  terraform workspace new dev
  ./apply.sh     # Uses dev.tfvars if it exists
  ./destroy.sh   # Uses dev.tfvars if it exists
*/

resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "this" {
  count  = var.bucket_count
  bucket = "workspaces-demo-${terraform.workspace}-${count.index}-${random_id.bucket_suffix.hex}"
}
