################## PROVIDER AWS VIRGINIA ##################
provider "aws" {
  alias  = "virginia"
  region = "us-east-1" # Región de Virginia
}

################## PROVIDER AWS OREGON ##################
provider "aws" {
  alias  = "oregon"
  region = "us-west-2" # Región de Virginia
}


################## VPC VIRGINIA ##################
resource "aws_vpc" "vpc_v" {
  provider = aws.virginia
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "VPC_Virginia"
  }
  # Enable DNS hostnames for the VPC
  enable_dns_hostnames = true
}

################## VPC OREGON ##################
resource "aws_vpc" "vpc_o" {
  provider = aws.oregon
  cidr_block = "10.1.0.0/16"

  tags = {
    Name = "VPC_Virginia"
  }
  # Enable DNS hostnames for the VPC
  enable_dns_hostnames = true
}


################## SUBNET 1 PUBLIC ##################
resource "aws_subnet" "subnet_public_v" {
  provider          = aws.virginia
  vpc_id            = aws_vpc.vpc_v.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

################## SUBNET 2 PUBLIC ##################
resource "aws_subnet" "subnet_public_o" {
  provider          = aws.oregon
  vpc_id            = aws_vpc.vpc_o.id
  cidr_block        = "10.1.1.0/24"
  availability_zone = "us-west-2b"
}

################## ROUTE TABLE ##################
resource "aws_route_table" "route_table_v" {
  provider = aws.virginia
  vpc_id = aws_vpc.vpc_v.id

  tags = {
    Name = "Route_Table"
  }

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway_v.id
  }
}


################## ROUTE TABLE ##################
resource "aws_route_table" "route_table_o" {
  provider = aws.oregon
  vpc_id = aws_vpc.vpc_o.id

  tags = {
    Name = "Route_Table"
  }

  route {
    cidr_block = "10.1.0.0/16"
    gateway_id = "local"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway_o.id
  }
}

################## MAIN ASSOCIATION ##################
resource "aws_main_route_table_association" "main_v" {
  provider       = aws.virginia
  vpc_id         = aws_vpc.vpc_v.id
  route_table_id = aws_route_table.route_table_v.id
}

################## MAIN ASSOCIATION ##################
resource "aws_main_route_table_association" "main_o" {
  provider       = aws.oregon
  vpc_id         = aws_vpc.vpc_o.id
  route_table_id = aws_route_table.route_table_o.id
}

################## INTERNET GATEWAY ##################
resource "aws_internet_gateway" "internet_gateway_v" {
  provider = aws.virginia
  vpc_id   = aws_vpc.vpc_v.id
  tags = {
    Name = "Internet_Gataway"
  }
}

################## INTERNET GATEWAY ##################
resource "aws_internet_gateway" "internet_gateway_o" {
  provider = aws.oregon
  vpc_id   = aws_vpc.vpc_o.id
  tags = {
    Name = "Internet_Gataway"
  }
}

