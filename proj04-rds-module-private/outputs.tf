output "rds_instance_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = module.database.rds_instance_endpoint
}
