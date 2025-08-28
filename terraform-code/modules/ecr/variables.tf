variable "project_name" {
  description = "The name of the project to be used as a prefix for the ECR repository."
  type        = string
  
}
variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}