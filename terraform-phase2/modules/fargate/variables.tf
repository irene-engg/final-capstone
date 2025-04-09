variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "frontend_subnet1" {
  description = "First frontend subnet ID"
  type        = string
}

variable "frontend_subnet2" {
  description = "Second frontend subnet ID"
  type        = string
}

variable "backend_subnet1" {
  description = "First backend subnet ID"
  type        = string
}

variable "backend_subnet2" {
  description = "Second backend subnet ID"
  type        = string
}

variable "target_group_frontend_arn" {
  description = "ARN of the frontend target group"
  type        = string
}

variable "frontend_alb_sg_id" {
  description = "Security group ID of the frontend ALB"
  type        = string
}

variable "target_group_backend_arn" {
  description = "ARN of the backend target group"
  type        = string
}

variable "backend_alb_sg_id" {
  description = "Security group ID of the backend ALB"
  type        = string
}

variable "backend_listener_id" {
  description = "ID of the backend ALB listener"
  type        = string
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "backend_env_vars" {
  description = "Environment variables for the backend container"
  type        = list(map(string))
  default     = []
} 