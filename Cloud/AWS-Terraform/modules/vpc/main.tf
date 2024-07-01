##################  PROVEDOR  ##################
provider "aws" {
  region = var.region
}

##################    VPC   ##################

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = var.vpc_name
  }
}


################## INTERNET GATEWAY ##################
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.main.id
}

################## SUBNETS PUBLIC ##################
resource "aws_subnet" "subnet_public" {
  count             = var.subnet_count_public
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.subnets_cidr_public, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = format("%s-subnet-public%02d", var.vpc_name, count.index + 1)
  }
}

################## SUBNETS PRIVATE ##################
resource "aws_subnet" "subnet_private" {
  count             = var.subnet_count_private
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.subnets_cidr_private, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = format("%s-subnet-private%02d", var.vpc_name, count.index + 1)
  }
}

################## ROUTE TABLE - PUBLIC ##################
resource "aws_route_table" "route_table_public" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "Route_Table_Public"
  }

  route {
    cidr_block = var.vpc_cidr_block
    gateway_id = "local"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
}

################## ROUTE TABLE - PRIVATE ##################
resource "aws_route_table" "route_table_private" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "Route_Table_Private"
  }

  route {
    cidr_block = var.vpc_cidr_block
    gateway_id = "local"
  }
}

################## MAIN ASSOCIATION ##################
resource "aws_main_route_table_association" "main" {
  vpc_id         = aws_vpc.main.id
  route_table_id = aws_route_table.route_table_public.id
}
