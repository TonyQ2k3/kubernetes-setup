output "nlb_dns_name" {
  description = "The DNS name of the Network Load Balancer"
  value       = aws_lb.k8s_nlb.dns_name
}