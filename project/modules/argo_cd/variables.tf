variable "project_name" {
  description = "Project name"
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "cluster_endpoint" {
  description = "EKS cluster endpoint"
  type        = string
}

variable "cluster_ca_certificate" {
  description = "EKS cluster CA certificate"
  type        = string
}

variable "namespace" {
  description = "Argo CD namespace"
  type        = string
  default     = "argocd"
}

variable "argo_cd_chart_version" {
  description = "Argo CD Helm chart version"
  type        = string
  default     = "9.1.2"
}

variable "git_repository" {
  description = "Git repository containing Helm charts"
  type        = string
}