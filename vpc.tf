resource "aws_vpc" "myvpc" {
tags = {
Name = "terraform-vpc"
}
cidr_block = var.vpc_cidr
instance_tenancy = "default"
enable_dns_hostnames = "true"
}

resource "aws_subnet" "mysn1" {
  tags = {
    Name = "iac-public_subnet"
  }
  vpc_id = aws_vpc.myvpc.id
  cidr_block = var.public_subnet_cidr
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = "true"
}

resource "aws_subnet" "mysn2" {
  tags = {
    Name = "iac-private_subnet"
  }
  vpc_id = aws_vpc.myvpc.id
  cidr_block = var.private_subnet_cidr
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = "false"
}

resource "aws_internet_gateway" "myigw" {
  tags = {
    Name = "iac-igw"
  }
  vpc_id = aws_vpc.myvpc.id
}

resource "aws_route_table" "myrt" {
  tags = {
    Name = "iac-rt"
  }
  vpc_id = aws_vpc.myvpc.id
  route {
    gateway_id = aws_internet_gateway.myigw.id
    cidr_block = "0.0.0.0/0"
  }
}

resource "aws_route_table_association" "myass1" {
  subnet_id = aws_subnet.mysn1.id
  route_table_id = aws_route_table.myrt.id
}
