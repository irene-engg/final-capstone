data "aws_lb" "backend_alb" {
  name = "backend-alb" 
}

data "aws_lb_listener" "backend" {
  load_balancer_arn = data.aws_lb.backend_alb.arn
  port              = 5000
}
