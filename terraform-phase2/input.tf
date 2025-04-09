variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ca-central-1"  # Adding default value for ca-central-1 region
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"  # Adding default value
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["ca-central-1a", "ca-central-1b"]  # Default AZs for ca-central-1
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]  # Adding default values
}

variable "frontend_subnet_cidrs" {
  description = "List of CIDR blocks for frontend subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]  # Adding default values
}

variable "backend_subnet_cidrs" {
  description = "List of CIDR blocks for backend subnets"
  type        = list(string)
  default     = ["10.0.5.0/24", "10.0.6.0/24"]  # Adding default values
}

#updated by rumana
variable "api_name" {
  description = "The name of the API Gateway"
  type        = string
  default     = "my-api"
}

variable "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  type        = string
  default     = ""  # Making it optional with empty default
}

variable "stage_name" {
  description = "The stage name of the API Gateway"
  type        = string
  default     = "dev"
}


variable "waf_name" {
  description = "The name of the WAF Web ACL"
  type        = string
  default     = "my-waf"
}

# Bastion-specific variables
variable "bastion_ami_id" {
  description = "AMI ID for the Bastion Host"
  type        = string
  default     = "ami-0c7217cdde317cfec"  # Amazon Linux 2 AMI
}

variable "bastion_instance_type" {
  description = "Instance type for the Bastion Host"
  type        = string
  default     = "t2.micro"
}

variable "bastion_key_name" {
  description = "SSH key pair for Bastion Host"
  type        = string
  default     = "my-key-pair"
}

variable "bastion_allowed_ssh_cidr" {
  description = "CIDR blocks allowed to SSH into Bastion Host"
  type        = string
  default     = "0.0.0.0/0"
}

# Phase 1 Output References
variable "phase1_vpc_id" {
  description = "ID of the VPC created in Phase 1"
  type        = string
  default     = null  # Will be overridden by terraform.tfvars or environment variable
}

variable "phase1_frontend_subnet_ids" {
  description = "List of frontend subnet IDs from Phase 1"
  type        = list(string)
  default     = []  # Will be overridden by terraform.tfvars or environment variable
}

variable "phase1_backend_subnet_ids" {
  description = "List of backend subnet IDs from Phase 1"
  type        = list(string)
  default     = []  # Will be overridden by terraform.tfvars or environment variable
}

variable "phase1_ecs_cluster_name" {
  description = "Name of the ECS cluster created in Phase 1"
  type        = string
  default     = ""  # Will be overridden by terraform.tfvars or environment variable
}

# Application Configuration
variable "app_name" {
  description = "Name of the application"
  type        = string
  default     = "myapp"
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
  default     = "dev"
}

# Container Configuration
variable "frontend_container_port" {
  description = "Port for the frontend container"
  type        = number
  default     = 3000
}

variable "backend_container_port" {
  description = "Port for the backend container"
  type        = number
  default     = 8080
}

variable "frontend_container_cpu" {
  description = "CPU units for the frontend container"
  type        = number
  default     = 256
}

variable "frontend_container_memory" {
  description = "Memory for the frontend container (MiB)"
  type        = number
  default     = 512
}

variable "backend_container_cpu" {
  description = "CPU units for the backend container"
  type        = number
  default     = 256
}

variable "backend_container_memory" {
  description = "Memory for the backend container (MiB)"
  type        = number
  default     = 512
}

# Load Balancer Configuration
variable "frontend_alb_port" {
  description = "Port for the frontend ALB"
  type        = number
  default     = 80
}

variable "backend_alb_port" {
  description = "Port for the backend ALB"
  type        = number
  default     = 8080
}

# Security Group Configuration
variable "frontend_ecs_sg_ingress_ports" {
  description = "List of ingress ports for frontend ECS security group"
  type        = list(number)
  default     = [3000]
}

variable "backend_ecs_sg_ingress_ports" {
  description = "List of ingress ports for backend ECS security group"
  type        = list(number)
  default     = [8080]
}