variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "django-eks-project"
}

variable "database_password" {
  description = "RDS PostgreSQL password"
  type        = string
  sensitive   = true
}