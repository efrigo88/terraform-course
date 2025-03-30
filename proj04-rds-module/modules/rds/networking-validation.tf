########################################################
# Subnet validation
########################################################
data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "input" {
  for_each = toset(var.subnet_ids)
  id       = each.value

  lifecycle {
    postcondition {
      condition     = self.vpc_id != data.aws_vpc.default.id
      error_message = <<-EOT
      The following subnet is part of the default VPC.

      Name = ${self.tags["Name"]}
      ID = ${self.id}

      Please do not deploy the RDS instance in the default VPC.
      EOT
    }

    postcondition {
      condition     = contains(keys(self.tags), "Access") && lower(self.tags.Access) == "private"
      error_message = <<-EOT
      The following subnet is not marked as private.

      Name = ${self.tags["Name"]}
      ID = ${self.id}

      Please ensure that the subnet has an "Access" tag set to "private".
      EOT
    }
  }
}

########################################################
# Security group validation
########################################################
