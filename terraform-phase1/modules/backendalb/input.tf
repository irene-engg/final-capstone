variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "backend_subnet_ids" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  }

