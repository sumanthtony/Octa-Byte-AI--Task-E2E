resource "aws_instance" "one" {
    tags = {
        Name = var.iname
    }
    ami = var.ami_id
    instance_type = var.itype
    vpc_security_group_ids = [aws_security_group.mysg.id]
}
