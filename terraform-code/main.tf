terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 5.0"
        }
    }
    
    required_version = ">= 1.0"
}
provider "aws" {
    region = var.aws_region
}

data "availability_zones" "available" {
    state = "available"
  
}
module "network" {
    source = "./modules/network"
    vpc_cidr = var.vpc_cidr
    private_subnet_cidr = var.private_subnet_cidr
    public_subnet_cidr = var.public_subnet_cidr
    project_name = var.project_name
    availability_zones = data.availability_zones.available.names
  
}

module "ecr" {
    source = "./modules/ecr"
    project_name = var.project_name
    container_image = var.container_image
  
}
module "ecs" {
    source = "./modules/ecs"
    project_name = var.project_name
    vpc_id = module.network.vpc_id
    private_subnet_ids = module.network.private_subnet_ids
    alb_target_group_arn = module.alb.target_group_arn
    alb_security_group_id = module.alb_security_group_id
}

module "alb" {
    source = "./modules/alb"
    vpc_id = module.network.vpc_id
    public_subnet_ids = module.network.public_subnet_ids
    project_name = var.project_name
    tags = var.tags
}
module "ci_cd_ecs_pipeline" {
    source = "./modules/ci_cd_ecs_pipeline"
    project_name = var.project_name
    ecs_cluster_name = var.ecs_cluster_name
    ecr_repository_url = module.ecr.repository_url
    ecs_task_memory = var.ecs_task_memory
    ecs_task_cpu = var.ecs_task_cpu
    container_port = var.container_port
}