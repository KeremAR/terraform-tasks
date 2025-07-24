variable "ssh_key" {
  type        = string
  description = "Provides custom public SSH key."
}

variable "key_name" {
  description = "The name for the SSH key pair in AWS."
  type        = string
}

variable "instance_name" {
  description = "The name tag for the EC2 instance."
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instance to create."
  type        = string
}

variable "vpc_name_filter" {
  description = "The name tag to filter the VPC data source."
  type        = string
}

variable "subnet_name_filter" {
  description = "The name tag to filter the subnet data source."
  type        = string
}

variable "sg_name_filter" {
  description = "The name to filter the security group data source."
  type        = string
}

variable "project_tag" {
  description = "The value for the Project tag."
  type        = string
}

variable "id_tag" {
  description = "The value for the ID tag."
  type        = string
} 