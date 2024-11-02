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