variable "location" {
  type        = string
  description = "The Azure Region in which all resources in this example should be created."
  default     = "uksouth"
}
variable "default_groups" {
  type        = list(string)
  description = "The default groups that are Created in Azure AD to manage te workload"
  default     = []
}
variable "subnet_address_spaces" {
  description = "A map of subnets to create in the virtual network aligned to this landing zone."
  type = map(object({
    name             = string
    address_prefixes = list(string)
  }))
}
variable "tags" {
  description = "A map of tags to apply to all resources in this example."
  type        = map(string)
}
