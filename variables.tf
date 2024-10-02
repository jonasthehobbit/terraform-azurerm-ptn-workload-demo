variable "location" {
  type        = string
  description = "The Azure Region in which all resources in this example should be created."
  default     = "uksouth"
}
variable "default_groups" {
  type        = list(string)
  description = "The default groups that are Created in Azure AD to manage te workload"
  default     = ["contributor", "reader"]
}
