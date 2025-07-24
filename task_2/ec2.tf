resource "aws_instance" "instance" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = data.aws_subnet.lab_public_subnet.id

  security_groups = [var.sg_name_filter]

  tags = {
    Name = var.instance_name
  }
} 