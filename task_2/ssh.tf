resource "aws_key_pair" "main" {
  key_name   = "cmtr-zdv1y551-keypair"
  public_key = var.ssh_key

  tags = local.common_tags
} 