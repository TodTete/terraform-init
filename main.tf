###### MODULES ######

module "nginx_server_dev" {
    source = "./nginx_server_modules"

    ami_id = "ami-0440d3b780d96b29d"
    instance_type = "t3.medium"
    server_name = "nginx-server-dev"
    environment = "dev"
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