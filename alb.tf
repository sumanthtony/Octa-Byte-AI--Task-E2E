# 1. ALB
resource "aws_lb" "myalb" {
  name               = "terraform-alb"
  load_balancer_type = "application"

  subnets         = [aws_subnet.mysn1.id]
  security_groups = [aws_security_group.mysg.id]
}

# 2. Target Group
resource "aws_lb_target_group" "tg" {
  name     = "my-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.myvpc.id

  health_check {
    path = "/"
    port = "traffic-port"
  }
}

# 3. Listener (like your ELB listener)
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.myalb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}
