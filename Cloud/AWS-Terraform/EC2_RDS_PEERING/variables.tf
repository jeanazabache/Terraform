################################################################
#                       Global Variables
################################################################



################################################################
#                       EC2
################################################################

variable "instance_amis" {
  type = map(string)

  default = {
    "instance1" = "ami-04b70fa74e45c3917",
    "instance2" = "ami-01175fe07368af8c6"
  }
}

variable "keypairs" {
  type = map(string)

  default = {
    "keypair1" = "keypair-v",
    "keypair2" = "keypair-o"
  }
}

variable "name_instance" {
  type = map(string)
  default = {
    "name1" = "server-linux",
    "name2" = "server-windows"
  }
}
variable "windows_server_sg" {
  description = "Nombre de virtual machine windows"
  type = string
  default = "Segurity Group Instance"
}
variable "type_instance" {
  type = string
  description = "Tipo instancia de Web Server"
  default = "t3.medium"
}

################################################################
#                       RDS
################################################################
variable "password" {
  type = string
  description = "Password de Base de Datos"
  default = "password"
}

################################################################
#                       VPC
################################################################
variable "name_accepter_region" {
  type    = string
  default = "us-west-2"
}