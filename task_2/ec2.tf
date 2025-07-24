resource "aws_instance" "main" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.main.key_name
  subnet_id     = data.aws_subnet.lab_public_subnet.id

  vpc_security_group_ids = [data.aws_security_group.lab_sg.id]

  tags = merge(
    local.common_tags,
    {
      Name = "cmtr-zdv1y551-ec2"
    }
  )
} 