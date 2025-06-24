variable "vpc_cidr" {
    type = string
    description = "CIDR block for the VPC"
    default = "10.0.0.0/16"
}

variable "vpc_name" {
    type = string
    description = "Name of the VPC"
    default = "k8s-vpc"
}

variable "subnet_list" {
    type = list(object({
        name       = string
        cidr_block = string
    }))
    description = "List of subnets to create in the VPC"
    default = [
        {
            name       = "k8s-subnet-1"
            cidr_block = "10.0.1.0/24"
        }
    ]
}