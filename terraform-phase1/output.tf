output "backend_alb_dns" {
  description = "DNS name of the backend ALB"
  value       = module.backendalb.backend_alb_dns
}


output "frontend_alb_dns" {
  description = "DNS name of the frontend ALB"
  value       = module.frontendalb.frontend_alb_dns
}

# --- Outputs needed for Phase 2 ---

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "frontend_subnet_ids" {
  description = "List of frontend subnet IDs"
  value       = module.vpc.frontend_subnet_ids
}

output "backend_subnet_ids" {
  description = "List of backend subnet IDs"
  value       = module.vpc.backend_subnet_ids
}

output "ecs_cluster_name" {
  description = "Name of the ECS Cluster"
  value       = aws_ecs_cluster.main_cluster.name
}

# Assuming the ALB modules output these ARNs
# If not, you'll need to add these outputs inside the respective modules

output "frontend_alb_arn" {
  description = "ARN of the Frontend ALB"
  value       = module.frontendalb.alb_arn # Adjust if output name is different
}

output "backend_alb_arn" {
  description = "ARN of the Backend ALB"
  value       = module.backendalb.alb_arn # Adjust if output name is different
}

output "frontend_target_group_arn" {
  description = "ARN of the Frontend Target Group"
  value       = module.frontendalb.target_group_arn # Adjust if output name is different
}

output "backend_target_group_arn" {
  description = "ARN of the Backend Target Group"
  value       = module.backendalb.target_group_arn # Adjust if output name is different
}

