data "aws_lb_target_group" "frontend_tg" {
  name = "frontend-tg"
}

data "aws_lb_target_group" "backend_tg" {
  name = "backend-tg"
}