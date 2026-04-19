variable "iname" {
    type = string
    default = "IAC-server"
}

variable "ami_id" {
    type = string
    default = "ami-0e12ffc2dd465f6e4"
}

variable "itype" {
    type = string
    default = "t3.micro"
}

variable "vpc_cidr" {
    type = string
    default = "11.0.0.0/16"
}

variable "public_subnet_cidr" {
    type = string
    default = "11.0.1.0/24"
}

variable "private_subnet_cidr" {
    type = string
    default = "11.0.2.0/24"
}

