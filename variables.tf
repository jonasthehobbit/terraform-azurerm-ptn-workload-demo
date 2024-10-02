variable "location" {
  type        = string
  description = "uksouth"
}
variable "default_groups" {
  type        = list(string)
  description = "The default groups that are Created in Azure AD to manage te workload"
  default     = ["contributor", "reader"]
}
