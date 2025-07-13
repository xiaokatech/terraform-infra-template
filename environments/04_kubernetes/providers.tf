provider "aws" {
  region = local.region
}


# 设置 Terraform 后端
# terraform {
#   backend "s3" {
#     bucket = "terraform-infra-template-s3-bucket"
#     key            = "dev/microservices/terraform.tfstate"
#     region         = "us-east-1"
#     dynamodb_table = "terraform-locks"
#     encrypt        = true
#   }
# }
