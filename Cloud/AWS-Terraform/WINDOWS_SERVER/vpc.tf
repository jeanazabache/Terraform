################## PROVIDER AWS VIRGINIA ##################
provider "aws" {
  alias  = "virginia"
  region = "us-east-1" # Región de Virginia
}

################## VPC VIRGINIA ##################
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "VPC_Virginia"
  }
  # Enable DNS hostnames for the VPC
  enable_dns_hostnames = true
}

################## SUBNET 1 PUBLIC ##################
resource "aws_subnet" "subnet_public_1" {
  provider          = aws.virginia
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

################## ROUTE TABLE ##################
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "Route_Table"
  }

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
}

################## MAIN ASSOCIATION ##################
resource "aws_main_route_table_association" "main" {
  provider       = aws.virginia
  vpc_id         = aws_vpc.vpc.id
  route_table_id = aws_route_table.route_table.id
}

################## INTERNET GATEWAY ##################
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id   = aws_vpc.vpc.id
  tags = {
    Name = "Internet_Gataway"
  }
}

