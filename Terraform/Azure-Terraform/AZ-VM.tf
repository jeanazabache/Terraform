# Configuración del proveedor de Azure
provider "azurerm" {
  features {}
}

# Declaración de variables
variable "resource_group_name" {
  default = "rg-myresource-jean-01"
}
#VARIABLES DE LOCACIÓN
variable "location-1" {
  default = "East US"
}

variable "location-2" {
  default = "Central US"
}

#VARIABLE DE VNET's
variable "vnet-1" {
  default = "my-vnet1"
}

variable "vnet-2" {
  default = "my-vnet2"
}

variable "vnet-3" {
  default = "my-vnet3"
}
#VARIABLES DE SUBNET's
variable "subnet-1" {
  default = "my-subnet-1-east"
}

variable "subnet-2" {
  default = "my-subnet-2-east"
}

variable "subnet-3" {
  default = "my-subnet-3-cenrtral"
}

/* # Creación del grupo de recursos
resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location-1
}
 */

# Creación de la red virtual 1
resource "azurerm_virtual_network" "vnet1" {
  name                = var.vnet-1
  address_space       = ["10.50.0.0/22"]
  location            = var.location-1
  resource_group_name = var.resource_group_name
}

# Creación de la subred 1 en la VNet 1
resource "azurerm_subnet" "subnet1" {
  name                 = var.subnet-1
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.50.1.0/24"]
}

# Creación de la máquina virtual 1

# Creación de la máquina virtual 1 con Windows Server
resource "azurerm_windows_virtual_machine" "vm1" {
  name                = "vm1"
  location            = var.location-1
  resource_group_name = var.resource_group_name
  size                = "Standard_DS1_v2"
  admin_username      = "adminuser"
  admin_password      = "Password1234!"

  network_interface_ids = [azurerm_network_interface.nic1.id]

    os_disk {
    name              = "osdisk1"
    caching           = "ReadWrite"
    disk_size_gb      = 128
    storage_account_type = "Standard_LRS"
  }


    source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

# Creación del adaptador de red 1 para la máquina virtual 1
resource "azurerm_network_interface" "nic1" {
  name                      = "nic1"
  location                  = var.location-1
  resource_group_name       = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet2.id
    private_ip_address_allocation = "Dynamic"
  }
}
# Creación de la red virtual 2
resource "azurerm_virtual_network" "vnet2" {
  name                = var.vnet-2
  address_space       = ["10.51.0.0/22"]
  location            = var.location-1
  resource_group_name = var.resource_group_name
}
# Creación de la subred 2 en la VNet 2
resource "azurerm_subnet" "subnet2" {
  name                 = var.subnet-2
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet2.name
  address_prefixes     = ["10.51.1.0/24"]
}
# Creación de la máquina virtual 2 con Windows Server
resource "azurerm_windows_virtual_machine" "vm2" {
  name                = "vm2"
  location            = var.location-1
  resource_group_name = var.resource_group_name
  size                = "Standard_DS1_v2"
  admin_username      = "adminuser"
  admin_password      = "Password1234!"

  network_interface_ids = [azurerm_network_interface.nic2.id]

    os_disk {
    name              = "osdisk2"
    caching           = "ReadWrite"
    disk_size_gb      = 128
    storage_account_type = "Standard_LRS"
  }


    source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}


# Creación del adaptador de red 2 para la máquina virtual 2
resource "azurerm_network_interface" "nic2" {
  name                      = "nic2"
  location                  = var.location-1
  resource_group_name       = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet2.id
    private_ip_address_allocation = "Dynamic"
  }
}
