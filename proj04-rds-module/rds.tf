module "database" {
  source       = "./modules/rds"
  project_name = "proj04-rds-module"
  db_name      = "mydb"
  security_group_ids = [
    aws_security_group.compliant.id
  ]
  subnet_ids = [
    aws_subnet.private1.id,
    aws_subnet.private2.id
  ]
  credentials = {
    username = "dbadmin"
    password = "YourSecurePassword2025!"
  }
}
