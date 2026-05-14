####### PROVIDER #######
provider "aws" {
  region = "us-east-1"
}

####### RESOURCE #######
resource "aws_instance" "nginx-sever" {
  ami = "ami-0440d3b780d96b29d" //Image ID for Amazon Linux 2 in us-east-1
  instance_type  = "t3.micro"
}
