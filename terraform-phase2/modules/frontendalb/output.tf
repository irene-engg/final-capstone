output "frontend_alb_sg_id" {
  value = data.aws_security_group.frontend_alb_sg.id
}

output "frontend_listener_id" {
  description = "Id of Listener"
  value       = aws_lb_listener.frontend.id
}