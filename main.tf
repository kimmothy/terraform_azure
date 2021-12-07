terraform{
    required_version = "v1.0.1"
}

provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "rg_hub" {
    name = "rg-hub"
    location = "southeastasia"
}

resource "azurerm_resource_group" "rg_comp1" {
    name = "rg-comp1"
    location = "southeastasia"
}

resource "azurerm_resource_group" "rg_comp2" {
    name = "rg-comp2"
    location = "southeastasia"
}

resource "azurerm_resource_group"  "rg_partne3"{
    name = "rg-comp3"
    location = "southeastasia"
}

module "shared_vnet" {
    source = "./network/single_vnet"
    rg_name = "rg-hub"
    identifier = "lz"
    environment = "shared"
    location = "southeastasia"
    vnet_cidr = "10.0.0.0/16"
    subnet_list = ["Bastion", "AGW"]
}

module "comp1_dev_vnet" {
    source = "./network/single_vnet"
    rg_name = "rg-comp1"
    identifier = "lz-comp1"
    environment = "dev"
    location = "southeastasia"
    vnet_cidr = "10.1.0.0/16"
    subnet_list = ["App"]
    vnet_peering_list = [module.shared_vnet.vnet_info]
}

module "comp1_prod_vnet" {
    source = "./network/single_vnet"
    rg_name = "rg-comp1"
    identifier = "lz-comp1"
    environment = "prod"
    location = "southeastasia"
    vnet_cidr = "10.2.0.0/16"
    subnet_list = ["App"]
    vnet_peering_list = [module.shared_vnet.vnet_info]
}

module "comp2_prod_vnet" {
    source = "./network/single_vnet"
    rg_name = "rg-comp2"
    identifier = "lz-comp2"
    environment = "prod"
    location = "southeastasia"
    vnet_cidr = "10.3.0.0/16"
    subnet_list = ["App", "Metric", "DB", "NAS"]
    vnet_peering_list = [module.shared_vnet.vnet_info]
}

module "comp3_prod_vnet" {
    source = "./network/single_vnet"
    rg_name = "rg-comp3"
    identifier = "lz-comp3"
    environment = "prod"
    location = "southeastasia"
    vnet_cidr = "10.4.0.0/16"
    subnet_list = ["App", "DB"]
    vnet_peering_list = [module.shared_vnet.vnet_info, module.comp2_prod_vnet.vnet_info]
}

