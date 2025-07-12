locals {
  environment  = "staging"                  # 环境名称
  region       = "us-east-1"                # AWS 区域
  vpc_id       = var.vpc_id                 # value in terraform.tfvars
  project_name = "terraform-infra-template" # 项目名称
  owner        = "xiaokaup.com"             # 项目负责人

  data_external = {
    git_commit   = data.external.git_info.result.commit
    git_branch   = data.external.git_info.result.branch
    build_number = data.external.build_number.result.build_number
  }

  # 定义通用标签
  all_tags = module.module_00_share_module_01_tag.all_tags
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
