# EC2 instance using discovered resources
resource "aws_instance" "main" {
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = var.instance_type
  subnet_id              = data.aws_subnet.discovered.id
  vpc_security_group_ids = [data.aws_security_group.discovered.id]

  # Enable auto-assign public IP for public subnet
  associate_public_ip_address = true

  tags = {
    Name    = var.instance_name
    Project = var.project_id
  }
} 