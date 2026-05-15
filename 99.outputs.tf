####### OUTPUTS #######

output "server_public_ip" {
  description = "The public IP address of the nginx server"
  value       = aws_instance.nginx_server.public_ip
}

output "server_public_dns" {
  description = "The public DNS name of the nginx server"
  value       = aws_instance.nginx_server.public_dns
}