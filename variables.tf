variable "location" {
  type        = string
  description = ""
}
variable "default_groups" {
  type = map(object({
    display_name = string
    description  = string
  }))
  description = "The default groups that are Created in Azure AD to manage te workload"
  default     = ["contributor", "reader"]
}
