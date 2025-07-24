resource "aws_iam_group" "this" {
  name = var.iam_group_name
}

resource "aws_iam_policy" "this" {
  name = var.iam_policy_name
  policy = templatefile("${path.module}/policy.json", {
    bucket_name = var.s3_bucket_name
  })

  tags = {
    Project = var.project_tag
  }
}

resource "aws_iam_role" "this" {
  name = var.iam_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Project = var.project_tag
  }
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}

resource "aws_iam_instance_profile" "this" {
  name = var.iam_instance_profile_name
  role = aws_iam_role.this.name

  tags = {
    Project = var.project_tag
  }
} 