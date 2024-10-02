module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.4.1"
  suffix  = ["mmu-demo"]

}
resource "azuread_group" "main" {
  for_each         = toset(var.default_groups)
  display_name     = "${module.naming.resource_group.name_unique}-${each.key}"
  description      = "Default Groups Created By Terraform Module: ${module.naming.resource_group.name_unique}-${each.key}"
  security_enabled = false

}
module "avm-res-resources-resourcegroup" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"
  version = "0.1.0"
  # insert the 2 required variables here
  location = var.location
  name     = module.naming.resource_group.name_unique
  role_assignments = { for k, group in toset(var.default_groups) : k => {
    principal_id               = azuread_group.main[k].object_id
    role_definition_id_or_name = k
    }
  }
}

