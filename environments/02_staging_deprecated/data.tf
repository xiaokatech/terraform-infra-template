data "external" "git_info" {
  program = ["../../scripts/git_info.sh"]
}

data "external" "build_number" {
  program = ["../../scripts/generate_build_number.sh"]
}

# 数据源获取 AWS 账户 ID
data "aws_caller_identity" "current" {}

# 获取现有的路由表
data "aws_route_tables" "vpc_route_tables" {
  vpc_id = var.vpc_id
}
