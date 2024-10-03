output "resource_group_name" {
  value = module.avm-res-resources-resourcegroup.name
  description = "The worklaods resource group name."
}
output "subnet" {
  value = {for k, subnet in azurerm_subnet.workloads : k => subnet.value.id}
  description = "Output the subnet ID and its key."
}