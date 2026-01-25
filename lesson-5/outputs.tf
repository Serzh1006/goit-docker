output "s3_bucket_url" {
  value = module.s3_backend.s3_bucket_url
}

output "dynamodb_table_name" {
  value = module.s3_backend.dynamodb_table_name
}

output "ecr_repository_url" {
  value = module.ecr.repository_url
}