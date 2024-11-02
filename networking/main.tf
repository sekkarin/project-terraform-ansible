output "ansible_vpc_id" {
  value = aws_vpc.main.id
}
output "ansible_public_subnet" {
  value = aws_subnet.ansible_public_subnet.id
}

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}
resource "aws_subnet" "ansible_public_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-southeast-1a"
  tags = {
    "Name" = "ansible_public_subnet"
  }
}
resource "aws_internet_gateway" "ansible_igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "ansible-igw"
  }
}
resource "aws_route_table" "ansible_public_route_table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ansible_igw.id
  }
  tags = {
    Name = "ansible_public_RT"
  }
}
resource "aws_route_table_association" "ansible_public_rt_subnet_association" {
  subnet_id      = aws_subnet.ansible_public_subnet.id
  route_table_id = aws_route_table.ansible_public_route_table.id
}

