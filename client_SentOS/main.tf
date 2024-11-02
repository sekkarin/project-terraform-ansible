variable "ami_id" {

}
variable "instance_type" {

}
variable "tag_name" {

}
variable "public_key" {

}
variable "subnet_id" {

}
variable "sg_ec2_ssh_http_id" {

}
variable "enable_public_ip_address" {

}

variable "count_instance" {

}
# Output the IPs of created instances
output "instance_public_ip" {
  description = "The public IP addresses of the EC2 instances"
  value       = [aws_instance.client_centOS[*].public_ip]
}

output "instance_id" {
  description = "The instance IDs of the EC2 instances"
  value       = [aws_instance.client_centOS[*].id]
}

output "instance_private_ip" {
  description = "The private IP addresses of the EC2 instances"
  value       = [aws_instance.client_centOS[*].private_ip]
}



resource "aws_instance" "client_centOS" {
  count                       = var.count_instance
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = "client-key"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.sg_ec2_ssh_http_id]
  associate_public_ip_address = var.enable_public_ip_address
  tags = {
    Name = "${var.tag_name}-${count.index + 1}"
  }
  metadata_options {
    http_endpoint = "enabled"  # Enable the IMDSv2 endpoint
    http_tokens   = "required" # Require the use of IMDSv2 tokens
  }
}
# resource "aws_key_pair" "client_key" {
#   key_name   = "client-key"
#   public_key = var.public_key
# }
