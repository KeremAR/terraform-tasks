variable "aws_region" {
  description = "The AWS region to deploy resources."
  type        = string
}

variable "project_id" {
  description = "Project identifier for tagging."
  type        = string
}

variable "ami_id" {
  description = "AMI ID for EC2 instances."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
}

variable "vpc_name" {
  description = "Name of the pre-existing VPC."
  type        = string
}

variable "ec2_sg_name" {
  description = "Name of the EC2 security group."
  type        = string
}

variable "http_sg_name" {
  description = "Name of the HTTP security group."
  type        = string
}

variable "lb_sg_name" {
  description = "Name of the Load Balancer security group."
  type        = string
}

variable "instance_profile_name" {
  description = "Name of the IAM instance profile."
  type        = string
}

variable "key_pair_name" {
  description = "Name of the SSH key pair."
  type        = string
}

variable "launch_template_name" {
  description = "Name of the Launch Template."
  type        = string
}

variable "asg_name" {
  description = "Name of the Auto Scaling Group."
  type        = string
}

variable "load_balancer_name" {
  description = "Name of the Application Load Balancer."
  type        = string
}

variable "target_group_name" {
  description = "Name of the Target Group."
  type        = string
}

variable "asg_min_size" {
  description = "Minimum size of the Auto Scaling Group."
  type        = number
}

variable "asg_max_size" {
  description = "Maximum size of the Auto Scaling Group."
  type        = number
}

variable "asg_desired_capacity" {
  description = "Desired capacity of the Auto Scaling Group."
  type        = number
} 