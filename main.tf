module "networking" {
  source = "./networking"
}
module "security_group" {
  source = "./security-group"
  vpc_id = module.networking.ansible_vpc_id
}
module "ansible_control" {
  source                    = "./ansible_control"
  ami_id                    = "ami-047126e50991d067b"
  instance_type             = "t2.micro"
  public_key                = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC7QEJFquTlsVIVC+CkXIKQjAY0WJNLRHAg2fkhT+fSplSc0BXe4Hs8dfolHYprAeUn2gBpGlbdeDgni3EKaEhdNExX75gu7H+NILQenXolljZKRQwCq7SX2ZLsZHSE66WK9imwiKZ9gQEwFNK8b6gGTJV1iuW4CeBaZY4lWCFxO6R+oMFeNbgC6iziwOicp/SXf+kjpnfX2x/Vi0DxVRl1XoYPSzVJIbIj9n/jTkfPG0Cv3RLbZU/7ppKz1y+RjcnmLRNyX7NAZ2A7FMnootpGCHYU4ocvlmezY05S7eVKY/DYN3pH3UchdBilLjY1QbJB672VbU8fEoqsrOA32g4LPlma9lkYGBPofg0tS1W6uM78ryOExL3FfOnDkCheykRinnBPgwwmVYHKAORSCgmC9Y9dXPG1A9qJsDDG7X6yBmmSCdXEXmy/CMQkFRlB8/BYmYpXAuV0xSRHrOuVR8bV3Ha92U0sOti85JH8F8hEU8TGUPcd+s3NElvJ57K55Is= KEN@LAPTOP-C2I4L7U0"
  sg_ec2_ssh_http_id        = module.security_group.sg_ec2_ssh_http_id
  tag_name                  = "Ansible:Ubuntu Linux EC2"
  subnet_id                 = module.networking.ansible_public_subnet
  enable_public_ip_address  = true
  user_data_install_ansible = templatefile("./ansible-script/ansible-installer.sh", {})

}

