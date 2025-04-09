output "frontend_alb_sg_id" {
  value = data.aws_security_group.frontend_alb_sg.id
}

output "frontend_listener_id" {
  description = "Id of Listener"
  value       = data.aws_lb_listener.frontend.id
}

output "frontend_alb_dns" {
  description = "DNS name of the frontend ALB"
  value       = data.aws_lb.frontend_alb.dns_name
}