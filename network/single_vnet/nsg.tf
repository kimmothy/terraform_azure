
resource "azurerm_network_security_group" "nsgs" {
    count               = length(var.subnet_list)
    name                = "nsg-${var.identifier}-${var.environment}-${var.subnet_list[count.index]}"
    location            = var.location
    resource_group_name = var.rg_name

}

resource "azurerm_subnet_network_security_group_association" "nsg_asso_nipa_barn_app" {
    count                     = length(var.subnet_list)
    subnet_id                 = azurerm_subnet.subnets[count.index].id
    network_security_group_id = azurerm_network_security_group.nsgs[count.index].id
}


