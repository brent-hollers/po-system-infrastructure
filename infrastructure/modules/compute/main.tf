# IAM Role for EC2
resource "aws_iam_role" "ec2" {
  name = "${var.project_name}-ec2-role"

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
    Name = "${var.project_name}-ec2-role"
  }
}

# SSM — allows shell access without SSH keys
resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# CloudWatch agent
resource "aws_iam_role_policy_attachment" "cloudwatch" {
  role       = aws_iam_role.ec2.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# Inline policy — publish custom n8n metrics to CloudWatch
resource "aws_iam_role_policy" "ec2_cloudwatch" {
  name = "${var.project_name}-ec2-cloudwatch"
  role = aws_iam_role.ec2.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "CloudWatchMetrics"
        Effect   = "Allow"
        Action   = ["cloudwatch:PutMetricData"]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "ec2" {
  name = "${var.project_name}-ec2-profile"
  role = aws_iam_role.ec2.name

  tags = {
    Name = "${var.project_name}-ec2-profile"
  }
}

# Latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# EC2 Instance — n8n in private subnet
resource "aws_instance" "n8n" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  iam_instance_profile   = aws_iam_instance_profile.ec2.name

  # Persistent root volume so n8n data survives reboots
  root_block_device {
    volume_type           = "gp3"
    volume_size           = 20
    delete_on_termination = false

    tags = {
      Name = "${var.project_name}-n8n-volume"
    }
  }

  user_data = <<-EOF
    #!/bin/bash
    yum update -y

    # Install and start Docker
    amazon-linux-extras install docker -y
    systemctl start docker
    systemctl enable docker
    usermod -a -G docker ec2-user

    # Create persistent volume for n8n data
    mkdir -p /home/ec2-user/.n8n
    chown 1000:1000 /home/ec2-user/.n8n

    # Run n8n
    docker run -d \
      --name n8n \
      -p 5678:5678 \
      -v /home/ec2-user/.n8n:/home/node/.n8n \
      -e N8N_PROTOCOL=https \
      -e N8N_HOST=${var.n8n_domain} \
      -e WEBHOOK_URL=https://${var.n8n_domain} \
      -e N8N_EDITOR_BASE_URL=https://${var.n8n_domain} \
      --restart unless-stopped \
      n8nio/n8n
    EOF

  tags = {
    Name = "${var.project_name}-n8n-server"
  }
}
