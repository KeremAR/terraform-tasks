variable "ssh_key" {
  type        = string
  description = "Provides custom public SSH key."
}

variable "base_name" {
  description = "The base name for all resources, e.g., 'cmtr-zdv1y551'."
  type        = string
}

variable "project_tag" {
  description = "The value for the Project tag."
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instance to create."
  type        = string
}

variable "aws_region" {
  description = "The AWS region where resources will be deployed."
  type        = string
}

variable "ami_filter_name" {
  description = "The name filter for the AWS AMI data source."
  type        = string
}

variable "ami_filter_owners" {
  description = "The list of owners for the AWS AMI data source."
  type        = list(string)
} 