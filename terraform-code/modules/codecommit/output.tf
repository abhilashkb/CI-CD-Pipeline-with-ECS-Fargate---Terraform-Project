output "repository_arn" {
    description = "The ARN of the CodeCommit repository."
    value       = aws_codecommit_repository.main.arn
  
}
output "repository_clone_url_http" {
    description = "The HTTP clone URL of the CodeCommit repository."
    value       = aws_codecommit_repository.main.clone_url_http
  
}
output "repository_clone_url_ssh" {
    description = "The SSH clone URL of the CodeCommit repository."
    value       = aws_codecommit_repository.main.clone_url_ssh
  
}
output "repository_id" {
    description = "The ID of the CodeCommit repository."
    value       = aws_codecommit_repository.main.id
  
}
