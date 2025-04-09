variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "backend_subnet_ids" {
  description = "List of backend subnet IDs"
  type        = list(string)
}

variable "target_group_backend_arn" {
  description = "ARN of the backend target group"
  type        = string
}

variable "frontend_ecs_sg_id" {
  description = "Security group ID of the frontend ECS service"
  type        = string
} 