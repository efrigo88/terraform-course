locals {
  db_engine = {
    "postgres-latest" = {
      engine  = "postgres"
      version = "17.4"
    }
  }
}

resource "aws_db_subnet_group" "this" {
  name       = "${var.project_name}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = var.project_name
  }
}

resource "aws_db_instance" "this" {
  identifier             = var.project_name
  instance_class         = var.instance_class
  allocated_storage      = var.storage_size
  engine                 = local.db_engine[var.engine].engine
  engine_version         = local.db_engine[var.engine].version
  db_name                = var.db_name
  username               = var.credentials.username
  password               = var.credentials.password
  db_subnet_group_name   = aws_db_subnet_group.this.name
  publicly_accessible    = true
  skip_final_snapshot    = true
  vpc_security_group_ids = var.security_group_ids
}
