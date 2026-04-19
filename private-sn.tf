resource "aws_subnet" "mysn2" {
  tags = {
    Name = "iac-private_subnet"
  }
  vpc_id = aws_vpc.myvpc.id
  cidr_block = var.private_subnet_cidr
  nat_gateway_id = aws_nat_gateway.nat.id  #attaching nat_gateway to the private private route_table
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = "false"
}

resource "aws_route_table_association" "myass2" {
  subnet_id = aws_subnet.mysn2.id
  route_table_id = aws_route_table.myrt.id
}