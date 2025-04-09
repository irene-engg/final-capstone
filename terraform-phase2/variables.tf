variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "ca-central-1"
}

variable "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  type        = string
} 