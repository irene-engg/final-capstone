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
    key    = "phase1/terraform.tfstate"
    region = "ca-central-1"
  }
}

# To create the resources in the specified region
provider "aws" {
  region = var.aws_region
}

# To run the VPC module
module "vpc" {
  source                  = "./modules/vpc"
  aws_region              = var.aws_region
  vpc_cidr_block          = var.vpc_cidr_block
  availability_zones      = var.availability_zones
  public_subnet_cidrs     = var.public_subnet_cidrs
  frontend_subnet_cidrs   = var.frontend_subnet_cidrs
  backend_subnet_cidrs    = var.backend_subnet_cidrs
  data_subnet_cidrs       = var.data_subnet_cidrs
  }

module "backendalb" {
  source                       = "./modules/backendalb"
  vpc_id                       = module.vpc.vpc_id
  backend_subnet_ids           = module.vpc.backend_subnet_ids
}

module "frontendalb" {
  source                        = "./modules/frontendalb"
  vpc_id                        = module.vpc.vpc_id
  frontend_subnet_ids           = module.vpc.frontend_subnet_ids
}

# Create ECS Cluster
resource "aws_ecs_cluster" "main_cluster" {
  name = "main-cluster" # Or choose a more specific name

  tags = {
    Name = "main-cluster"
  }
}

