variable "nlb_name" {
  description = "The name of the ELB"
  type        = string
  default     = "k8s-nlb"
}

variable "nlb_security_groups" {
  description = "Security group IDs to associate with the NLB"
  type        = list(string)
  default     = []
}

variable "nlb_subnets" {
  description = "Subnets to associate with the NLB"
  type        = list(string)
  default     = []
}

variable "vpc_id" {
  description = "The VPC ID where the NLB will be created"
  type        = string
  default     = ""
}

variable "k8s_api_instance_ids" {
  description = "List of Kubernetes API server instance IDs to register with the NLB"
  type        = list(string)
  default     = []
}

variable "node_count" {
  description = "Number of Kubernetes API server instances"
  type        = number
  default     = 3
}