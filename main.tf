terraform {
    required_version = ">=1.1.2"
}

provider "azurerm" {
    features {

    }
}

resource "azurerm_resource_group" "rg_chan_kuber" {
    name = "rg-chan-kuber"
    location = "koreacentral"
}

module "network" {
    source = "./network/single_vnet"
    rg_name = azurerm_resource_group.rg_chan_kuber.name
    identifier = "chan-kuber"
    environment = "test"
    location = "koreacentral"
    vnet_cidr = "10.0.0.0/24"
    subnet_list = ["APP", "Bastion"]

}