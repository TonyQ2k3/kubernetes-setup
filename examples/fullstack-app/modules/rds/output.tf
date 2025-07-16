output "database_endpoint" {
  description = "The endpoint of the database instance"
  value       = aws_db_instance.database.endpoint
}