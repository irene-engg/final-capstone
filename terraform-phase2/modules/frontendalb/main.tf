data "aws_lb" "frontend_alb" {
  name = "frontend-alb" 
}

# Try to find the listener first
data "aws_lb_listener" "frontend" {
  load_balancer_arn = data.aws_lb.frontend_alb.arn
  port              = 8080
  count             = 0  # Disable looking up the listener to avoid errors
}

# Create the listener if it doesn't exist
resource "aws_lb_listener" "frontend" {
  load_balancer_arn = data.aws_lb.frontend_alb.arn  # Reference the existing ALB
  port              = 8080
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = var.target_group_frontend_arn
  }
}
