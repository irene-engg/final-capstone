output "backend_alb_sg_id" {
  description = "Id of Backend Security group"
  value       = data.aws_lb.backend_alb.security_groups[0]
}

output "backend_listener_id" {
  description = "Id of Listener"
  value       = aws_lb_listener.backend.id
}
