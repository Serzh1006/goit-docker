output "db_endpoint" {
  description = "RDS PostgreSQL endpoint"
  value       = aws_db_instance.postgres.address
}


output "db_port" {
  description = "RDS PostgreSQL port"
  value       = aws_db_instance.postgres.port
}


output "db_name" {
  description = "Database name"
  value       = aws_db_instance.postgres.db_name
}


output "db_username" {
  description = "Database username"
  value       = aws_db_instance.postgres.username
}


output "security_group_id" {
  description = "RDS security group ID"
  value       = aws_security_group.rds.id
}