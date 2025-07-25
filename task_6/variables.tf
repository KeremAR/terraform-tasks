variable "aws_region" {
  description = "The AWS region to create resources in."
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC."
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "public_subnets" {
  description = "A map of public subnets to create. Each object contains the name, availability zone, and CIDR block."
  type = map(object({
    name = string
    az   = string
    cidr = string
  }))
}

variable "igw_name" {
  description = "The name for the Internet Gateway."
  type        = string
}

variable "rt_name" {
  description = "The name for the Route Table."
  type        = string
} 