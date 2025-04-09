output "frontend_alb_dns" {
  description = "DNS name of the frontend ALB"
  value       = aws_lb.frontend_alb.dns_name
}

output "alb_arn" {
  description = "ARN of the frontend ALB"
  value       = aws_lb.frontend_alb.arn
}

output "target_group_arn" {
  description = "ARN of the frontend target group"
  value       = aws_lb_target_group.frontend_tg.arn
}
