
variable "environment" {
  description = "The environment to deploy to"
}

# === project info - start ===

variable "project_name" {
  description = "The name of the project"
}

variable "owner" {
  description = "The owner of the project"
}

# === project info - end ===


variable "data_external" {
  description = "External data for the module, such as git info and build number"
  type        = map(string)
  default     = {}
}