module "client_centOS" {
  source                    = "./client_SentOS"
  ami_id                    = "ami-063e47194887f241b"
  instance_type             = "t2.micro"
  public_key                = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCz+PXWWjcTpze47iYtwDuBeTB2NHgz4VxVDcqZToXA1jEEuGwMbDLhEUdNAB74kfQ+phhKy7DboZ8JGTEEw2ti/ZBELJOlkAbmgZv16TbUyjuHG1lTnAyN2+CbdXx1x6L3xuqiY6UkPM7Ke/3bqNeDzff9V/lyCmMIMT/XYQ4lgRlBPYaSfq9qEPYfwgbTkGewY4CS3TLgnTLIcbYfpeZlcBvwtNWgV/mpmdJAC49OEQ1jR/oGpJcqAYKL71cyF23mrI1eAAz+74KsfdBTyi/cprxq9AUQvOIqH9EFxGBti3wozW+UzWDpykf17gOl4FdB6MYzOETpyx4rv80LxFagoS+FlcxBJd8N6x42GAOMM+89OW/RNrboYdXLuBEXnqIsAhpSanSn6JSEvajbIffI7HoCyOkdY8iLJxmYUHW79EmfsfvFRmvUYfTbFKKr+0fDagYAkvMJaj1SxeBvoqWbC9Gh+OMqFRTgC8rtByvX30JuMjzRvw7er0huYOoBp28= KEN@LAPTOP-C2I4L7U0"
  sg_ec2_ssh_http_id        = module.security_group.sg_ec2_ssh_http_id
  tag_name                  = "Client:CentOS Linux EC2"
  subnet_id                 = module.networking.ansible_public_subnet
  enable_public_ip_address  = true
  count_instance = 2

}
module "client_ubuntu" {
  source                    = "./client_SentOS"
  ami_id                    = "ami-047126e50991d067b"
  instance_type             = "t2.micro"
  public_key                = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCz+PXWWjcTpze47iYtwDuBeTB2NHgz4VxVDcqZToXA1jEEuGwMbDLhEUdNAB74kfQ+phhKy7DboZ8JGTEEw2ti/ZBELJOlkAbmgZv16TbUyjuHG1lTnAyN2+CbdXx1x6L3xuqiY6UkPM7Ke/3bqNeDzff9V/lyCmMIMT/XYQ4lgRlBPYaSfq9qEPYfwgbTkGewY4CS3TLgnTLIcbYfpeZlcBvwtNWgV/mpmdJAC49OEQ1jR/oGpJcqAYKL71cyF23mrI1eAAz+74KsfdBTyi/cprxq9AUQvOIqH9EFxGBti3wozW+UzWDpykf17gOl4FdB6MYzOETpyx4rv80LxFagoS+FlcxBJd8N6x42GAOMM+89OW/RNrboYdXLuBEXnqIsAhpSanSn6JSEvajbIffI7HoCyOkdY8iLJxmYUHW79EmfsfvFRmvUYfTbFKKr+0fDagYAkvMJaj1SxeBvoqWbC9Gh+OMqFRTgC8rtByvX30JuMjzRvw7er0huYOoBp28= KEN@LAPTOP-C2I4L7U0"
  sg_ec2_ssh_http_id        = module.security_group.sg_ec2_ssh_http_id
  tag_name                  = "Client:Ubuntu Linux EC2"
  subnet_id                 = module.networking.ansible_public_subnet
  enable_public_ip_address  = true
  count_instance = 1

}
module "client_db_centOS" {
  source                    = "./client_db_SentOS"
  ami_id                    = "ami-063e47194887f241b"
  instance_type             = "t2.micro"
  public_key                = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCz+PXWWjcTpze47iYtwDuBeTB2NHgz4VxVDcqZToXA1jEEuGwMbDLhEUdNAB74kfQ+phhKy7DboZ8JGTEEw2ti/ZBELJOlkAbmgZv16TbUyjuHG1lTnAyN2+CbdXx1x6L3xuqiY6UkPM7Ke/3bqNeDzff9V/lyCmMIMT/XYQ4lgRlBPYaSfq9qEPYfwgbTkGewY4CS3TLgnTLIcbYfpeZlcBvwtNWgV/mpmdJAC49OEQ1jR/oGpJcqAYKL71cyF23mrI1eAAz+74KsfdBTyi/cprxq9AUQvOIqH9EFxGBti3wozW+UzWDpykf17gOl4FdB6MYzOETpyx4rv80LxFagoS+FlcxBJd8N6x42GAOMM+89OW/RNrboYdXLuBEXnqIsAhpSanSn6JSEvajbIffI7HoCyOkdY8iLJxmYUHW79EmfsfvFRmvUYfTbFKKr+0fDagYAkvMJaj1SxeBvoqWbC9Gh+OMqFRTgC8rtByvX30JuMjzRvw7er0huYOoBp28= KEN@LAPTOP-C2I4L7U0"
  sg_ec2_ssh_http_id        = module.security_group.sg_ec2_ssh_http_id
  tag_name                  = "Client DB :CentOS Linux EC2"
  subnet_id                 = module.networking.ansible_public_subnet
  enable_public_ip_address  = true
  count_instance = 1

}

output "ansible_instance_public_ip" {
  description = "The instance IDs of the EC2 instances"
  value       = [module.ansible_control.instance_public_ip]
}

output "client_centOS_instance_private_ip" {
  description = "The private IP addresses of the EC2 instances"
  # value       = [aws_instance.client_centOS[*].private_ip]
  value = module.client_centOS.instance_private_ip
}
output "client_db_centOS_instance_private_ip" {
  description = "The private IP addresses of the EC2 instances"
  # value       = [aws_instance.client_centOS[*].private_ip]
  value = module.client_db_centOS.instance_private_ip
}
output "client_ubuntuOS_instance_private_ip" {
  description = "The private IP addresses of the EC2 instances"
  # value       = [aws_instance.client_centOS[*].private_ip]
  value = module.client_ubuntu.instance_private_ip
}