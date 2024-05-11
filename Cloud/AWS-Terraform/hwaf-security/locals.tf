locals {
  tags = {
    "Project" : "hwaf",
    "ENV" : "${var.env}",
    "Servicio_NBZ" : "hwaf",
    "Gerencia" : "SSN",
    "Ambiente" : "${var.env}",
    "PCI" : "No",
    "Vigencia" : "Indefinida",
  }
}