locals {
  environment = var.environment
  tags        = var.tags
  vpc_id      = var.vpc_id
}


variable "vpc_id" {
  description = "ID of the existing VPC"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

# === tags - start ===
variable "tags" {
  type = map(string)
}
# === tags - end ===
