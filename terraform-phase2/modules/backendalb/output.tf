output "backend_alb_sg_id" {
  description = "Id of Backend Security group"
  value       = data.aws_security_group.backend_alb_sg.id
}

output "backend_listener_id" {
  description = "Id of Listener"
  value       = aws_lb_listener.backend.id
}

output "backend_alb_dns" {
  description = "DNS name of the backend ALB"
  value       = data.aws_lb.backend_alb.dns_name
}
