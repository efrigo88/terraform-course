terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
}

# Actively managed by us, by our terraform code
resource "aws_s3_bucket" "my_bucket" {
    bucket = var.bucket_name
}

# Managed somewhere else, we just want to use it in out project
data "aws_s3_bucket" "my_external_bucket" {
    bucket = "not-managed-by-us"
}

variable "bucket_name" {
    type = string
    description = "My variable used to set the bucket name"
    default = "my-default-bucket-name"
}

output "bucket_id" {
    value = aws_s3_bucket.my_bucket.id
}

locals {
    local_example = "This is a local variable"
}

# Example of importing a module
module "my_module" {
    source = "./module-example"
}
