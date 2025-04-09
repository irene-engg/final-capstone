variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  }

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  }

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  }

variable "frontend_subnet_cidrs" {
  description = "List of CIDR blocks for frontend subnets"
  type        = list(string)
  }

variable "backend_subnet_cidrs" {
  description = "List of CIDR blocks for backend subnets"
  type        = list(string)
  }

variable "data_subnet_cidrs" {
  description = "List of CIDR blocks for data subnets"
  type        = list(string)
  }

#updated by rumana
variable "api_name" {
  description = "The name of the API Gateway"
  type        = string
}

variable "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  type        = string
}

variable "stage_name" {
  description = "The stage name of the API Gateway"
  type        = string
  default     = "prod"
}

variable "waf_name" {
  description = "The name of the WAF Web ACL"
  type        = string
}

# Bastion-specific variables
variable "bastion_ami_id" {
  description = "AMI ID for the Bastion Host"
  type        = string
}

variable "bastion_instance_type" {
  description = "Instance type for the Bastion Host"
  default     = "t2.micro"
}

variable "bastion_key_name" {
  description = "SSH key pair for Bastion Host"
  type        = string
}

variable "bastion_allowed_ssh_cidr" {
  description = "CIDR blocks allowed to SSH into Bastion Host"
  type        = list(string)
  default     = ["0.0.0.0/0"]  # Restrict to your IP for security
}