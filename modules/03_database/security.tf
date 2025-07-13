# 创建 RDS 安全组
resource "aws_security_group" "rds" {
  name        = "postgresql-rds-sg-${var.environment}"
  description = "Allow inbound PostgreSQL traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "PostgreSQL from VPC"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # 更改为您的 VPC CIDR
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}
