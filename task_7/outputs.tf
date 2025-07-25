output "instance_id" {
  description = "The ID of the EC2 instance."
  value       = aws_instance.main.id
}

output "instance_public_ip" {
  description = "The public IP address of the EC2 instance."
  value       = aws_instance.main.public_ip
}

output "instance_private_ip" {
  description = "The private IP address of the EC2 instance."
  value       = aws_instance.main.private_ip
}

# Show remote state outputs for reference
output "remote_vpc_id" {
  description = "VPC ID from remote state."
  value       = data.terraform_remote_state.base_infra.outputs.vpc_id
}

output "remote_public_subnet_id" {
  description = "Public subnet ID from remote state."
  value       = data.terraform_remote_state.base_infra.outputs.public_subnet_id
}

output "remote_security_group_id" {
  description = "Security group ID from remote state."
  value       = data.terraform_remote_state.base_infra.outputs.security_group_id
} 