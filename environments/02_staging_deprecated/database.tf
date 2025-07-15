locals {
  # module_03_database = {
  #   database_instance_id = module.module_03_database.database_instance_id
  # }
}

# module "module_03_database" {
#   source = "../../modules/03_database"
#   # 环境特定的变量

#   vpc_id      = local.module_02_networking.vpc_id
#   subnet_ids  = local.module_02_networking.all_subnet_ids
#   environment = local.environment
#   db_password = "afEi4mdALxVDJY"

#   tags = module.module_00_share_module_01_tag.all_tags
# }
