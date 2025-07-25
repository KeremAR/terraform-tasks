provider "aws" {
  region = var.aws_region
}

# Data source to get existing VPC information
data "aws_vpc" "existing" {
  id = var.vpc_id
}

# Data source to get existing public instance information
data "aws_instance" "public" {
  instance_id = var.public_instance_id
}

# Data source to get existing private instance information
data "aws_instance" "private" {
  instance_id = var.private_instance_id
} 