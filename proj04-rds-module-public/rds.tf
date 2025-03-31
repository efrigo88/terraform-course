locals {
  # TODO: Replace with your own IP address or with a range of IPs
  whitelisted_ip_list = ["213.195.118.215/32"]
}

module "database" {
  source       = "./modules/rds"
  project_name = "proj04-rds-module"
  db_name      = "mydb"
  security_group_ids = [
    aws_security_group.rds.id
  ]
  subnet_ids = [
    aws_subnet.public1.id,
    aws_subnet.public2.id
  ]
  credentials = {
    username = "dbadmin"
    password = "YourSecurePassword2025!"
  }
}
