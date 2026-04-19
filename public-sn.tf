resource "aws_subnet" "mysn1" {
  tags = {
    Name = "iac-public_subnet"
  }
  vpc_id = aws_vpc.myvpc.id
  cidr_block = var.public_subnet_cidr
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = "true"
}

resource "aws_route_table_association" "myass1" {
  subnet_id = aws_subnet.mysn1.id
  route_table_id = aws_route_table.myrt.id
}