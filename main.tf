# Purpose: This file is used to create the main.tf file for the terraform module
# 
module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.4.1"
  suffix  = ["mmu", "demo"]

}
# Create the Azure AD groups that will be used to assign roles to the resource group.
resource "azuread_group" "main" {
  for_each         = toset(var.default_groups)
  display_name     = "rbac-${module.naming.resource_group.name_unique}-${each.key}"
  description      = "Default Groups Created By Terraform Module: ${module.naming.resource_group.name_unique}-${each.key}"
  security_enabled = true
}
# Uses the AVM module to create a resource group with the specified name and location and assigns the specified role assignments to the resource group.
module "avm-res-resources-resourcegroup" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"
  version = "0.1.0"
  # insert the 2 required variables here
  location = var.location
  name     = module.naming.resource_group.name_unique
  tags     = var.tags
  role_assignments = { for k, group in toset(var.default_groups) : k => {
    principal_id               = azuread_group.main[k].object_id
    role_definition_id_or_name = k
    }
  }
}
# Uses the remote state data source to get the output from the network module and create a subnet in the virtual network.
data "terraform_remote_state" "network" {
  backend = "remote"
  config = {
    organization = "MMUDemo"
    workspaces = {
      name = "terraform-azurerm-ptn-network-demo"
    }
  }
}
resource "azurerm_subnet" "workloads" {
  for_each             = var.subnet_address_spaces
  name                 = each.value.name
  resource_group_name  = data.terraform_remote_state.network.outputs.resource_group_name
  virtual_network_name = data.terraform_remote_state.network.outputs.virtual_network_name
  address_prefixes     = each.value.address_prefixes
}
