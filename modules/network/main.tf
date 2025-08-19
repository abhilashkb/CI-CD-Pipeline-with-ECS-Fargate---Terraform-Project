# Create VPC

resource "aws_vpc" "my_project" {

 cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
  
}

# Create Internet Gateway
# This gateway allows the VPC to connect to the internet
# It is essential for enabling internet access for resources in the VPC
resource "aws_internet_gateway" "my_project" {
  vpc_id = aws_vpc.my_project.id

  tags = {
    Name = "${var.project_name}-igw"
  }
  
}

# Create public and private subnets
# Public subnets will have direct access to the internet
resource "aws_subnet" "public" {
  count = length(var.availability_zones)

  vpc_id            = aws_vpc.my_project.id
  cidr_block        = cidrsubnet(var.public_subnet_cidr, 8, count.index)
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "${var.project_name}-public-subnet-${count.index + 1}"
  }  
}

# Create private subnets
# Private subnets will not have direct access to the internet
# They will route internet-bound traffic through a NAT gateway

resource "aws_subnet" "private" {
  count = length(var.availability_zones)

  vpc_id            = aws_vpc.my_project.id
  cidr_block        = cidrsubnet(var.private_subnet_cidr, 8, count.index)
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "${var.project_name}-private-subnet-${count.index + 1}"
  }  
  
}
/* 
# Create NAT Gateway
# This gateway allows instances in the private subnets to access the internet
resource "aws_eip" "nat" {
  count = length(var.availability_zones)

  vpc = true

  tags = {
    Name = "${var.project_name}-nat-eip-${count.index + 1}"
  }  
  
}

# Create NAT Gateway for each availability zone
# Each NAT gateway will be associated with a public subne
resource "aws_nat_gateway" "my_project" {
  count = length(var.availability_zones)

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = {
    Name = "${var.project_name}-nat-gateway-${count.index + 1}"
  }
  depends_on = [aws_internet_gateway.my_project]  
}  */

# Create route table for public subnets
# This route table will route traffic to the internet gateway for outbound internet access

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.my_project.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_project.id
  }
}

# Create route table associations for public subnets
# This associates the public subnets with the public route table

resource "aws_route_table_association" "public" {
  count = length(var.availability_zones)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}
# Create route table for private subnets
# This route table will route traffic to the NAT gateway for outbound internet access
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.my_project.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.my_project[count.index].id
  }
}

# Create route table associations for private subnets
# This associates the private subnets with the private route table
# Each private subnet will have its own route table association
resource "aws_route_table_association" "private" {
  count = length(var.availability_zones)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

# Route Table Associations for Public Subnets

resource "aws_route_table_association" "public" {
  count = length(var.availability_zones)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}
#Route Table Associations for Private Subnets
resource "aws_route_table_association" "private" {
  count = length(var.availability_zones)
  
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
