resource "aws_ecr_repository" "main" {
  name                 = "${var.project_name}-repository"
  image_tag_mutability = "MUTABLE"

  tags = var.tags

  image_scanning_configuration {
    scan_on_push = true
  }
}

#ECR repository policy to allow ECS tasks to pull images
resource "aws_ecr_repository_policy" "main" {
  repository = aws_ecr_repository.main.name

  policy = <<EOF
{
    "version": "2008-10-17",
    "statement": [
        {
            "effect": "Allow",
            "principal": "*",
            "action": [
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "ecr:BatchCheckLayerAvailability"
            ],
            "resource": "${aws_ecr_repository.main.arn}"
        }
    ]
}
EOF
}
resource "aws_ecr_lifecycle_policy" "main" {
  repository = aws_ecr_repository.main.name

  policy = <<EOF
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Expire untagged images older than 10 days",
      "selection": {
        "tagStatus": "untagged",
        "countType": "sinceImagePushed",
        "countUnit": "days",
        "countNumber": 10
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF
}