output "resource_group_name" {
  value = module.avm-res-resources-resourcegroup.name
  description = "The worklaods resource group name."
}
output "resource_group_location" {
  value = module.avm-res-resources-resourcegroup.location
  description = "The worklaods resource group location."
}
output "subnet" {
  value = {for k, subnet in azurerm_subnet.workloads : k => subnet.id}
  description = "Output the subnet ID and its key."
}