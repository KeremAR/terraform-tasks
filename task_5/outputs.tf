output "ssh_security_group_id" {
  description = "The ID of the SSH security group."
  value       = aws_security_group.ssh.id
}

output "public_http_security_group_id" {
  description = "The ID of the public HTTP security group."
  value       = aws_security_group.public_http.id
}

output "private_http_security_group_id" {
  description = "The ID of the private HTTP security group."
  value       = aws_security_group.private_http.id
}

output "ssh_security_group_name" {
  description = "The name of the SSH security group."
  value       = aws_security_group.ssh.name
}

output "public_http_security_group_name" {
  description = "The name of the public HTTP security group."
  value       = aws_security_group.public_http.name
}

output "private_http_security_group_name" {
  description = "The name of the private HTTP security group."
  value       = aws_security_group.private_http.name
} 