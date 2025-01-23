variable "region" {
  description = "The region in which to create the resources"
  type        = string
  default     = "eu-west-1"
}

variable "numbers_list" {
  type = list(number)
}

variable "objects_list" {
  type = list(object({
    firstname = string
    lastname  = string
  }))
}
