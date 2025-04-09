variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "target_group_frontend_arn" {
   description = "ARN of the front end target group"
  }


variable "frontend_subnet_ids" {
  description = "List of CIDR blocks for frontend private subnets"
  type        = list(string)
  }

