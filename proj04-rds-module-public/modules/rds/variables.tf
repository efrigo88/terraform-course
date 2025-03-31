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
variable "db_name" {
  type        = string
  description = "The name of the database"
}

variable "instance_class" {
  type        = string
  default     = "db.t3.micro"
  description = "The instance class of the RDS instance"
}

variable "storage_size" {
  type        = number
  default     = 10
  description = "The storage size of the RDS instance"
}

variable "engine" {
  type        = string
  default     = "postgres-latest"
  description = "The engine of the RDS instance"
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
