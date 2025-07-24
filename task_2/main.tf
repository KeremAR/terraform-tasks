provider "aws" {
  region = var.aws_region
}

# Find the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = var.ami_most_recent
  owners      = var.ami_filter_owners

  filter {
    name   = var.ami_filter_key
    values = [var.ami_filter_name]
  }
}

# Find the pre-existing VPC for this lab
data "aws_vpc" "lab_vpc" {
  tags = {
    Name = var.vpc_name_filter
  }
}

# Find a public subnet within that VPC to launch our instance in
data "aws_subnet" "lab_public_subnet" {
  vpc_id            = data.aws_vpc.lab_vpc.id
  availability_zone = "us-east-1a"

  filter {
    name   = var.subnet_filter_key
    values = [var.subnet_name_filter]
  }
}

# Find the pre-existing Security Group
data "aws_security_group" "lab_sg" {
  vpc_id = data.aws_vpc.lab_vpc.id
  name   = var.sg_name_filter
}

# Define common tags in one place to reuse them
locals {
  common_tags = {
    Project = var.project_tag
    ID      = var.id_tag
  }
} 