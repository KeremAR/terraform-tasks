# EC2 instance using remote state outputs
resource "aws_instance" "main" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_type

  # Use public subnet from remote state
  subnet_id = data.terraform_remote_state.base_infra.outputs.public_subnet_id

  # Use security group from remote state
  vpc_security_group_ids = [data.terraform_remote_state.base_infra.outputs.security_group_id]

  # Enable auto-assign public IP for public subnet
  associate_public_ip_address = true

  tags = {
    Name      = var.instance_name
    Terraform = "true"
    Project   = var.project_id
  }
} 