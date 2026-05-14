####### PROVIDER #######
provider "aws" {
  region = "us-east-1"
}

####### RESOURCE #######
resource "aws_instance" "nginx-sever" {
  ami = "ami-0440d3b780d96b29d" //Image ID for Amazon Linux 2 in us-east-1
  instance_type  = "t3.micro"

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y nginx
              sudo systemctl enable nginx
              sudo systemctl start nginx
              EOF

  key_name = aws_key_pair.nginx-server-ssh.key_name # Reference to the key pair created below

  vpc_security_group_ids = [
    aws_security_group.nginx-server-sg.id # Reference to the security group created below
  ]
}

resource "aws_key_pair" "nginx-server-ssh" {
  key_name = "nginx-server-ssh"
  public_key = file("nginx-server.key.pub")
}

####### SECURE GROUPS #######
resource "aws_security_group" "nginx-server-sg"{
  name  = "nginx-server-sg"
  description = "Security group allowing SSH and HTTP access to the nginx server"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from anywhere (not recommended for production)
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }
}