variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "oidc_provider_arn" {
  description = "OIDC provider ARN for EKS"
  type        = string
}

variable "namespace" {
  description = "Namespace for Jenkins"
  type        = string
  default     = "jenkins"
}

variable "service_account_name" {
  description = "ServiceAccount name for Jenkins"
  type        = string
  default     = "jenkins"
}