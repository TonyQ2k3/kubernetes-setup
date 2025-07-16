# List of all instance IDs created by this module
output "instance_ids" {
  description = "List of all instance IDs created by this module"
  value       = aws_instance.nodes[*].id
}

output "instance_public_ips" {
  description = "Public IP addresses of the Kubernetes nodes"
  value       = aws_instance.nodes[*].public_ip
}