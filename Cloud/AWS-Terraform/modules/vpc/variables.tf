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

variable "subnet_cidrs" {
  description = "List of CIDR blocks for the subnets"
  type        = list(string)
}

variable "subnets_cidr_public" {
  description = "Lista de cidrs para subnets publicos"
  type        = list(string)
}

variable "subnets_cidr_private" {
  description = "Lista de cidrs para subnets publicos"
  type        = list(string)
}