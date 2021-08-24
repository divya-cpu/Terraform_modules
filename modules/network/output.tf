output "network-id" {
  value = azurerm_virtual_network.this.id
}

output "subnet1-id" {
  value = azurerm_subnet.subnet1.id
}