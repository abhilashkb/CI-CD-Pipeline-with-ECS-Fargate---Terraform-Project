resource "aws_security_group" "alb" {
    name        = "${var.project_name}-alb-sg"
    description = "Security group for the Application Load Balancer"
    vpc_id      = var.vpc_id
    
ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
  
}
ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  
}

egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    
}
tags = merge(var.tags, {
        Name = "${var.project_name}-alb-sg"
    })
}
resource "aws_security_group" "ecs" {
    name        = "${var.project_name}-ecs-sg"
    description = "Security group for ECS tasks"
    vpc_id      = var.vpc_id
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        security_groups = [aws_security_group.alb.id]
    }
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        security_groups = [aws_security_group.alb.id]
    }

# Allow all outbound traffic

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

# Allow traffic on port 8080 from ALB (common for containerized apps)

  ingress {
       from_port  = 8080
       to_port    = 8080
       protocol   = "tcp"
       cidr_blocks = ["0.0.0.0/0"]
  }

tags = merge(var.tags, {
        Name = "${var.project_name}-ecs-sg"
    })
}