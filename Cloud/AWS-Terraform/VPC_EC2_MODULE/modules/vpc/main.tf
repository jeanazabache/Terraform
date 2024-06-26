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
