output "vnet_info" {
    value = [var.rg_name, azurerm_virtual_network.single_vnet.id, azurerm_virtual_network.single_vnet.name, var.identifier]
}