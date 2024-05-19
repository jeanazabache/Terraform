################################################################
#                       Global Variables
################################################################



################################################################
#                       EC2
################################################################
variable "instance_name" {
  description = "Nombre de instancia"
  type = string
}

variable "keypair_oregon" {
  description = "Nombre del keypair"
  type = string
}

variable "keypair_virginia" {
  description = "Nombre del keypair"
  type = string
}

variable "windows_server_sg" {
  description = "Nombre de virtual machine windows"
  type = string
}