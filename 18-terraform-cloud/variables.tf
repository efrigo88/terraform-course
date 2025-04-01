variable "ec2_instance_type" {
  type    = string
  default = "t2.micro"

  validation {
    condition     = var.ec2_instance_type == "t2.micro"
    error_message = "Please use t2.micro for this lab to stay in the free tier."
  }
}
