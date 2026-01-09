resource "azurerm_virtual_network" "vnet01" {
  name                = "${var.vnetname}"
  address_space       = ["${var.vnet01_cidr_prefix}"]
  location            = azurerm_resource_group.Resourcegroup.location
  resource_group_name = azurerm_resource_group.Resourcegroup.name
}

resource "azurerm_subnet" "subnet01" {
  name                 = "${var.subnetname}"
  resource_group_name  = azurerm_resource_group.Resourcegroup.name
  virtual_network_name = azurerm_virtual_network.vnet01.name
  address_prefixes     = ["${var.subnet01_cidr_prefix}"]
}

resource "azurerm_network_interface" "nic-card" {
  name                = "${var.nic-interfacename}"
  location            = azurerm_resource_group.Resourcegroup.location
  resource_group_name = azurerm_resource_group.Resourcegroup.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet01.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.publicip01.id
    
  }
}

resource "azurerm_public_ip" "publicip01" {
  name                = "linux01TestPublicIp1"
  resource_group_name = azurerm_resource_group.Resourcegroup.name
  location            = azurerm_resource_group.Resourcegroup.location
  allocation_method   = "Static"
  }
resource "azurerm_network_security_group" "nsg01" {
  name                = "linux01SecurityGroup1"
  location            = azurerm_resource_group.Resourcegroup.location
  resource_group_name = azurerm_resource_group.Resourcegroup.name

  security_rule {
    name                       = "ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "nsg-assign" {
  network_interface_id      = azurerm_network_interface.nic-card.id
  network_security_group_id = azurerm_network_security_group.nsg01.id
}