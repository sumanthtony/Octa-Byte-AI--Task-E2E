#RDS
output "rds_endpoint" {
  value = aws_db_instance.postgres.endpoint
}

output "rds_port" {
  value = aws_db_instance.postgres.port
}

# EC2 Instance
output "app_instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.one.id
}

output "app_public_ip" {
  description = "EC2 Public IP"
  value       = aws_instance.one.public_ip
}

# ALB
output "load_balancer_dns" {
  description = "ALB DNS Name"
  value       = aws_lb.myalb.dns_name
}

