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
  provider = aws.virginia
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

  route {
    cidr_block = "10.1.0.0/16"
    gateway_id = aws_vpc_peering_connection_accepter.accepter.id
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

#################################################### SEGUNDA REGION - OREGON  ###############################################

################## PROVIDER AWS OREGON ##################
provider "aws" {
  alias  = "oregon"
  region = "us-west-2" # Región de Oregon
}

################## VPC OREGON ##################
resource "aws_vpc" "vpc_oregon" {
  provider   = aws.oregon
  cidr_block = "10.1.0.0/16"
  tags = {
    Name = "VPC_Oregon"
  }
  # Enable DNS hostnames for the VPC
  enable_dns_hostnames = true
}

################## INTERNET GATEWAY ##################
resource "aws_internet_gateway" "internet_gateway_oregon" {
  provider = aws.oregon
  vpc_id   = aws_vpc.vpc_oregon.id
  tags = {
    Name = "Internet_Gataway_Oregon"
  }
}


################## SUBNET 1 OREGON ##################
resource "aws_subnet" "subnet_1_oregon" {
  provider          = aws.oregon
  vpc_id            = aws_vpc.vpc_oregon.id
  cidr_block        = "10.1.0.0/24"
  availability_zone = "us-west-2a"
}
################## SUBNET 2 OREGON ##################
resource "aws_subnet" "subnet_2_oregon" {
  provider          = aws.oregon
  vpc_id            = aws_vpc.vpc_oregon.id
  cidr_block        = "10.1.1.0/24"
  availability_zone = "us-west-2b"
}

################## SUBNET 3 OREGON ##################
resource "aws_subnet" "subnet_3_oregon" {
  provider          = aws.oregon
  vpc_id            = aws_vpc.vpc_oregon.id
  cidr_block        = "10.1.2.0/24"
  availability_zone = "us-west-2c"
}
################## ROUTE TABLE ##################
resource "aws_route_table" "route_table_oregon_public" {
  provider = aws.oregon
  vpc_id   = aws_vpc.vpc_oregon.id
  tags = {
    Name = "Route_table_Oregon"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway_oregon.id
  }
  route {
    cidr_block = "10.1.0.0/16"
    gateway_id = "local"
  }
  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = aws_vpc_peering_connection_accepter.accepter.id
  }
}

################## ROUTE 1 TABLE WITH SUBNET ##################
resource "aws_route_table_association" "oregon_rt_1" {
  provider       = aws.oregon
  subnet_id      = aws_subnet.subnet_1_oregon.id
  route_table_id = aws_route_table.route_table_oregon_public.id
}
################## ROUTE 2 TABLE WITH SUBNET ##################
resource "aws_route_table_association" "oregon_rt_2" {
  provider       = aws.oregon
  subnet_id      = aws_subnet.subnet_2_oregon.id
  route_table_id = aws_route_table.route_table_oregon_public.id
}
################## ROUTE 3 TABLE WITH SUBNET ##################
resource "aws_route_table_association" "oregon_rt_3" {
  provider       = aws.oregon
  subnet_id      = aws_subnet.subnet_3_oregon.id
  route_table_id = aws_route_table.route_table_oregon_public.id
}

################## MAIN ASSOCIATION ##################
resource "aws_main_route_table_association" "main_oregon" {
  provider       = aws.oregon
  vpc_id         = aws_vpc.vpc_oregon.id
  route_table_id = aws_route_table.route_table_oregon_public.id
}

################## GROUP SUBNETS RDS ##################
resource "aws_db_subnet_group" "gs-oregon" {
  provider = aws.oregon
  name     = "my-db-subnet-group"

  subnet_ids = [
    aws_subnet.subnet_1_oregon.id,
    aws_subnet.subnet_2_oregon.id,
    aws_subnet.subnet_3_oregon.id
  ]
}
