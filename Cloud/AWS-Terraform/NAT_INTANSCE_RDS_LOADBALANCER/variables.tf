################################################################
#                       EC2
################################################################

variable "instance_amis" {
  type = map(string)

  default = {
    "instance-nat" = "ami-00beae93a2d981137"
    "instance-server" = "ami-04b70fa74e45c3917"
  }
}

variable "keypairs" {
  type = map(string)

  default = {
    "keypair1" = "keypair-v"
  }
}

variable "name_instance" {
  type = map(string)
  default = {
    "name1" = "nat-instance",
    "name2" = "server-instance-1",
    "name3" = "server-instance-2"
  }
}
variable "windows_server_sg" {
  description = "Nombre de Grupo de Seguridad"
  type = string
  default = "Segurity Group Instance"
}
variable "type_instance" {
  description = "Tipo instancia de Web Server"
  type = string 
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