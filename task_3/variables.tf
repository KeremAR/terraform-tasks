variable "aws_region" {
  description = "The AWS region to create resources in."
  type        = string
}

variable "bucket_name" {
  description = "The name of the S3 bucket."
  type        = string
}

variable "project_tag" {
  description = "The value for the Project tag."
  type        = string
} 