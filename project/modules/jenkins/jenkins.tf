resource "kubernetes_namespace" "jenkins" {
  metadata {
    name = var.namespace
  }
}



resource "helm_release" "jenkins" {
  name       = "jenkins"
  repository = "https://charts.jenkins.io"
  chart      = "jenkins"
  namespace  = "jenkins"
  create_namespace = true

  values = [
    templatefile("${path.module}/values.yaml", {
      role_arn = var.role_arn
    })
  ]
}