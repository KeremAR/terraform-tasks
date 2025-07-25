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

# Show discovered resource information
output "discovered_vpc_id" {
  description = "ID of the discovered VPC."
  value       = data.aws_vpc.discovered.id
}

output "discovered_vpc_cidr" {
  description = "CIDR block of the discovered VPC."
  value       = data.aws_vpc.discovered.cidr_block
}

output "discovered_subnet_id" {
  description = "ID of the discovered public subnet."
  value       = data.aws_subnet.discovered.id
}

output "discovered_subnet_cidr" {
  description = "CIDR block of the discovered public subnet."
  value       = data.aws_subnet.discovered.cidr_block
}

output "discovered_subnet_az" {
  description = "Availability zone of the discovered public subnet."
  value       = data.aws_subnet.discovered.availability_zone
}

output "discovered_security_group_id" {
  description = "ID of the discovered security group."
  value       = data.aws_security_group.discovered.id
}

output "discovered_ami_id" {
  description = "ID of the discovered AMI."
  value       = data.aws_ami.amazon_linux_2023.id
}

output "discovered_ami_name" {
  description = "Name of the discovered AMI."
  value       = data.aws_ami.amazon_linux_2023.name
} 