provider "aws" {
  region = "us-east-1"
}

# Find the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Find the pre-existing VPC for this lab
data "aws_vpc" "lab_vpc" {
  tags = {
    Name = "cmtr-zdv1y551-vpc"
  }
}

# Find a public subnet within that VPC to launch our instance in
data "aws_subnet" "lab_public_subnet" {
  vpc_id            = data.aws_vpc.lab_vpc.id
  availability_zone = "us-east-1a" # Assuming a public subnet exists here

  filter {
    name   = "tag:Name"
    values = ["cmtr-zdv1y551-public_subnet"]
  }
}

# Find the pre-existing Security Group
data "aws_security_group" "lab_sg" {
  vpc_id = data.aws_vpc.lab_vpc.id
  name   = "cmtr-zdv1y551-sg"
}

# Define common tags in one place to reuse them
locals {
  common_tags = {
    Project = "epam-tf-lab"
    ID      = "cmtr-zdv1y551"
  }
} 