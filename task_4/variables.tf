variable "aws_region" {
  description = "The AWS region to create resources in."
  type        = string
}

variable "project_tag" {
  description = "The value for the Project tag."
  type        = string
}

variable "iam_group_name" {
  description = "The name of the IAM group."
  type        = string
}

variable "iam_policy_name" {
  description = "The name of the IAM policy."
  type        = string
}

variable "iam_role_name" {
  description = "The name of the IAM role."
  type        = string
}

variable "iam_instance_profile_name" {
  description = "The name of the IAM instance profile."
  type        = string
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket to grant access to."
  type        = string
} 