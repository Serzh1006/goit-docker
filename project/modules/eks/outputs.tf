output "cluster_name" {
  description = "EKS cluster name"
  value       = aws_eks_cluster.main.name
}


output "cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = aws_eks_cluster.main.endpoint
}


output "cluster_ca_certificate" {
  description = "EKS cluster CA certificate"
  value       = aws_eks_cluster.main.certificate_authority[0].data
}


output "cluster_security_group_id" {
  description = "EKS cluster security group ID"
  value       = aws_security_group.eks_cluster.id
}


output "node_group_name" {
  description = "EKS node group name"
  value       = aws_eks_node_group.main.node_group_name
}


output "oidc_issuer" {
  description = "EKS OIDC issuer"
  value       = aws_eks_cluster.main.identity[0].oidc[0].issuer
}