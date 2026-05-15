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
