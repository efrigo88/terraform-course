locals {
  project_name = "15-object-validation"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "this" {
  vpc_id     = data.aws_vpc.default.id
  cidr_block = "172.31.123.0/24"

  tags = {
    Name       = local.project_name
    Project    = local.project_name
    managed_by = "Terraform"
  }

  lifecycle {
    postcondition {
      condition = contains(
        data.aws_availability_zones.available.names, self.availability_zone
      )
      error_message = "Invalid AZ"
    }
  }
}
