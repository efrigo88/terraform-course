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
  count      = 2
  vpc_id     = data.aws_vpc.default.id
  cidr_block = "172.31.${123 + count.index}.0/24"
  # Use modulo to distribute subnets evenly across AZs (round-robin)
  availability_zone = data.aws_availability_zones.available.names[
    count.index % length(data.aws_availability_zones.available.names)
  ]

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

check "high_availability_check" {
  assert {
    condition = length(
      toset([for subnet in aws_subnet.this : subnet.availability_zone])
    ) > 1
    error_message = <<-EOT
    Your are deploying all subnets within the same AZ. 
    Please consider distributing them across AZs for higher availability.
    EOT
  }
}
