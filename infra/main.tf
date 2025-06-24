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

module "vpc" {
    source = "./modules/vpc"
    vpc_name = "k8s-vpc"
}

resource "aws_instance" "nodes" {
    depends_on = [ module.vpc ]
    ami = "ami-0e2c8caa4b6378d8c"
    instance_type = "t2.medium"
    subnet_id = module.vpc.subnet_ids[0]
    vpc_security_group_ids = [ module.vpc.public_sg_id ]
    key_name = "linux-kp"
    root_block_device {
      volume_size = 16
    }
    count = 3
    tags = {
        Name = "node-${count.index + 1}"
    }
}


# Output
output "nodes_public_ip" {
  description = "Public IP addresses of the Kubernetes nodes"
  value = aws_instance.nodes[*].public_ip
}