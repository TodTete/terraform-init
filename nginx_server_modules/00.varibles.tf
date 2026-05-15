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
