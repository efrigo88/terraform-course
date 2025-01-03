variable "region" {
  description = "The region in which to create the resources"
  type        = string
  default     = "eu-west-1"
}

variable "ec2_instance_type" {
  description = "The instance type of the EC2 instance"
  type        = string

  validation {
    condition     = contains(["t2.micro", "t3.micro"], var.ec2_instance_type)
    error_message = "Only supports t2.micro and t3.micro"
  }
}

variable "ec2_volume_config" {
  description = "The volume size and type of the EC2 instance"

  type = object({
    size = number
    type = string
  })

  default = {
    size = 10
    type = "gp2" # will be overridden by the values in terraform.tfvars
  }
}

variable "additional_tags" {
  description = "Additional tags to apply to the resources"
  type        = map(string)
  default     = {}
}