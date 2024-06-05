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
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id   = aws_vpc.vpc.id

  tags = {
    Name = "Internet_Gateway"
  }
}

################## SUBNET 1 PUBLIC ##################
resource "aws_subnet" "subnet_public_1" {
  provider          = aws.virginia
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

################## SUBNET 2 PUBLIC ##################
resource "aws_subnet" "subnet_public_2" {
  provider          = aws.virginia
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
} 
################## SUBNET 1 PRIVATE ##################
resource "aws_subnet" "subnet_private_1" {
  provider          = aws.virginia
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1a"
}

################## SUBNET 2 PRIVATE ##################
resource "aws_subnet" "subnet_private_2" {
  provider          = aws.virginia
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1b"
}
################## SUBNET 3 PRIVATE ##################
resource "aws_subnet" "subnet_private_3" {
  provider          = aws.virginia
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "us-east-1a"
}
################## SUBNET 3 PRIVATE ##################
resource "aws_subnet" "subnet_private_4" {
  provider          = aws.virginia
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = "us-east-1b"
}

################## ROUTE TABLE ##################
resource "aws_route_table" "route_table_virginia_public" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "Route_Table_Public"
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

################## ROUTE TABLE ##################
resource "aws_route_table" "route_table_virginia_privado" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "Route_Table_Private"
  }

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id
  }
}
################## MAIN ASSOCIATION ##################
resource "aws_main_route_table_association" "main" {
  provider       = aws.virginia
  vpc_id         = aws_vpc.vpc.id
  route_table_id = aws_route_table.route_table_virginia_public.id
}



################## ROUTE TABLE WITH SUBNET - 1 ##################
resource "aws_route_table_association" "rt-PUBLIC_1" {

  subnet_id = aws_subnet.subnet_public_1.id
  route_table_id = aws_route_table.route_table_virginia_public.id
}
################## ROUTE TABLE WITH SUBNET - 2 ##################
resource "aws_route_table_association" "rt-PUBLIC_2" {

  subnet_id = aws_subnet.subnet_public_2.id
  route_table_id = aws_route_table.route_table_virginia_public.id
}


################## ROUTE TABLE WITH SUBNET - 1 ##################
resource "aws_route_table_association" "rt-PRIVADO_1" {

  subnet_id = aws_subnet.subnet_private_1.id
  route_table_id = aws_route_table.route_table_virginia_privado.id
}
################## ROUTE TABLE WITH SUBNET - 1 ##################
resource "aws_route_table_association" "rt-PRIVADO_2" {

  subnet_id = aws_subnet.subnet_private_2.id
  route_table_id = aws_route_table.route_table_virginia_privado.id
}
################## ROUTE TABLE WITH SUBNET - 1 ##################
resource "aws_route_table_association" "rt-PRIVADO_3" {

  subnet_id = aws_subnet.subnet_private_3.id
  route_table_id = aws_route_table.route_table_virginia_privado.id
}
################## ROUTE TABLE WITH SUBNET - 1 ##################
resource "aws_route_table_association" "rt-PRIVADO_4" {

  subnet_id = aws_subnet.subnet_private_4.id
  route_table_id = aws_route_table.route_table_virginia_privado.id
}

resource "aws_eip" "elastic_ip" {
  domain   = "vpc"
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id     = aws_subnet.subnet_public_2.id

  tags = {
    Name = "NAT gateway"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.internet_gateway]
}

/* //  required subnets and their configurations
variable "required_subnets" {
  description = "list of subnets required"
  default     = ["public-1a", "private-1a", "public-1b", "private-1b"]
}

#create public and provate subnets
resource "aws_subnet" "subnets" {
  for_each          = toset(var.required_subnets)
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = lookup(var.subnet_conf[each.key], "cidr")
  availability_zone = lookup(var.subnet_conf[each.key], "availability_zone")

  # enable public ip addresses in public subnet
  map_public_ip_on_launch = false

  tags = {
    Name = each.key
  }
}

#assosiate public route table with public subnet
resource "aws_route_table_association" "public" {
  for_each       = {for name, subnet in aws_subnet.subnets: name => subnet if length(regexall("public-", name)) > 0}   

  subnet_id      = each.value.id
  route_table_id = aws_route_table.my_public_route_table.id
} */