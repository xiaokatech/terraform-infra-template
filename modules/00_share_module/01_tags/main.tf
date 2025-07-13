# 定义通用标签
locals {
  common_tags = {
    Environment = var.environment  # 环境（如：dev, staging, prod）
    Project     = var.project_name # 项目名称
    Owner       = var.owner        # 负责人
    ManagedBy   = "Terraform"      # 资源管理工具
  }
  # 定义自动化标签
  automated_tags = {
    CreateTime  = timestamp()
    UpdateTime  = timestamp()
    GitCommit   = var.data_external.git_commit
    GitBranch   = var.data_external.git_branch
    BuildNumber = var.data_external.build_number
  }

  # 合并 common_tags 和 automated_tags
  all_tags = merge(local.common_tags, local.automated_tags)

  # 为不同环境定义特定标签
  # environment_tags = {
  # dev = {
  #     Environment     = "Development"
  #     CostCenter     = "DevTeam"
  #     BackupPolicy   = "Weekly"
  # }
  # prod = {
  #     Environment     = "Production"
  #     CostCenter     = "Operations"
  #     BackupPolicy   = "Daily"
  # }
}
