output "alb_security_group_id" {
  description = "The ID of the security group for the Application Load Balancer."
  value       = aws_security_group.alb.id
  
}
output "ecs_security_group_id" {
  description = "The ID of the security group for ECS tasks."
  value       = aws_security_group.ecs.id
  
}