output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.k8s-vpc.id
}

output "public_sg_id" {
    description = "The ID of the public security group"
    value       = aws_security_group.k8s-public-sg.id
}

output "subnet_ids" {
  description = "List of public subnet IDs"
  value       = [ for subnet in aws_subnet.k8s-subnets: subnet.id ]
}