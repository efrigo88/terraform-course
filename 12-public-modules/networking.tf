data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.17.0"

  cidr            = "10.0.0.0/16"
  name            = "12-public-modules"
  azs             = data.aws_availability_zones.available.names
  private_subnets = ["10.0.0.0/24"]
  public_subnets  = ["10.0.128.0/24"]
}