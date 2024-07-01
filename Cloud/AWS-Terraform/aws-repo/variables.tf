variable "region" {
  description = "The AWS region to use"
  type        = string
}

variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "subnet_count" {
  description = "Number of subnets to create"
  type        = number
}

variable "subnet_cidrs" {
  description = "List of CIDR blocks for the subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones for the subnets"
  type        = list(string)
}

variable "ami" {
  description = "The AMI to use for the instance"
  type        = string
}

variable "instance_type" {
  description = "The instance type"
  type        = string
}

variable "instance_name" {
  description = "The name of the instance"
  type        = string
}

######## IAM ####
variable "name_role_iam" {
  description = "Nombre del rol IAM"
  type = string
}

variable "aws_policy_integrate" {
  description = "Nombre de la politica integrada de AWS"
  type = string
}

variable "state_public_ip" {
  description = "Estado de ip publica"
  type = bool
}