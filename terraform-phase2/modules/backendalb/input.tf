variable "frontend_ecs_sg_id" {
   description = "ID of frontend ECS SG"
  }

variable "target_group_backend_arn" {
   description = "ARN of the backend end target group"
  }

variable "backend_subnet_ids" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  }

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}
