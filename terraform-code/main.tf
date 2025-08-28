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
 

data "aws_availability_zones" "available" {
  # You can add a filter here if you need to, e.g., to only include a specific zone group
}
module "network" {
    source = "./modules/network"
    vpc_cidr = var.vpc_cidr
    private_subnet_cidr = var.private_subnet_cidr
    public_subnet_cidr = var.public_subnet_cidr
    project_name = var.project_name
    availability_zones = data.aws_availability_zones.available.names
  
}


module "security_groups" {
    source = "./modules/security_groups"
    vpc_id = module.network.vpc_id
    project_name = var.project_name
    tags = var.tags
  
}
module "ecr" {
    source = "./modules/ecr"
    project_name = var.project_name
    tags = var.tags
  
}
module "codecommit" {
    source = "./modules/codecommit"
    project_name = var.project_name
    tags = var.tags
  
}
