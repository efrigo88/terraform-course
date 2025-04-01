terraform {
  cloud {
    organization = "my-lab-organization"
    workspaces {
      name = "terraform-cli"
    }
  }
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5.1"
    }
  }
}
