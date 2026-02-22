variable "ecr_repo_url" {
  description = "ECR repository URL"
  type        = string
}

variable "role_arn" {
  description = "IAM role ARN for Jenkins service account (IRSA)"
  type        = string
}

variable "namespace" {
  type    = string
  default = "jenkins"
}