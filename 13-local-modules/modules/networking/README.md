# Networking Module

This module is used to set up networking resources in AWS using Terraform.

## Usage

```hcl
module "networking" {
    source = "../modules/networking"

    vpc_cidr_block = "10.0.0.0/16"
    public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
    private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
    enable_nat_gateway = true
}
```

## Inputs

| Name              | Description                          | Type   | Default | Required |
|-------------------|--------------------------------------|--------|---------|----------|
| vpc_cidr_block    | The CIDR block for the VPC           | string | n/a     | yes      |
| public_subnets    | List of public subnet CIDR blocks    | list   | n/a     | yes      |
| private_subnets   | List of private subnet CIDR blocks   | list   | n/a     | yes      |
| enable_nat_gateway| Enable NAT Gateway for private subnets | bool   | false   | no       |

## Outputs

| Name          | Description                      |
|---------------|----------------------------------|
| vpc_id        | The ID of the VPC                |
| public_subnet_ids | The IDs of the public subnets |
| private_subnet_ids| The IDs of the private subnets|

## Providers

| Name | Version |
|------|---------|
| aws  | >= 2.0  |

## Resources

- `aws_vpc`
- `aws_subnet`
- `aws_internet_gateway`
- `aws_nat_gateway`
- `aws_route_table`
- `aws_route`

## Example

```hcl
provider "aws" {
    region = "us-west-2"
}

module "networking" {
    source = "../modules/networking"

    vpc_cidr_block = "10.0.0.0/16"
    public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
    private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
    enable_nat_gateway = true
}
```
