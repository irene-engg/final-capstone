data "aws_lb" "backend_alb" {
  name = "backend-alb" 
}

resource "aws_lb_listener" "backend" {
  load_balancer_arn = data.aws_lb.backend_alb.arn  # Reference the existing ALB
  port              = 5000
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = var.target_group_backend_arn
  }
}
