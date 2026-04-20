#RDS SECURITY GROUP

resource "aws_security_group" "rds_sg" {
  name   = "rds-sg"
  vpc_id = aws_vpc.myvpc.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]   # allow from inside VPC
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "iac-rds-sg"
  }
}

# DB SUBNET GROUP: RDS must be placed in subnets (prefer private)

resource "aws_db_subnet_group" "rds_subnet_group" {
tags = {
    Name = "iac-rds-subnet-group"
  }
subnet_ids = [aws_subnet.mysn2.id, aws_subnet.mysn3.id]
}
#Because RDS must be associated with a subnet group to decide where it runs

#RDS POSTGRESQL INSTANCE

resource "aws_db_instance" "postgres" {
  identifier = "iac-postgres-db"

  engine         = "postgres"
  engine_version = "14"
  instance_class = "db.t3.micro"

  allocated_storage = 20

  db_name  = "mydb"
  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  publicly_accessible = false   # IMPORTANT (private DB)
  skip_final_snapshot = true

  multi_az = false

  tags = {
    Name = "iac-postgres"
  }
}


