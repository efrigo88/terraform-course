variable "region" {
  description = "The region in which to create the resources"
  type        = string
  default     = "eu-west-1"
}

variable "subnet_count" {
  type    = number
  default = 2
}
