variable "aws_region" {
  description = "The AWS region where resources will be deployed."
  type        = string
}

variable "project_tag" {
  description = "The value for the Project tag."
  type        = string
}

variable "allowed_ip_range" {
  description = "List of IP address ranges for secure access."
  type        = list(string)
}

variable "vpc_id" {
  description = "The ID of the existing VPC."
  type        = string
}

variable "public_instance_id" {
  description = "The ID of the existing public EC2 instance."
  type        = string
}

variable "private_instance_id" {
  description = "The ID of the existing private EC2 instance."
  type        = string
}

variable "ssh_sg_name" {
  description = "The name for the SSH security group."
  type        = string
}

variable "public_http_sg_name" {
  description = "The name for the public HTTP security group."
  type        = string
}

variable "private_http_sg_name" {
  description = "The name for the private HTTP security group."
  type        = string
} 