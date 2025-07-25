output "load_balancer_dns_name" {
  description = "DNS name of the Application Load Balancer."
  value       = aws_lb.main.dns_name
}

output "load_balancer_arn" {
  description = "ARN of the Application Load Balancer."
  value       = aws_lb.main.arn
}

output "load_balancer_zone_id" {
  description = "Hosted zone ID of the Application Load Balancer."
  value       = aws_lb.main.zone_id
}

output "target_group_arn" {
  description = "ARN of the Target Group."
  value       = aws_lb_target_group.main.arn
}

output "auto_scaling_group_arn" {
  description = "ARN of the Auto Scaling Group."
  value       = aws_autoscaling_group.main.arn
}

output "auto_scaling_group_name" {
  description = "Name of the Auto Scaling Group."
  value       = aws_autoscaling_group.main.name
}

output "launch_template_id" {
  description = "ID of the Launch Template."
  value       = aws_launch_template.main.id
}

output "launch_template_latest_version" {
  description = "Latest version of the Launch Template."
  value       = aws_launch_template.main.latest_version
}

# Show pre-existing resource information for reference
output "vpc_id" {
  description = "ID of the VPC."
  value       = data.aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets."
  value       = data.aws_subnets.public.ids
}

output "security_group_ids" {
  description = "IDs of the security groups used."
  value = {
    ec2_sg  = data.aws_security_group.ec2_sg.id
    http_sg = data.aws_security_group.http_sg.id
    lb_sg   = data.aws_security_group.lb_sg.id
  }
} 