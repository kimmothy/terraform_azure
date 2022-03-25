output "vnet_info" {
    value = azurerm_virtual_network.single_vnet
}

output "subnet_info" {
    value = azurerm_subnet.subnets
}