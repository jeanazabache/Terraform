terraform {
  required_providers {
    aws = {
      source  = "hashicorp/AWS"
      version = "5.46.0"
    }
  }
}
provider "aws" {
  alias = "virginia"
  region = "us-east-1"  # Región de Virginia
}
################## VPC VIRGINIA ##################
resource "aws_vpc" "vpc_virginia" {
  provider = aws.virginia
  cidr_block = "10.0.0.0/16"
}

################## INTERNET GATEWAY ##################
resource "aws_internet_gateway" "internet_gateway_virginia" {
  provider = aws.virginia
  vpc_id = aws_vpc.vpc_virginia.id
  tags = {
    Name = "main_virginia" 
  }
}
################## SUBNET VIRGINIA ##################
resource "aws_subnet" "subnet_virginia" {
  provider = aws.virginia
  vpc_id            = aws_vpc.vpc_virginia.id
  cidr_block        = "10.0.0.0/16"
  availability_zone = "us-east-1a"
}
################## ROUTE TABLE ##################
resource "aws_route_table" "route_table_virginia_public" {
  vpc_id = aws_vpc.vpc_virginia.id
  tags = {
    Name = "route_table_oregon"
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

################## ROUTE TABLE WITH SUBNET ##################
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet_virginia.id
  route_table_id = aws_route_table.route_table_virginia_public.id
}

/* ################## MAIN ASSOCIATION ##################
resource "aws_main_route_table_association" "main" {
  vpc_id         = aws_vpc.vpc_virginia.id
  route_table_id = aws_route_table.route_table_virginia_public.id
} */


/* resource "aws_instance" "instance_virginia" {
  provider = aws.virginia
  ami             = "ami-051f8a213df8bc089"  # ID de la AMI de Ubuntu
  instance_type   = "t3.medium"
  associate_public_ip_address = true # IP Pública
  subnet_id       = aws_subnet.subnet_virginia.id
  key_name = "keypair_virginia"
} */

################################################################################################################################################



provider "aws" {
  alias = "oregon"
  region = "us-west-2"  # Región de Oregon
}

resource "aws_vpc" "vpc_oregon" {
  provider = aws.oregon
  cidr_block = "10.1.0.0/16"
}
resource "aws_internet_gateway" "internet_gateway_oregon" {
  provider = aws.oregon
  vpc_id = aws_vpc.vpc_oregon.id
  tags = {
      Name = "main_oregon"
  }
}
resource "aws_subnet" "subnet_oregon" {
  provider = aws.oregon
  vpc_id            = aws_vpc.vpc_oregon.id
  cidr_block        = "10.1.0.0/16"
  availability_zone = "us-west-2a"
}


resource "aws_route_table" "aws_route_table_oregon" {
  provider = aws.oregon
  vpc_id = aws_vpc.vpc_oregon.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway_oregon.id
  }
  route {
    cidr_block = "10.1.0.0/16"
    gateway_id = "local"
  }
}
/* resource "aws_instance" "instance_oregon" {
  provider = aws.oregon
  ami             = "ami-01175fe07368af8c6"  # ID de la AMI de Windows Server 2012
  instance_type   = "t3.medium"
  associate_public_ip_address = true # IP Pública
  subnet_id       = aws_subnet.subnet_oregon.id
  key_name = "keypair_oregon"
}
 */
/* # Peering connection
resource "aws_vpc_peering_connection" "vpc_peering" {
  vpc_id                 = aws_vpc.vpc_virginia.id
  peer_vpc_id            = aws_vpc.vpc_oregon.id
  auto_accept            = true
} */
