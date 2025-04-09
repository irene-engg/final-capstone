data "aws_lb" "frontend_alb" {
  name = "frontend-alb" 
}

data "aws_lb_listener" "frontend" {
  load_balancer_arn = data.aws_lb.frontend_alb.arn
  port              = 80
}
