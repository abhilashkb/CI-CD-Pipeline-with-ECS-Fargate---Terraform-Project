output "vpc_id" {
  description = "The ID of the VPC created by this module."
  value       = aws_vpc.main.id
  
}
output "vpc_cidr_block" {
  description = "The CIDR block of the VPC."
  value       = aws_vpc.main.cidr_block
  
}
output "public_subnet_ids" {
  description = "List of IDs of the public subnets created by this module."
  value       = aws_subnet.public[*].id
  
}
output "private_subnet_ids" {
  description = "List of IDs of the private subnets created by this module."
  value       = aws_subnet.private[*].id
  
}
output "internet_gateway_id" {
  description = "The ID of the internet gateway created for the VPC."
  value       = aws_internet_gateway.main.id
  
}

output "nat_gateway_id" {
    description = "The ID of the NAT gateway created for the VPC."
    value       = aws_nat_gateway.main[*].id
}