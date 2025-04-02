variable "tf_cloud_hostname" {
  description = "The hostname of the Terraform Cloud instance"
  type        = string
  default     = "app.terraform.io"
}

variable "tf_cloud_audience" {
  description = "The audience of the Terraform Cloud OIDC provider"
  type        = string
  default     = "aws.workload.identity"
}
