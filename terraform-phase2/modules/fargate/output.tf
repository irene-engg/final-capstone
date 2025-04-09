output "frontend_ecs_arn" {
  description = "ARN of the Frontend ECS Service"
  value       = aws_ecs_service.frontend_service.id
}

output "backend_ecs_arn" {
  description = "ARN of the Backend ECS Service"
  value       = aws_ecs_service.backend_service.id
}

output "frontend_ecs_sg_id" {
  description = "Id of the Frontend ECS Service SG"
  value       = aws_security_group.frontend_sg.id
}

output "frontend_ecs_service_name" {
  description = "Name of the frontend ECS service"
  value       = aws_ecs_service.frontend_service.name
}

output "backend_ecs_service_name" {
  description = "Name of the backend ECS service"
  value       = aws_ecs_service.backend_service.name
}

output "frontend_task_definition_arn" {
  description = "ARN of the frontend ECS task definition"
  value       = aws_ecs_task_definition.frontend_task.arn
}

output "backend_task_definition_arn" {
  description = "ARN of the backend ECS task definition"
  value       = aws_ecs_task_definition.backend_task.arn
}

output "frontend_log_group_name" {
  description = "Name of the frontend CloudWatch log group"
  value       = aws_cloudwatch_log_group.frontend_log_group.name
}

output "backend_log_group_name" {
  description = "Name of the backend CloudWatch log group"
  value       = aws_cloudwatch_log_group.backend_log_group.name
}

output "cloudwatch_dashboard_name" {
  description = "Name of the CloudWatch dashboard"
  value       = aws_cloudwatch_dashboard.ecs_dashboard.dashboard_name
}
