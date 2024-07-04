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

module "iam" {
  source = "./modules/iam"
  name_role_iam = var.name_role_iam
  aws_policy_integrate = var.aws_policy_integrate
}

module "ec2" {
  source         = "./modules/ec2"
  region         = var.region
  ami            = var.ami
  instance_type  = var.instance_type
  instance_name  = var.instance_name
  state_public_ip = var.state_public_ip
  subnet_id      = element(module.vpc.subnet_ids, 0)
  
  name_instance_profile = "ssm_instance_profile"
  vpc_security_group_ids = module.security.vpc_security_group_ids
}

module "security" {
  source = "./modules/security"
  vpc_id = module.vpc.vpc_id
  
   security_group_rules = [
    {
      type        = "ingress"
      protocol    = "tcp"
      from_port   = 443
      to_port     = 443
      source_security_group = true
    },
    {
      type        = "ingress"
      protocol    = "tcp"
      from_port   = 80
      to_port     = 80
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      type        = "ingress"
      protocol    = "tcp"
      from_port   = 22
      to_port     = 22
      cidr_blocks = ["10.219.230.10/32"]
    },
    {
      type        = "egress"
      protocol    = "tcp"
      from_port   = 3306
      to_port     = 3306
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      type        = "egress"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      type        = "egress"
      protocol    = "tcp"
      from_port   = 80
      to_port     = 80
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      type        = "egress"
      protocol    = "tcp"
      from_port   = 443
      to_port     = 443
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}
