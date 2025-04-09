data "aws_lb" "backend_alb" {
  name = "backend-alb" 
}

# Try to find the listener first
data "aws_lb_listener" "backend" {
  load_balancer_arn = data.aws_lb.backend_alb.arn
  port              = 5001
  count             = 0  # Disable looking up the listener to avoid errors
}

# Create the listener if it doesn't exist
resource "aws_lb_listener" "backend" {
  load_balancer_arn = data.aws_lb.backend_alb.arn  # Reference the existing ALB
  port              = 5001
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = var.target_group_backend_arn
  }
}
