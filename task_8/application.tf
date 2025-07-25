# User data script for web server setup and metadata display
locals {
  user_data = base64encode(<<-EOF
#!/bin/bash
# Update system packages
yum update -y

# Install necessary utilities
yum install -y httpd aws-cli jq

# Enable and start web server
systemctl enable httpd
systemctl start httpd

# Get IMDSv2 token for metadata access
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

# Retrieve instance metadata using IMDSv2
INSTANCE_ID=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-id)
PRIVATE_IP=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/local-ipv4)

# Create HTML page with instance information
cat <<HTML > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
    <title>Instance Information</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .info { background-color: #f0f0f0; padding: 20px; border-radius: 8px; }
        h1 { color: #333; }
    </style>
</head>
<body>
    <h1>AWS EC2 Instance Information</h1>
    <div class="info">
        <p><strong>This message was generated on instance $INSTANCE_ID with the following IP: $PRIVATE_IP</strong></p>
        <p>Generated at: $(date)</p>
        <p>Server: $(hostname)</p>
    </div>
</body>
</html>
HTML

# Set proper permissions
chown apache:apache /var/www/html/index.html
chmod 644 /var/www/html/index.html

# Restart httpd to ensure everything is working
systemctl restart httpd
EOF
  )
}

# Launch Template
resource "aws_launch_template" "main" {
  name_prefix   = "${var.launch_template_name}-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = data.aws_key_pair.main.key_name

  vpc_security_group_ids = [
    data.aws_security_group.ec2_sg.id,
    data.aws_security_group.http_sg.id
  ]

  iam_instance_profile {
    name = data.aws_iam_instance_profile.main.name
  }

  network_interfaces {
    delete_on_termination = true
    device_index          = 0
    security_groups = [
      data.aws_security_group.ec2_sg.id,
      data.aws_security_group.http_sg.id
    ]
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "optional"
  }

  user_data = local.user_data

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name      = "${var.project_id}-instance"
      Terraform = "true"
      Project   = var.project_id
    }
  }

  tags = {
    Name      = var.launch_template_name
    Terraform = "true"
    Project   = var.project_id
  }
}

# Target Group for Load Balancer
resource "aws_lb_target_group" "main" {
  name     = var.target_group_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.main.id

  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = "/"
    matcher             = "200"
    port                = "traffic-port"
    protocol            = "HTTP"
  }

  tags = {
    Name      = var.target_group_name
    Terraform = "true"
    Project   = var.project_id
  }
}

# Application Load Balancer
resource "aws_lb" "main" {
  name               = var.load_balancer_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_security_group.lb_sg.id]
  subnets            = data.aws_subnets.public.ids

  enable_deletion_protection = false

  tags = {
    Name      = var.load_balancer_name
    Terraform = "true"
    Project   = var.project_id
  }
}

# Load Balancer Listener
resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }

  tags = {
    Terraform = "true"
    Project   = var.project_id
  }
}

# Auto Scaling Group
resource "aws_autoscaling_group" "main" {
  name                      = var.asg_name
  vpc_zone_identifier       = data.aws_subnets.public.ids
  target_group_arns         = [aws_lb_target_group.main.arn]
  health_check_type         = "ELB"
  health_check_grace_period = 300

  min_size         = var.asg_min_size
  max_size         = var.asg_max_size
  desired_capacity = var.asg_desired_capacity

  launch_template {
    id      = aws_launch_template.main.id
    version = "$Latest"
  }

  lifecycle {
    ignore_changes = [load_balancers, target_group_arns]
  }

  tag {
    key                 = "Name"
    value               = var.asg_name
    propagate_at_launch = false
  }

  tag {
    key                 = "Terraform"
    value               = "true"
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = var.project_id
    propagate_at_launch = true
  }
}

# Auto Scaling Attachment (explicit attachment for better management)
resource "aws_autoscaling_attachment" "main" {
  autoscaling_group_name = aws_autoscaling_group.main.id
  lb_target_group_arn    = aws_lb_target_group.main.arn
} 