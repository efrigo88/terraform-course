data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Owner ID is Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}
output "ubuntu_ami_data" {
  value = data.aws_ami.ubuntu.id
}

data "aws_caller_identity" "current" {}
output "aws_caller_identity" {
  value = data.aws_caller_identity.current
}

data "aws_region" "current" {}
output "aws_region" {
  value = data.aws_region.current
}

resource "aws_instance" "web" {
  ami                         = data.aws_ami.ubuntu.id
  associate_public_ip_address = true
  instance_type               = "t2.micro"

  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp3"
  }
}
