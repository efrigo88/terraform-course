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

variable "ec2_instance_config_list" {
  type = list(object({
    instance_type = string
    ami           = string
  }))

  # Ensure that only t2.micro instances are allowed
  validation {
    condition = alltrue(
      [
        for config in var.ec2_instance_config_list : contains(["t2.micro"], config.instance_type)
      ]
    )
    error_message = "Only t2.micro instances are allowed"
  }

  # Ensure that only ubuntu and nginx images are used
  validation {
    condition = alltrue(
      [
        for config in var.ec2_instance_config_list : contains(["ubuntu", "nginx"], config.ami)
      ]
    )
    error_message = "At least one of the provided \"ami\" values is not supported.\nSupported \"ami\" values: \"ubuntu\", \"nginx\"."
  }
}

variable "ec2_instance_config_map" {
  type = map(object({
    instance_type = string
    ami           = string
    subnet_index  = optional(number, 0)
  }))

  # Ensure that only t2.micro instances are allowed
  validation {
    condition = alltrue(
      [
        for config in values(var.ec2_instance_config_map) : contains(["t2.micro"], config.instance_type)
      ]
    )
    error_message = "Only t2.micro instances are allowed"
  }

  # Ensure that only ubuntu and nginx images are used
  validation {
    condition = alltrue(
      [
        for config in values(var.ec2_instance_config_map) : contains(["ubuntu", "nginx"], config.ami)
      ]
    )
    error_message = "At least one of the provided \"ami\" values is not supported.\nSupported \"ami\" values: \"ubuntu\", \"nginx\"."
  }

  validation {
    condition = alltrue(
      [
        for config in values(var.ec2_instance_config_map) : config.subnet_index < length(aws_subnet.main)
      ]
    )
    error_message = "Invalid subnet index"
  }
}
