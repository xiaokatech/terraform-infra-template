variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "子网ID列表"
  type        = list(string)
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "db_password" {
  description = "RDS主用户密码"
  type        = string
  sensitive   = true
}

variable "tags" {
  type = map(string)
}
