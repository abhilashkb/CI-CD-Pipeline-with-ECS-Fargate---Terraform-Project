variable "project_name" {
  description = "The name of the project, used for naming resources."
  type        = string
  
}
variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
   
}
variable "private_subnet_cidr" {
  description = "The CIDR block for the private subnet."
  type        = string
  
}
variable "public_subnet_cidr" {
    description = "The CIDR block for the public subnet."
    type        = string
  
}
variable "availability_zones" {
  description = "List of availability zones to use for the subnets."
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b", "us-west-2c"]
  
}
variable "tags" {
  description = "A map of tags to apply to all resources."
  type        = map(string)
  default     = {
    Environment = "production"
  }
}