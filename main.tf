####### VARIABLES #######

variable "ami_id" {
  description = "ID of the Amazon Machine Image (AMI) to use for the EC2 instance"
  default     = "ami-0440d3b780d96b29d"
}

variable "instance_type" {
  description = "Type of EC2 instance to create"
  default     = "t3.micro"
}

variable "server_name" {
  description = "Name tag for the EC2 instance"
  default     = "nginx-server"
}

variable "environment" {
  description = "Environment tag for the EC2 instance"
  default     = "test"
}

####### PROVIDER #######

provider "aws" {
  region = "us-east-1"
}

####### EC2 INSTANCE #######

resource "aws_instance" "nginx_server" {

  ami           = var.ami_id
  instance_type = var.instance_type

  user_data = <<-EOF
              #!/bin/bash
              dnf update -y
              dnf install -y nginx
              systemctl enable nginx
              systemctl start nginx
              EOF

  key_name = aws_key_pair.nginx_server_ssh.key_name

  vpc_security_group_ids = [
    aws_security_group.nginx_server_sg.id
  ]

  tags = {
    Name        = var.server_name
    Environment = var.environment
    Owner       = "TodTete"
    Team        = "DevOps"
    Project     = "Terraform Init"
  }
}

####### SSH KEY #######
# Generate key:
# ssh-keygen -t rsa -b 2048 -f "nginx-server.key"

resource "aws_key_pair" "nginx_server_ssh" {

  key_name   = "${var.server_name}-ssh"
  public_key = file("${var.server_name}.key.pub")

  tags = {
    Name        = "${var.server_name}-ssh"
    Environment = var.environment
    Owner       = "TodTete"
    Team        = "DevOps"
    Project     = "Terraform Init"
  }
}

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

####### OUTPUTS #######

output "server_public_ip" {
  description = "The public IP address of the nginx server"
  value       = aws_instance.nginx_server.public_ip
}

output "server_public_dns" {
  description = "The public DNS name of the nginx server"
  value       = aws_instance.nginx_server.public_dns
}