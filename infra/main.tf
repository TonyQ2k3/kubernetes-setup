terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
}

provider "aws" {
    region = "us-east-1"
    shared_credentials_files = [ var.credential_file ]
}

# VPC
module "vpc" {
    source = "./modules/vpc"
    vpc_name = "k8s-vpc"
}

# EC2 Instances for Kubernetes Nodes
module "ec2" {
    depends_on = [ module.vpc ]
    source = "./modules/ec2"
    subnet_id = module.vpc.subnet_ids[0]
    security_group_ids = [ module.vpc.public_sg_id ]
    node_count = 3
}

# NLB for multi-master cluster
module "nlb" {
    depends_on = [ module.ec2 ]
    source = "./modules/nlb"
    nlb_name = "k8s-nlb"
    nlb_security_groups = [ module.vpc.public_sg_id ]
    nlb_subnets = module.vpc.subnet_ids
    vpc_id = module.vpc.vpc_id
    k8s_api_instance_ids = module.ec2.instance_ids
}

# Outputs
output "nlb_dns_name" {
    description = "DNS name of the Kubernetes NLB"
    value = module.nlb.nlb_dns_name
}

output "k8s_node_public_ips" {
    description = "Public IP addresses of the Kubernetes nodes"
    value = module.ec2.instance_public_ips
}