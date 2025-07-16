variable "cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
  default     = "k8s-cluster"
}

variable "role_arn" {
  description = "The ARN of the IAM role to be used by the EKS cluster."
  type        = string
  default     = "arn:aws:iam::536482894396:role/LabRole" # Change this to your actual role ARN
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster."
  type        = list(string)
}