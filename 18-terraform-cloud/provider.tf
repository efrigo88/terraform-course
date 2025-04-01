terraform {
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
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5.1"
    }
  }
}

provider "aws" {
  region = "eu-west-1"

  default_tags {
    tags = {
      Name      = "18-terraform-cloud"
      CreatedBy = "Terraform Cloud"
    }
  }
}
