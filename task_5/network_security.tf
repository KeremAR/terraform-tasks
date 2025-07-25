# SSH Security Group
resource "aws_security_group" "ssh" {
  name   = var.ssh_sg_name
  vpc_id = var.vpc_id

  tags = {
    Project = var.project_tag
  }
}

# SSH Security Group Rules
resource "aws_security_group_rule" "ssh_ingress_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.allowed_ip_range
  security_group_id = aws_security_group.ssh.id
}

resource "aws_security_group_rule" "ssh_ingress_icmp" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = var.allowed_ip_range
  security_group_id = aws_security_group.ssh.id
}

# Public HTTP Security Group
resource "aws_security_group" "public_http" {
  name   = var.public_http_sg_name
  vpc_id = var.vpc_id

  tags = {
    Project = var.project_tag
  }
}

# Public HTTP Security Group Rules
resource "aws_security_group_rule" "public_http_ingress_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = var.allowed_ip_range
  security_group_id = aws_security_group.public_http.id
}

resource "aws_security_group_rule" "public_http_ingress_icmp" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = var.allowed_ip_range
  security_group_id = aws_security_group.public_http.id
}

# Private HTTP Security Group
resource "aws_security_group" "private_http" {
  name   = var.private_http_sg_name
  vpc_id = var.vpc_id

  tags = {
    Project = var.project_tag
  }
}

# Private HTTP Security Group Rules (using source_security_group_id)
resource "aws_security_group_rule" "private_http_ingress_http" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.public_http.id
  security_group_id        = aws_security_group.private_http.id
}

resource "aws_security_group_rule" "private_http_ingress_icmp" {
  type                     = "ingress"
  from_port                = -1
  to_port                  = -1
  protocol                 = "icmp"
  source_security_group_id = aws_security_group.public_http.id
  security_group_id        = aws_security_group.private_http.id
}

# Security Group Attachments for Public Instance
resource "aws_network_interface_sg_attachment" "public_ssh" {
  security_group_id    = aws_security_group.ssh.id
  network_interface_id = data.aws_instance.public.network_interface_id
}

resource "aws_network_interface_sg_attachment" "public_http" {
  security_group_id    = aws_security_group.public_http.id
  network_interface_id = data.aws_instance.public.network_interface_id
}

# Security Group Attachments for Private Instance
resource "aws_network_interface_sg_attachment" "private_ssh" {
  security_group_id    = aws_security_group.ssh.id
  network_interface_id = data.aws_instance.private.network_interface_id
}

resource "aws_network_interface_sg_attachment" "private_http" {
  security_group_id    = aws_security_group.private_http.id
  network_interface_id = data.aws_instance.private.network_interface_id
} 