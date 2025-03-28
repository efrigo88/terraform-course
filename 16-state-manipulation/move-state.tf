locals {
  ec2_names = ["instance1", "instance2"]
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}

# These "moved" blocks tell Terraform that the resource instances with index-based addresses
# (e.g., aws_instance.new_list[0]) are now identified by named keys (e.g., aws_instance.new_list["instance1"]).
# This prevents Terraform from destroying and recreating resources unnecessarily.
moved {
  from = aws_instance.new_list[0]
  to   = aws_instance.new_list["instance1"]
}

moved {
  from = aws_instance.new_list[1]
  to   = aws_instance.new_list["instance2"]
}
##

moved {
  from = aws_instance.new_list["instance1"]
  to   = aws_instance.new_final
}

moved {
  from = aws_instance.new_list["instance2"]
  to   = module.compute.aws_instance.this
}
##

resource "aws_instance" "new_final" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
}

module "compute" {
  source = "./modules/compute"
  ami_id = data.aws_ami.ubuntu.id
}
