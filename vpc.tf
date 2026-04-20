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
    Name = "iac-public_subnet-1"
  }
  vpc_id = aws_vpc.myvpc.id
  cidr_block = var.public_subnet_cidr_1
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = "true"
}

resource "aws_subnet" "mysn2" {
  tags = {
    Name = "iac-public_subnet-2"
  }
  vpc_id = aws_vpc.myvpc.id
  cidr_block = var.public_subnet_cidr_2
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = "true"
}

resource "aws_subnet" "mysn3" {
  tags = {
    Name = "iac-private_subnet-1"
  }
  vpc_id = aws_vpc.myvpc.id
  cidr_block = var.private_subnet_cidr_1
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = "false"
}

resource "aws_subnet" "mysn4" {
  tags = {
    Name = "iac-private_subnet-2"
  }
  vpc_id = aws_vpc.myvpc.id
  cidr_block = var.private_subnet_cidr_2
  availability_zone = "ap-south-1c"
  map_public_ip_on_launch = "false"
}

resource "aws_internet_gateway" "myigw" {
  tags = {
    Name = "iac-igw"
  }
  vpc_id = aws_vpc.myvpc.id
}

#ELASTIC IP (FOR NAT)
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  tags = {
    Name = "iac-nat"
  }
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.mysn1.id

  depends_on = [aws_internet_gateway.myigw]
}

#PUBLIC ROUTE TABLE
resource "aws_route_table" "public_rt" {
  tags = {
    Name = "iac-public-rt"
  }
  vpc_id = aws_vpc.myvpc.id
  route {
    gateway_id = aws_internet_gateway.myigw.id
    cidr_block = "0.0.0.0/0"
  }
}

#PRIVATE ROUTE TABLE
resource "aws_route_table" "private_rt" {
  tags = {
    Name = "iac-private-rt"
  }
  vpc_id = aws_vpc.myvpc.id
  route {
    nat_gateway_id = aws_nat_gateway.nat.id
    cidr_block = "0.0.0.0/0"
  }
}

#ASSOCIATION (PUBLIC)
resource "aws_route_table_association" "myass1" {
  subnet_id      = each.value
  for_each = {
    subnet_1 = aws_subnet.mysn1.id
    subnet_2 = aws_subnet.mysn2.id 
  }
  route_table_id = aws_route_table.public_rt.id
}

#ASSOCIATION (PRIVATE)
resource "aws_route_table_association" "myass2" {
  subnet_id      = each.value
  for_each = { 
    subnet_3 = aws_subnet.mysn3.id
    subnet_4 = aws_subnet.mysn4.id
  }
  route_table_id = aws_route_table.private_rt.id
}



