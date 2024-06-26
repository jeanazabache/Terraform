provider "aws" {
  region = var.region
}

resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "main" {
  count = var.subnet_count
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.subnet_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = format("%s-subnet-%02d", var.vpc_name, count.index + 1)
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.main.id
}

################## ROUTE TABLE ##################
resource "aws_route_table" "route_table_public" {
  vpc_id = aws_vpc.main.id
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

################## MAIN ASSOCIATION ##################
resource "aws_main_route_table_association" "main" {
  vpc_id         = aws_vpc.main.id
  route_table_id = aws_route_table.route_table_public.id
}
