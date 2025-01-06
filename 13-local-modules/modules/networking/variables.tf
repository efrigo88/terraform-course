variable "vpc_config" {
  description = "Contains the VPC configuration, including the CIDR block and name."
  type = object({
    cidr_block = string
    name       = string
  })

  validation {
    condition     = can(cidrnetmask(var.vpc_config.cidr_block))
    error_message = "The cidr_block config option must be a valid CIDR block"
  }
}

variable "subnet_config" {
  description = <<EOT
  Accepts a map of subnet configurations, including the CIDR block, 
  availability zone, and whether the subnet is public.
  EOT

  type = map(object({
    cidr_block = string
    public     = optional(bool, false)
    az         = string
  }))

  validation {
    condition     = alltrue([for config in values(var.subnet_config) : can(cidrnetmask(config.cidr_block))])
    error_message = "The cidr_block config option must be a valid CIDR block"
  }
}