provider "aws" {
  region = var.region
}

module "vpc" {
  source             = "git::https://github.com/jeanazabache/Modules.git//vpc"
  region             = var.region
  cidr_block         = var.cidr_block
  vpc_name           = var.vpc_name
  subnet_count       = var.subnet_count
  subnet_cidrs       = var.subnet_cidrs
  probando
}

module "iam" {
  source               = "git::git@github.com:jeanazabache/Modules.git//iam"
  name_role_iam        = var.name_role_iam
  aws_policy_integrate = var.aws_policy_integrate
}

module "ec2" {
  source          = "git::https://github.com/jeanazabache/Modules.git//ec2"
  region          = var.region
  ami             = var.ami
  instance_type   = var.instance_type
  instance_name   = var.instance_name
  state_public_ip = var.state_public_ip
  subnet_id       = element(module.vpc.subnet_ids, 0)
  name_instance_profile = "ssm_instance_profile"
}

