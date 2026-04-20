resource "aws_instance" "one" {
    tags = {
        Name = var.iname
    }
    ami = var.ami_id
    instance_type = var.itype
    subnet_id = aws_subnet.mysn1.id  #attaching ec2-instance to the subnet
    vpc_security_group_ids = [aws_security_group.mysg.id]
}
