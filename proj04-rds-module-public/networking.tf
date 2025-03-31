resource "aws_vpc" "custom" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "proj04-rds-module"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.custom.id

  tags = {
    Name = "proj04-rds-module-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.custom.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "proj04-rds-module-public-rt"
  }
}

resource "aws_subnet" "public1" {
  vpc_id                  = aws_vpc.custom.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-west-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-custom-vpc-public1"
  }
}

resource "aws_subnet" "public2" {
  vpc_id                  = aws_vpc.custom.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "eu-west-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-custom-vpc-public2"
  }
}

resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "rds" {
  name        = "rds-sg"
  description = "Security group for RDS access"
  vpc_id      = aws_vpc.custom.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = local.whitelisted_ip_list
  }
}
