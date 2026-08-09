output "bucket_name" {
  description = "Terraform state S3 bucket"
  value       = aws_s3_bucket.terraform_state.bucket
}


output "bucket_arn" {
  description = "Terraform state S3 bucket ARN"
  value       = aws_s3_bucket.terraform_state.arn
}


output "dynamodb_table_name" {
  description = "Terraform state lock DynamoDB table"
  value       = aws_dynamodb_table.terraform_lock.name
}