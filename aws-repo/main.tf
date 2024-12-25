provider "aws" {
  region = var.region
}

module "vpc" {
  source               = "git::https://github.com/jeanazabache/Modules.git//vpc"
  region               = var.region
  vpc_cidr_block       = var.vpc_cidr_block
  vpc_name             = var.vpc_name
  subnet_count_public  = var.subnet_count_public
  subnet_count_private = var.subnet_count_private
  subnets_cidr_public  = var.subnets_cidr_public
  subnets_cidr_private = var.subnets_cidr_private
  availability_zones   = var.availability_zones
}

module "iam" {
  source               = "git::git@github.com:jeanazabache/Modules.git//iam"
  name_role_iam        = var.name_role_iam
  aws_policy_integrate = var.aws_policy_integrate
}

module "ec2" {
  source                = "git::https://github.com/jeanazabache/Modules.git//ec2"
  region                = var.region
  ami                   = var.ami
  instance_type         = var.instance_type
  instance_name         = var.instance_name
  state_public_ip       = var.state_public_ip
  subnet_id             = element(module.vpc.subnet_ids_public, 1)
  name_instance_profile = "ssm_instance_profile"
}

