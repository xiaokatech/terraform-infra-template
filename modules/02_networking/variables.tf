variable "vpc_id" {
  description = "ID of the existing VPC"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "route_table_ids" {
  description = "List of route table IDs for VPC endpoints"
  type        = list(string)
  default     = []
}

# === tags - start ===
variable "tags" {
  type = map(string)
}
# === tags - end ===
