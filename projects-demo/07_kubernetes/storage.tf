resource "aws_s3_bucket" "devops23" {
  bucket = "devops23-kubernetes-demo-s3-bucket"

  tags = var.tags
}

# Output the bucket name
output "bucket_name" {
  value = aws_s3_bucket.devops23.bucket
}

# Output the bucket URL
output "bucket_url" {
  value = "https://${aws_s3_bucket.devops23.bucket_regional_domain_name}"
}
