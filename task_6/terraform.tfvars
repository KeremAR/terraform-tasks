aws_region = "us-east-1"

vpc_name = "cmtr-zdv1y551-01-vpc"
vpc_cidr = "10.10.0.0/16"

public_subnets = {
  "a" = {
    name = "cmtr-zdv1y551-01-subnet-public-a"
    az   = "us-east-1a"
    cidr = "10.10.1.0/24"
  },
  "b" = {
    name = "cmtr-zdv1y551-01-subnet-public-b"
    az   = "us-east-1b"
    cidr = "10.10.3.0/24"
  },
  "c" = {
    name = "cmtr-zdv1y551-01-subnet-public-c"
    az   = "us-east-1c"
    cidr = "10.10.5.0/24"
  }
}

igw_name = "cmtr-zdv1y551-01-igw"
rt_name  = "cmtr-zdv1y551-01-rt" 