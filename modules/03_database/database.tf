# 创建数据库子网组
resource "aws_db_subnet_group" "default" {
  name       = "postgresql-subnet-group-${var.environment}"
  subnet_ids = var.subnet_ids # 从变量获取子网ID列表

  tags = var.tags
}

# 创建 RDS 实例
resource "aws_db_instance" "postgresql" {
  identifier            = "terraform-infra-template-db-${var.environment}" # 数据库实例标识符
  engine                = "postgres"
  engine_version        = "14.18"        # 指定 PostgreSQL 版本
  instance_class        = "db.t4g.micro" # 实例类型
  allocated_storage     = 10             # 分配的存储空间 (GB)
  max_allocated_storage = 20             # 自动扩展的最大存储空间 (GB)
  storage_type          = "gp2"          # 存储类型

  # 数据库凭据
  username             = "postgresadmin" # 主用户名
  password             = var.db_password # 从变量获取密码
  parameter_group_name = "default.postgres14"

  # 网络配置
  db_subnet_group_name   = aws_db_subnet_group.default.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  publicly_accessible    = false # 生产环境建议设为 false

  # 备份和维护
  backup_retention_period = 7     # 保留备份的天数
  skip_final_snapshot     = true  # 删除时不创建最终快照
  deletion_protection     = false # 生产环境建议设为 true

  # 性能配置
  multi_az          = false # 生产环境建议设为 true
  apply_immediately = true

  # 监控
  monitoring_interval             = 60 # 增强监控间隔(秒)
  monitoring_role_arn             = aws_iam_role.rds_monitoring.arn
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]

  tags = var.tags
}
