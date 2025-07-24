resource "aws_instance" "cmtr-zdv1y551-ec2" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.cmtr-zdv1y551-keypair.key_name
  subnet_id     = data.aws_subnet.lab_public_subnet.id

  vpc_security_group_ids = [data.aws_security_group.lab_sg.id]

  tags = merge(
    local.common_tags,
    {
      Name = var.instance_name
    }
  )
} 