output "alb_dns_name" {
  description = "The DNS name of the frontend ALB"
  value       = data.aws_lb.frontend_alb.dns_name
}

output "alb_arn" {
  description = "The ARN of the frontend ALB"
  value       = data.aws_lb.frontend_alb.arn
}

output "frontend_alb_sg_id" {
  description = "The security group ID of the frontend ALB"
  value       = data.aws_lb.frontend_alb.security_groups[0]
} 