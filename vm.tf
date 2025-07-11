resource "azurerm_linux_virtual_machine" "vm01" {
  name                = "${var.vmname01}"
  resource_group_name = azurerm_resource_group.Resourcegroup.name
  location            = azurerm_resource_group.Resourcegroup.location
  disable_password_authentication  = false
  #public_ip_address            = true
  size                = "Standard_F2"
  admin_username      = "msradmin"
  admin_password      = "msrCosmos12#"
  network_interface_ids = [
    azurerm_network_interface.nic-card.id,
  ]

 

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}