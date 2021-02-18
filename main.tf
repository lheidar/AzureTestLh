#############################################################################
# Variables
#############################################################################

variable "resource_group_name" {
  type = string
}

variable "location" {
  type    = string
  default = "uksouth"
}


variable "vnet_cidr_range" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet_prefixes" {
  type    = list(string)
  default = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "subnet_names" {
  type    = list(string)
  default = ["web", "database"]
}

#############################################################################
# Providers
#############################################################################

provider "azurerm" {
  version = "~> 1.0"
}

#############################################################################
# Resources
#############################################################################
# Terraform registry source – verified vnet module used for azure provider
#############################################################################
module "vnet-main" {
  source              = "Azure/vnet/azurerm"
  version             = "1.2.0"
  resource_group_name = var.resource_group_name
  location            = var.location
  vnet_name           = var.resource_group_name
  address_space       = var.vnet_cidr_range
  subnet_prefixes     = var.subnet_prefixes
  subnet_names        = var.subnet_names
  nsg_ids             = {}

  tags = {
    environment = "development"
    costcenter  = "itoperations"

  }
}

#############################################################################
# Outputs
#############################################################################

output "vnet_id" {
  value = module.vnet-main.vnet_id
}
