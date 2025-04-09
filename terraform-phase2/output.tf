/*output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

# Added by Rumana
output "alb_arn" {
  description = "The ARN of the Application Load Balancer"
  value       = module.frontendalb.alb_arn
}

output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = module.frontendalb.alb_dns_name
}

output "api_gateway_id" {
  description = "The ID of the API Gateway"
  value       = module.api_gateway.api_gateway_id
}

output "waf_acl_arn" {
  description = "The ARN of the WAF Web ACL"
  value       = module.waf.waf_acl_arn
}
# Output for Bastion Host
output "bastion_instance_id" {
  description = "The ID of the Bastion Host instance"
  value       = module.bastion.bastion_instance_id
}

output "bastion_public_ip" {
  description = "The public IP of the Bastion Host"
  value       = module.bastion.bastion_public_ip
}
*/

output "frontend_alb_dns" {
  description = "DNS name of the frontend ALB"
  value       = module.frontendalb.frontend_alb_dns
}

output "backend_alb_dns" {
  description = "DNS name of the backend ALB"
  value       = module.backendalb.backend_alb_dns
}

output "frontend_target_group_arn" {
  description = "ARN of the frontend target group"
  value       = module.targetgroups.target_group_frontend_arn
}

output "backend_target_group_arn" {
  description = "ARN of the backend target group"
  value       = module.targetgroups.target_group_backend_arn
}

output "frontend_ecs_service_name" {
  description = "Name of the frontend ECS service"
  value       = module.fargate.frontend_ecs_service_name
}

output "backend_ecs_service_name" {
  description = "Name of the backend ECS service"
  value       = module.fargate.backend_ecs_service_name
}

output "frontend_ecs_task_definition_arn" {
  description = "ARN of the frontend ECS task definition"
  value       = module.fargate.frontend_task_definition_arn
}

output "backend_ecs_task_definition_arn" {
  description = "ARN of the backend ECS task definition"
  value       = module.fargate.backend_task_definition_arn
}

# CloudWatch Outputs
output "frontend_log_group_name" {
  description = "Name of the frontend CloudWatch log group"
  value       = module.fargate.frontend_log_group_name
}

output "backend_log_group_name" {
  description = "Name of the backend CloudWatch log group"
  value       = module.fargate.backend_log_group_name
}

output "cloudwatch_dashboard_name" {
  description = "Name of the CloudWatch dashboard"
  value       = module.fargate.cloudwatch_dashboard_name
}