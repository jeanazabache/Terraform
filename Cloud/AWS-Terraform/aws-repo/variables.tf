################## VPC ##################
variable "region" {
  description = "The AWS region to create the VPC in"
  type        = string
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "subnet_count_public" {
  description = "Number of subnets to create"
  type        = number
}

variable "subnet_count_private" {
  description = "Number of subnets to create"
  type        = number
}

variable "availability_zones" {
  description = "List of availability zones for the subnets"
  type        = list(string)
}

variable "subnets_cidr_public" {
  description = "List of CIDR blocks for the subnets"
  type        = list(string)
}

variable "subnets_cidr_private" {
  description = "Lista de cidrs para subnets publicos"
  type        = list(string)
}





################ IAM ####################
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

################ EC2 ####################

variable "instance_name" {
  description = "Nombre de la Instancia"
  type = string
}
variable "ami" {
  description = "Codigo de AMI"
  type = string
}
variable "instance_type" {
  description = "Tipo de instancia CPU"
  type = string
}