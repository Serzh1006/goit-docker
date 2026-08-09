output "namespace" {
  description = "Argo CD namespace"
  value       = kubernetes_namespace.argocd.metadata[0].name
}


output "server_service" {
  description = "Argo CD server service"
  value       = "argocd-server"
}


output "port_forward_command" {
  description = "Command to access Argo CD"
  value       = "kubectl port-forward svc/argocd-server 8081:443 -n ${var.namespace}"
}