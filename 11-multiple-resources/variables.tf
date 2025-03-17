variable "region" {
  description = "The region in which to create the resources"
  type        = string
  default     = "eu-west-1"
}

variable "subnet_count" {
  type    = number
  default = 2
}

variable "ec2_instance_count" {
  type    = number
  default = 1
}
