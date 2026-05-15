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