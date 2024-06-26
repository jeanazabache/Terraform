variable "region" {
  description = "The AWS region to create the EC2 instance in"
  type        = string
}

variable "ami" {
  description = "The AMI to use for the instance"
  type        = string
}

variable "instance_type" {
  description = "The instance type"
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID to launch the instance in"
  type        = string
}

variable "instance_name" {
  description = "The name of the instance"
  type        = string
}

variable "key_name" {
  description = "Nombre de la keypair"
  type = string
}