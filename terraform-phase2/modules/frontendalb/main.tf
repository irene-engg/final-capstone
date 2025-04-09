data "aws_lb" "frontend_alb" {
  name = "frontend-alb" 
}

resource "aws_lb_listener" "frontend" {
  load_balancer_arn = data.aws_lb.frontend_alb.arn  # Reference the existing ALB
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = var.target_group_frontend_arn
  }
}
