####### SECURITY GROUP #######

resource "aws_security_group" "nginx_server_sg" {

  name        = "${var.server_name}-sg"
  description = "Security group allowing SSH and HTTP access to the nginx server"

  ingress {
    description = "SSH"

    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"

    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"

    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.server_name}-sg"
    Environment = var.environment
    Owner       = "TodTete"
    Team        = "DevOps"
    Project     = "Terraform Init"
  }
}