variable "vpc_id" {

}
output "sg_ec2_ssh_http_id" {
  value = aws_security_group.ec2_ssh_http.id
}

resource "aws_security_group" "ec2_ssh_http" {
  name        = "SG for EC2 to enable SSH(22), HTTPS(443) and HTTP(80)"
  description = "Enable the Port 22(SSH) & Port 80(http)"
  vpc_id      = var.vpc_id
  ingress {
    description = "Allow remote SSH form anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  ingress {
    description = "Allow HTTP request form anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }
  ingress {
    description = "Allow HTTP request from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
  }
  egress {
    description = "Allow outgoing request"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Security Groups to allow SSH(22) and HTTP(80)"
  }
}
