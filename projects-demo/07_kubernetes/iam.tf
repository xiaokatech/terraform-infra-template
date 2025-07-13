# AWS IAM Group
resource "aws_iam_group" "kops" {
  name = "kops"
  path = "/"
}

resource "aws_iam_group_policy_attachment" "ec2_full_access" {
  group      = aws_iam_group.kops.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_group_policy_attachment" "s3_full_access" {
  group      = aws_iam_group.kops.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_group_policy_attachment" "vpc_full_access" {
  group      = aws_iam_group.kops.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
}

resource "aws_iam_group_policy_attachment" "iam_full_access" {
  group      = aws_iam_group.kops.name
  policy_arn = "arn:aws:iam::aws:policy/IAMFullAccess"
}

# AWS IAM User
resource "aws_iam_user" "kops" {
  name = "kops" # Replace with your desired username
  path = "/"

  tags = var.tags
}


# Attach iam user with iam group
resource "aws_iam_user_group_membership" "kops_kops" {
  user = aws_iam_user.kops.name

  groups = [
    aws_iam_group.kops.name
  ]
}


# AWS IAM User Access Key
resource "aws_iam_access_key" "user_kops" {
  user = aws_iam_user.kops.name
}

output "user_kops_access_key" {
  value     = aws_iam_access_key.user_kops.id
  sensitive = true
}

output "user_kops_secret_key" {
  value     = aws_iam_access_key.user_kops.secret
  sensitive = true
}

# Output as file
resource "local_file" "user_kops_creds" {
  content  = <<EOF
AccessKeyId: ${aws_iam_access_key.user_kops.id}
SecretAccessKey: ${aws_iam_access_key.user_kops.secret}
EOF
  filename = "aws-user-kops-creds.env"
}
