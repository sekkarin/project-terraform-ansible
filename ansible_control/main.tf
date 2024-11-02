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
variable "user_data_install_ansible" {

}

output "instance_public_ip" {
  description = "The public IP addresses of the EC2 instances"
  value       = [aws_instance.ansible_control[*].public_ip]
}

output "instance_id" {
  description = "The instance IDs of the EC2 instances"
  value       = [aws_instance.ansible_control[*].id]
}

output "instance_private_ip" {
  description = "The private IP addresses of the EC2 instances"
  value       = [aws_instance.ansible_control[*].private_ip]
}


resource "aws_instance" "ansible_control" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = "ansible_ec2_terraform"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.sg_ec2_ssh_http_id]
  associate_public_ip_address = var.enable_public_ip_address
  user_data                   = var.user_data_install_ansible
    tags = {
    Name = var.tag_name
  }
  metadata_options {
    http_endpoint = "enabled"  # Enable the IMDSv2 endpoint
    http_tokens   = "required" # Require the use of IMDSv2 tokens
  }
}
resource "aws_key_pair" "ansible_ec2_instance_public_key" {
  key_name   = "ansible_ec2_terraform"
  public_key = var.public_key
}
