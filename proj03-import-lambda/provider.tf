terraform {
  required_version = "~> 1.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.0"
    }
  }
}

provider "aws" {
  profile = "admin"
  region  = "eu-west-1"
  default_tags {
    tags = {
      Project   = "proj03-import-lambda"
      ManagedBy = "terraform"
    }
  }
}
