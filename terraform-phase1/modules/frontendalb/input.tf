variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "frontend_subnet_ids" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  }
