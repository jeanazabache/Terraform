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
################## INTERNET GATEWAY ##################
resource "aws_internet_gateway" "internet_gateway_virginia" {
  vpc_id   = aws_vpc.vpc.id

  tags = {
    Name = "Internet_Gateway"
  }
}

################## SUBNET 1 PUBLIC ##################
resource "aws_subnet" "subnet_public_1" {
  provider          = aws.virginia
  vpc_id            = aws_vpc.vpc_virginia.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

################## SUBNET 2 PUBLIC ##################
resource "aws_subnet" "subnet_public_2" {
  provider          = aws.virginia
  vpc_id            = aws_vpc.vpc_virginia.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
} 
################## SUBNET 1 PRIVATE ##################
resource "aws_subnet" "subnet_private_1" {
  provider          = aws.virginia
  vpc_id            = aws_vpc.vpc_virginia.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1b"
}

################## SUBNET 2 PRIVATE ##################
resource "aws_subnet" "subnet_private_2" {
  provider          = aws.virginia
  vpc_id            = aws_vpc.vpc_virginia.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1b"
}
################## SUBNET 3 PRIVATE ##################
resource "aws_subnet" "subnet_private_3" {
  provider          = aws.virginia
  vpc_id            = aws_vpc.vpc_virginia.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "us-east-1b"
}
################## SUBNET 3 PRIVATE ##################
resource "aws_subnet" "subnet_public_4" {
  provider          = aws.virginia
  vpc_id            = aws_vpc.vpc_virginia.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = "us-east-1b"
}
