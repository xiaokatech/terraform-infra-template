# 使用数据源获取现有 VPC
data "aws_vpc" "existing" {
  id = var.vpc_id
}

# 获取现有 VPC 的子网
data "aws_subnets" "all" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  # filter {
  #   name   = "tag:Type"
  #   values = ["Private"]
  # }
}
