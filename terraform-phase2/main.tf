terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.6.6"
  
  backend "s3" {
    bucket = "capstonebucketcloud2025"
    key    = "phase2/terraform.tfstate"
    region = "ca-central-1"
  }
}

# To create the resources in the specified region
provider "aws" {
  region = var.aws_region
}

# Use the remote state from Phase 1
data "terraform_remote_state" "phase1" {
  backend = "s3"
  config = {
    bucket = "capstonebucketcloud2025"
    key    = "phase1/terraform.tfstate"
    region = "ca-central-1"
  }
}

# Use the VPC ID from Phase 1
data "aws_vpc" "phase1_vpc" {
  id = data.terraform_remote_state.phase1.outputs.vpc_id
}

# Use the subnet IDs from Phase 1
data "aws_subnet" "frontend_subnet1" {
  id = data.terraform_remote_state.phase1.outputs.frontend_subnet_ids[0]
}

data "aws_subnet" "frontend_subnet2" {
  id = data.terraform_remote_state.phase1.outputs.frontend_subnet_ids[1]
}

data "aws_subnet" "backend_subnet1" {
  id = data.terraform_remote_state.phase1.outputs.backend_subnet_ids[0]
}

data "aws_subnet" "backend_subnet2" {
  id = data.terraform_remote_state.phase1.outputs.backend_subnet_ids[1]
}

# Use the ECS cluster from Phase 1
data "aws_ecs_cluster" "phase1_cluster" {
  cluster_name = data.terraform_remote_state.phase1.outputs.ecs_cluster_name
}

module "targetgroups" {
  source    = "./modules/targetgroups"
  vpc_id    = data.aws_vpc.phase1_vpc.id
}

module "frontendalb" {
  source                       = "./modules/frontendalb"
  vpc_id                       = data.aws_vpc.phase1_vpc.id
  frontend_subnet_ids          = data.terraform_remote_state.phase1.outputs.frontend_subnet_ids
  target_group_frontend_arn    = module.targetgroups.target_group_frontend_arn
}

module "backendalb" {
  source                      = "./modules/backendalb"
  vpc_id                      = data.aws_vpc.phase1_vpc.id
  backend_subnet_ids          = data.terraform_remote_state.phase1.outputs.backend_subnet_ids
  target_group_backend_arn    = module.targetgroups.target_group_backend_arn
  frontend_ecs_sg_id          = module.fargate.frontend_ecs_sg_id
}

module "fargate" {
  source                      = "./modules/fargate"
  vpc_id                      = data.aws_vpc.phase1_vpc.id
  frontend_subnet1            = data.aws_subnet.frontend_subnet1.id
  frontend_subnet2            = data.aws_subnet.frontend_subnet2.id
  backend_subnet1             = data.aws_subnet.backend_subnet1.id
  backend_subnet2             = data.aws_subnet.backend_subnet2.id
  target_group_frontend_arn   = module.targetgroups.target_group_frontend_arn
  frontend_alb_sg_id          = module.frontendalb.frontend_alb_sg_id
  target_group_backend_arn    = module.targetgroups.target_group_backend_arn
  backend_alb_sg_id           = module.backendalb.backend_alb_sg_id
  backend_listener_id         = module.backendalb.backend_listener_id
  ecs_cluster_name            = data.aws_ecs_cluster.phase1_cluster.cluster_name
}

/*
#Added by rumana
module "bastion" {
  source             = "./modules/bastion"
  vpc_id             = var.vpc_id
  public_subnet_ids  = var.public_subnet_cidrs  # Ensure this is correctly passed
  ami_id             = var.bastion_ami_id
  instance_type      = var.bastion_instance_type
  key_name           = var.bastion_key_name
  allowed_ssh_cidr   = var.bastion_allowed_ssh_cidr
}

module "api_gateway" {
  source       = "./modules/api_gateway"
  api_name     = var.api_name
  stage_name   = var.stage_name
  alb_arn      = module.frontendalb.alb_arn   # Pass ALB ARN correctly
  alb_dns_name = module.frontendalb.alb_dns_name  # Correct module reference
}


module "waf" {
  source = "./modules/waf"
  waf_name = var.waf_name
  api_gateway_stage_arn = module.api_gateway.api_gateway_stage_arn
}

*/