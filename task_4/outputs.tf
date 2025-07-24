output "iam_group_name" {
  description = "The name of the created IAM group."
  value       = aws_iam_group.this.name
}

output "iam_policy_arn" {
  description = "The ARN of the created IAM policy."
  value       = aws_iam_policy.this.arn
}

output "iam_role_name" {
  description = "The name of the created IAM role."
  value       = aws_iam_role.this.name
}

output "iam_instance_profile_name" {
  description = "The name of the created IAM instance profile."
  value       = aws_iam_instance_profile.this.name
} 