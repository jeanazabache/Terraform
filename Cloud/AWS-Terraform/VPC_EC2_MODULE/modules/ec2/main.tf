provider "aws" {
  region = var.region
}

resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  associate_public_ip_address = var.state_public_ip
  iam_instance_profile = var.name_instance_profile

  tags = {
    Name = var.instance_name
  }
}
