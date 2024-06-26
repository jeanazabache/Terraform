provider "aws" {
  region = var.region
}

module "vpc" {
  source           = "./modules/vpc"
  region           = var.region
  cidr_block       = var.cidr_block
  vpc_name         = var.vpc_name
  subnet_count     = var.subnet_count
  subnet_cidrs     = var.subnet_cidrs
  availability_zones = var.availability_zones
}

module "ec2" {
  source         = "./modules/ec2"
  region         = var.region
  ami            = var.ami
  instance_type  = var.instance_type
  subnet_id      = element(module.vpc.subnet_ids, 0)
  instance_name  = var.instance_name
  key_name = var.key_name
}
