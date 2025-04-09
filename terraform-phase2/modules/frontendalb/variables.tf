variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "frontend_subnet_ids" {
  description = "List of frontend subnet IDs"
  type        = list(string)
}

variable "target_group_frontend_arn" {
  description = "ARN of the frontend target group"
  type        = string
} 