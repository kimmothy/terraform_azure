resource "azurerm_virtual_network" "single_vnet" {
    name                = "vnet-${var.identifier}-${var.environment}"
    resource_group_name = var.rg_name
    location            = var.location
    address_space       = [var.vnet_cidr]

    tags = var.tags
}

#vnet-lg-groupware-prod
resource "azurerm_subnet" "subnets" {
    count                = length(var.subnet_list)
    name                 = "${var.subnet_list[count.index]}Subnet"
    resource_group_name  = var.rg_name
    virtual_network_name = azurerm_virtual_network.single_vnet.name
    address_prefixes     = [cidrsubnet(var.vnet_cidr, 4, count.index)]
}


resource "azurerm_virtual_network_peering" "peer_from_here" {
    count                     = length(var.vnet_peering_list)
    name                      = "peer-${azurerm_virtual_network.single_vnet.name}-to-${var.vnet_peering_list[count.index]["name"]}"
    resource_group_name       = var.rg_name
    virtual_network_name      = azurerm_virtual_network.single_vnet.name
    remote_virtual_network_id = var.vnet_peering_list[count.index]["id"]
    allow_forwarded_traffic   = true
}


resource "azurerm_virtual_network_peering" "peer_from_there" {
    count                     = length(var.vnet_peering_list)
    name                      = "peer-${var.vnet_peering_list[count.index]["name"]}-to-${azurerm_virtual_network.single_vnet.name}"
    resource_group_name       = var.vnet_peering_list[count.index]["resource_group_name"]
    virtual_network_name      = var.vnet_peering_list[count.index]["name"]
    remote_virtual_network_id = azurerm_virtual_network.single_vnet.id
    allow_forwarded_traffic   = true
}

