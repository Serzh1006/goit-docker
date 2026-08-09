output "namespace" {
  description = "Jenkins namespace"
  value       = kubernetes_namespace.jenkins.metadata[0].name
}


output "service_name" {
  description = "Jenkins Kubernetes service"
  value       = "jenkins"
}


output "port_forward_command" {
  description = "Command to access Jenkins locally"
  value       = "kubectl port-forward svc/jenkins 8080:8080 -n ${var.namespace}"
}