# Available Zones
data "aws_availability_zones" "available" {
  state = "available"
}

output "available_zones" {
  value = data.aws_availability_zones.available.names
}


# SSH Key
# First key pair
# resource "aws_key_pair" "devops23_existing" {
#   key_name   = "devops23-existing"
#   public_key = file("${path.module}/devops23.pub")
# }

# Second key pair (generated)
resource "tls_private_key" "devops23" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Save private key to file (equivalent to your original .pem file)
resource "local_file" "devops23_private_key" {
  content         = tls_private_key.devops23.private_key_pem
  filename        = "devops23.pem"
  file_permission = "0400" # Restrictive permissions
}

# Save public key to file (equivalent to your ssh-keygen command)
resource "local_file" "devops23_public_key" {
  content         = tls_private_key.devops23.public_key_openssh
  filename        = "devops23.pub"
  file_permission = "0644" # Standard permissions for public key
}

# Create AWS key pair
resource "aws_key_pair" "devops23" {
  key_name   = "devops23"
  public_key = tls_private_key.devops23.public_key_openssh
}
