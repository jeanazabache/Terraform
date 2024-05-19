#################################################### Primera REGION - VIRGINIA  ###############################################

################## PROVIDER AWS VIRGINIA ##################
provider "aws" {
  alias  = "virginia"
  region = "us-east-1" # Región de Virginia
}

################## VPC VIRGINIA ##################
resource "aws_vpc" "vpc_virginia" {
  provider   = aws.virginia
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "VPC_Virginia"
  }
  # Enable DNS hostnames for the VPC
  enable_dns_hostnames = true
}

################## INTERNET GATEWAY ##################
resource "aws_internet_gateway" "internet_gateway_virginia" {
  provider = aws.virginia
  vpc_id   = aws_vpc.vpc_virginia.id
  tags = {
    Name = "Internet_Gateway"
  }
}
################## SUBNET 1 VIRGINIA ##################
resource "aws_subnet" "subnet_1_virginia" {
  provider          = aws.virginia
  vpc_id            = aws_vpc.vpc_virginia.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"
}

################## SUBNET 2 VIRGINIA ##################
resource "aws_subnet" "subnet_2_virginia" {
  provider          = aws.virginia
  vpc_id            = aws_vpc.vpc_virginia.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1b"
}
################## ROUTE TABLE ##################
resource "aws_route_table" "route_table_virginia_public" {
  vpc_id = aws_vpc.vpc_virginia.id
  tags = {
    Name = "Route_table_Virginia"
  }

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway_virginia.id
  }
}

################## ROUTE TABLE WITH SUBNET - 1 ##################
resource "aws_route_table_association" "virginia_rt_1" {
  subnet_id      = aws_subnet.subnet_1_virginia.id
  route_table_id = aws_route_table.route_table_virginia_public.id
}

################## ROUTE TABLE WITH SUBNET - 2 ##################
resource "aws_route_table_association" "virginia_rt_2" {
  subnet_id      = aws_subnet.subnet_2_virginia.id
  route_table_id = aws_route_table.route_table_virginia_public.id
}

################## MAIN ASSOCIATION ##################
resource "aws_main_route_table_association" "main_virginia" {
  provider       = aws.virginia
  vpc_id         = aws_vpc.vpc_virginia.id
  route_table_id = aws_route_table.route_table_virginia_public.id
}

################## SEGURITY GROUPS ##################
resource "aws_security_group" "ec2_sg" {
  provider = aws.virginia
  name     = "ec2-security-group"
  vpc_id   = aws_vpc.vpc_virginia.id

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "ec2-security-group"
  }
}