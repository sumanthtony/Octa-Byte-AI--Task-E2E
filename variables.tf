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

variable "public_subnet_cidr-1" {
    type = string
    default = "11.0.1.0/24"
}

variable "public_subnet_cidr-2" {
    type = string
    default = "11.0.2.0/24"
}

variable "private_subnet_cidr-1" {
    type = string
    default = "11.0.3.0/24"
}

variable "private_subnet_cidr-2" {
    type = string
    default = "11.0.4.0/24"
}

variable "sg_name" {
type = string
default = "IAC-SG"
}

variable "db_username" {
  type    = string
  default = "admin"
}

variable "db_password" {
  type    = string
  default = "password123"
}


