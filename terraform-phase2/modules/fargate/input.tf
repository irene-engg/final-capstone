variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

#variable "private_subnets" {
  #description = "List of private subnets"
  #type        = list(string)
#}

variable "frontend_subnet1" {
  description = "Front end private subnet1"
  type        = string
}

variable "frontend_subnet2" {
  description = "Front end private subnet2"
  type        = string
}

variable "backend_subnet1" {
  description = "Back end private subnet1"
  type        = string
}

variable "backend_subnet2" {
  description = "Back end private subnet2"
  type        = string
}

variable "target_group_frontend_arn" {
   description = "ARN of the front end target group"
  }

  variable "frontend_alb_sg_id" {
  description = "The security group ID of the ALB"
  type        = string
}

variable "target_group_backend_arn" {
   description = "ARN of the back end target group"
  }
  
variable "backend_alb_sg_id" {
   description = "Id of backend ALB SG"
  }

variable "backend_listener_id" {
   description = "Id of backend Listener"
  }

variable "backend_env_vars" {
  type = list(object({
    name  = string
    value = string
  }))
  default = [
    { name = "PORT", value = "5000" },
    { name = "VITE_BACKEND_URL", value = "http://backend4:5000/api" }, 
    { name = "MONGO_URI", value = "mongodb+srv://cloudcapstone2025:yByQ6iLIt34Gmu6J@capstone.d8n29.mongodb.net/?retryWrites=true&w=majority&appName=capstone" },
    { name = "UPSTASH_REDIS_URL", value = "rediss://default:ATvaAAIjcDEyMzMzODQxNzM5NmQ0ZjU0YjNjMjc1ZjNlMmZkMzE5YnAxMA@topical-shepherd-15322.upstash.io:6379" },
    { name = "ACCESS_TOKEN_SECRET", value = "access_token_secret" },
    { name = "REFRESH_TOKEN_SECRET", value = "refresh_token_secret" },
    { name = "CLOUDINARY_CLOUD_NAME", value = "dcxizjba6" },
    { name = "CLOUDINARY_API_KEY", value = "122419188764634" },
    { name = "CLOUDINARY_API_SECRET", value = "5YwhG-DNJ4qbWU0Tceea4sG12JU" },
    { name = "CLIENT_URL", value = "http://localhost" },
    { name = "NODE_ENV", value = "development" }
  ]
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}