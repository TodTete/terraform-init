###### MODULES ######

module "nginx_server_dev" {
    source = "./nginx_server_modules"

    ami_id = "ami-0440d3b780d96b29d"
    instance_type = "t3.medium"
    server_name = "nginx-server-dev"
    environment = "dev"
}