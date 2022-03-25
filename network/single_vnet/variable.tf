variable "rg_name" {
    type = string
    description = "resource group name"
}

variable "identifier" {
    type = string
    description = "some identifing information like project name or company name. This variable is used to name the vnet"
}

variable "environment" {
    type = string
    description = "vnet environment ex)dev prod dr test etc"
}

variable "location" {
    type = string
    description = "region information"
}

variable "vnet_cidr" {
    type = string
    description = "vnet_cidr"
}

variable "subnet_list" {
    type = list(string)
    description = "the list of subnet purposes ex) Web Was DB etc"
}

variable "vnet_peering_list" {
    type = list(any)
    default = []
    description = "map of other vnets which should be peerd with this vnet. Each inner list is one vnet information"
}

variable "tags" {
    type = map(string)
    default = {}
    description = "tag informations to attach to vnet"
}