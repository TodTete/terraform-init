###### TFSTATE ######

terraform {
    backend "s3" {
        bucket = "xxxxxx"
        key = "xxxxxx"
        region = "us-east-1"
    }
}

###### MODULES ######

module "nginx_server_dev" {
    source = "./nginx_server_modules"

    ami_id = "ami-0440d3b780d96b29d"
    instance_type = "t3.medium"
    server_name = "nginx-server-dev"
    environment = "dev"
}

module "nginx_server_qa" {
    source = "./nginx_server_modules"

    ami_id = "ami-0440d3b780d96b29d"
    instance_type = "t3.large"
    server_name = "nginx-server-qa"
    environment = "qa"
}

####### OUTPUTS #######

output "nginx_dev_ip" {
  description = "The public IP address of the nginx server"
  value       = module.nginx_server_dev.server_public_ip
}

output "nginx_dev_dns" {
  description = "The public DNS name of the nginx server"
  value       = module.nginx_server_dev.server_public_dns
}

output "nginx_qa_ip" {
  description = "The public IP address of the nginx server"
  value       = module.nginx_server_qa.server_public_ip
}

output "nginx_qa_dns" {
  description = "The public DNS name of the nginx server"
  value       = module.nginx_server_qa.server_public_dns
}

###### IMPORT ######

resource "aws_instance" "nginx_server_dev" {
  # This resource block is intentionally left empty for import
}