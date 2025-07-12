output "vpc_id" {
  description = "The ID of the VPC"
  value       = data.aws_vpc.existing.id
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = data.aws_subnets.all.ids
}
