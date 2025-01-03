ec2_instance_type = "t2.micro"

# These will take precedence over the default values in variables.tf
ec2_volume_config = {
  size = 10
  type = "gp3"
}

additional_tags = {
  ValuesFrom = "terraform.tfvars"
}