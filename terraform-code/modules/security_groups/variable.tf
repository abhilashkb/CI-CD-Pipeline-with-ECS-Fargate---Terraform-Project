variable "project_name" {
  description = "The name of the project, used for naming resources."
  type        = string
  
}
variable "vpc_id" {
    description = "The ID of the VPC where the security groups will be created."
    type        = string
  
}

variable "tags" {
    description = "A map of tags to apply to all resources."
    type        = map(string)
    default     = {
        Environment = "production"
        Project     = var.project_name
    }        
}