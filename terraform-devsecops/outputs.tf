output "ecr_repository_url" {
  value = aws_ecr_repository.app.repository_url
}

output "s3_state_bucket" {
  value = aws_s3_bucket.terraform_state.bucket
}

output "aws_account_id" {
  value = data.aws_caller_identity.current.account_id
}
