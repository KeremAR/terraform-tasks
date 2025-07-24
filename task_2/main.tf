provider "aws" {
  region = var.aws_region
}

# Find the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = var.ami_filter_owners

  filter {
    name   = "name"
    values = [var.ami_filter_name]
  }
}

locals {
  # Dynamically construct all resource names and filters from the base name
  vpc_name_filter    = "${var.base_name}-vpc"
  subnet_name_filter = "${var.base_name}-public_subnet"
  sg_name_filter     = "${var.base_name}-sg"
  key_name           = "${var.base_name}-keypair"
  instance_name      = "${var.base_name}-ec2"

  # Define common tags in one place to reuse them
  common_tags = {
    Project = var.project_tag
    ID      = var.base_name
  }
}

# Find the pre-existing VPC for this lab
data "aws_vpc" "lab_vpc" {
  tags = {
    Name = local.vpc_name_filter
  }
}

# Find a public subnet within that VPC to launch our instance in
data "aws_subnet" "lab_public_subnet" {
  vpc_id = data.aws_vpc.lab_vpc.id
  filter {
    name   = "tag:Name"
    values = [local.subnet_name_filter]
  }
}

# Find the pre-existing Security Group
data "aws_security_group" "lab_sg" {
  vpc_id = data.aws_vpc.lab_vpc.id
  name   = local.sg_name_filter
} 