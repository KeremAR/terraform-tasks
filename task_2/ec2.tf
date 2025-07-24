resource "aws_instance" "main" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_type
  key_name      = local.key_name
  subnet_id     = data.aws_subnet.lab_public_subnet.id
  
  vpc_security_group_ids = [data.aws_security_group.lab_sg.id]

  tags = merge(
    local.common_tags,
    {
      Name = local.instance_name
    }
  )
} 