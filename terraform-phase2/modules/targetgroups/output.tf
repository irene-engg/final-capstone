output "target_group_frontend_arn" {
  value = aws_lb_target_group.frontend_tg.arn
}

output "target_group_backend_arn" {
  value = aws_lb_target_group.backend_tg.arn
}