resource "aws_key_pair" "cmtr-zdv1y551-keypair" {
  key_name   = var.key_name
  public_key = var.ssh_key

  tags = local.common_tags
} 