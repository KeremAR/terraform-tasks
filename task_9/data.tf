# Data source to discover VPC by name tag
data "aws_vpc" "discovered" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

# Data source to discover public subnet by name tag
data "aws_subnet" "discovered" {
  filter {
    name   = "tag:Name"
    values = [var.public_subnet_name]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.discovered.id]
  }
}

# Data source to discover security group by name tag
data "aws_security_group" "discovered" {
  filter {
    name   = "tag:Name"
    values = [var.security_group_name]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.discovered.id]
  }
}

# Data source to get latest Amazon Linux 2023 AMI
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
} 