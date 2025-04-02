terraform {
  required_version = "~> 1.11"
  cloud {
    organization = "my-lab-organization"
    workspaces {
      name = "terraform-cli"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"

  default_tags {
    tags = {
      Name      = "proj05-tf-cloud-oidc"
      CreatedBy = "Terraform Cloud"
    }
  }
}
