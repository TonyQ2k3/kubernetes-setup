
# Create a vpc
resource "aws_vpc" "k8s-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

# Create 2 public subnets
resource "aws_subnet" "k8s-subnets" {
  for_each                = { for subnet in var.subnet_list : subnet.name => subnet }
  vpc_id                  = aws_vpc.k8s-vpc.id
  cidr_block              = each.value.cidr_block
  map_public_ip_on_launch = true
  availability_zone       = each.value.az
  tags = {
    Name = each.value.name
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "k8s-igw" {
  vpc_id = aws_vpc.k8s-vpc.id
  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

# Create a route table for the public subnets
resource "aws_route_table" "k8s-public-rtb" {
  vpc_id = aws_vpc.k8s-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.k8s-igw.id
  }
}

# Create a route table association for each public subnet
resource "aws_route_table_association" "k8s-public-rtb-assoc" {
  for_each       = aws_subnet.k8s-subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.k8s-public-rtb.id
}

# Create a security group for the public subnets
resource "aws_security_group" "k8s-public-sg" {
  vpc_id      = aws_vpc.k8s-vpc.id
  name        = "${var.vpc_name}-public-sg"
  description = "Security group for public subnets"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}