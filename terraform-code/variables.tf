variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-west-2"
  
}
variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "my_project"
  
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0/16"
  
}

variable "private_subnet_cidr" {
  description = "The CIDR block for the private subnet"
  type        = string
  default     = "10.0.1/24"
  
}
variable "public_subnet_cidr" {
  description = "The CIDR block for the second private subnet"
  type        = string
  default     = "10.0.2/24"
  
}
variable "container_port" {
  description = "The port on which the container will listen"
  type        = number
  default     = 8080
  
}
variable "container_image" {
  description = "The Docker image to use for the container"
  type        = string
  default     = "nginx:latest"
  
}
variable "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
  default     = "my_ecs_cluster"
  
}

variable "ecs_task_memory" {
  description = "The amount of memory (in MiB) to allocate for the ECS task"
  type        = number
  default     = 512 
  
}
variable "ecs_task_cpu" {
  description = "The amount of CPU units to allocate for the ECS task"
  type        = number
  default     = 256
  
}
variable "ecs_service_desired_count" {
  description = "The desired number of tasks in the ECS service"
  type        = number
  default     = 1
  
}

variable "codecommit_branch_name" {
  description = "The name of the CodeCommit branch to use"
  type        = string
  default     = "main"
  
}

variable "codecommit_repository_name" {
  description = "The name of the CodeCommit repository"
  type        = string
  default     = "my_codecommit_repo"
  
}
variable "tags" {
  description = "A map of tags to apply to all resources"
  type        = map(string)
  default     = {
    Environment = "development"
    Project     = "ci_cd_ecs_pipeline"
    managed_by = "Terraform"

  }
  
}