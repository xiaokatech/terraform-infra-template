locals {
  environment  = "k8s-env"                    # 环境名称
  region       = "us-east-1"                  # AWS 区域
  vpc_id       = var.vpc_id                   # value in terraform.tfvars
  project_name = "terraform-infra-kubernetes" # 项目名称
  owner        = "xiaokaup.com"               # 项目负责人

  data_external = {
    git_commit   = data.external.git_info.result.commit
    git_branch   = data.external.git_info.result.branch
    build_number = data.external.build_number.result.build_number
  }

  # 定义通用标签
  all_tags = module.module_00_share_module_01_tag.all_tags

  # module_01_security = {
  #   lambda_security_group_id = module.module_01_security.lambda_security_group_id
  # }

  module_02_networking = {
    vpc_id         = module.module_02_networking.vpc_id
    all_subnet_ids = module.module_02_networking.all_subnet_ids
  }

  project_07_kubernetes = module.project_07_kubernetes
}



module "module_00_share_module_01_tag" {
  source = "../../modules/00_share_module/01_tags"

  # 环境特定的变量
  environment = local.environment

  # 项目相关的变量
  project_name = local.project_name

  owner = local.owner

  data_external = local.data_external
}


# module "module_01_security" {
#   source = "../../modules/01_security"

#   # 环境特定的变量
#   vpc_id      = local.vpc_id
#   environment = local.environment

#   tags = module.module_00_share_module_01_tag.all_tags
# }

module "module_02_networking" {
  source = "../../modules/02_networking"
  # 环境特定的变量

  vpc_id          = local.vpc_id
  region          = local.region
  environment     = local.environment
  route_table_ids = data.aws_route_tables.vpc_route_tables.ids

  tags = module.module_00_share_module_01_tag.all_tags
}


module "project_07_kubernetes" {
  source = "../../projects-demo/07_kubernetes"

  tags = module.module_00_share_module_01_tag.all_tags
}
