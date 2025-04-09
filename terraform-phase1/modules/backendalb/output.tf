output "backend_alb_dns" {
  description = "DNS name of the backend ALB"
  value       = aws_lb.backend_alb.dns_name
}

output "alb_arn" {
  description = "ARN of the backend ALB"
  value       = aws_lb.backend_alb.arn
}

output "target_group_arn" {
  description = "ARN of the backend target group"
  value       = aws_lb_target_group.backend_tg.arn
}
