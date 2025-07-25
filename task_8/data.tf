# Data source for existing VPC
data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

# Data sources for existing subnets
data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }

  filter {
    name   = "cidr-block"
    values = ["10.0.1.0/24", "10.0.3.0/24"] # Public subnets
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }

  filter {
    name   = "cidr-block"
    values = ["10.0.2.0/24", "10.0.4.0/24"] # Private subnets
  }
}

# Data sources for existing security groups
data "aws_security_group" "ec2_sg" {
  name   = var.ec2_sg_name
  vpc_id = data.aws_vpc.main.id
}

data "aws_security_group" "http_sg" {
  name   = var.http_sg_name
  vpc_id = data.aws_vpc.main.id
}

data "aws_security_group" "lb_sg" {
  name   = var.lb_sg_name
  vpc_id = data.aws_vpc.main.id
}

# Data source for existing IAM instance profile
data "aws_iam_instance_profile" "main" {
  name = var.instance_profile_name
}

# Data source for existing key pair
data "aws_key_pair" "main" {
  key_name = var.key_pair_name
} 