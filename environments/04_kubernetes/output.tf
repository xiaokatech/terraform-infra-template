output "all_tags" {
  value = local.all_tags
}

# output "module_01_security" {
#   value = local.module_01_security
# }

output "module_02_networking" {
  value = local.module_02_networking
}

output "project_07_kubernetes" {
  value     = local.project_07_kubernetes
  sensitive = true
}
