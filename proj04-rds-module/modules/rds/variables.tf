########################################################
# General information
########################################################
variable "project_name" {
  type        = string
  description = "The name of the project"
}

########################################################
# DB config
########################################################
variable "instance_class" {
  type        = string
  default     = "db.t3.micro"
  description = "The instance class of the RDS instance"
  validation {
    condition     = contains(["db.t3.micro"], var.instance_class)
    error_message = "Only db.t3.micro is supported for this project."
  }
}

variable "storage_size" {
  type        = number
  default     = 10
  description = "The storage size of the RDS instance"
  validation {
    condition     = var.storage_size > 5 && var.storage_size <= 10
    error_message = "The storage size must be between 5 and 10GB."
  }
}

variable "engine" {
  type        = string
  default     = "postgres-latest"
  description = "The engine of the RDS instance"
  validation {
    condition     = contains(["postgres-latest", "postgres-14"], var.engine)
    error_message = "Only postgres-latest or postgres-14 is supported for this project."
  }
}

########################################################
# DB credentials
########################################################
variable "credentials" {
  type = object({
    username = string
    password = string
  })
  description = "The credentials of the RDS instance"
  sensitive   = true
  validation {
    condition     = can(regex("^[a-zA-Z0-9!@#$_%&*()+.<>?]{8,}$", var.credentials.password))
    error_message = <<-EOT
      Password must:
      - Be at least 8 characters long
      - Only contain letters (a-z, A-Z), numbers (0-9), and these special characters: !@#$_%&*()+.<>?
    EOT
  }
}

########################################################
# DB network
########################################################
variable "subnet_ids" {
  type        = list(string)
  description = "The subnet IDs of the RDS instance"
}

variable "security_group_ids" {
  type        = list(string)
  description = "The security group IDs of the RDS instance"
}
