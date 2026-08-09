resource "kubernetes_namespace" "jenkins" {
  metadata {
    name = var.namespace
  }
}


resource "helm_release" "jenkins" {
  name = "jenkins"

  repository = "https://charts.jenkins.io"

  chart = "jenkins"

  version = var.jenkins_chart_version

  namespace = kubernetes_namespace.jenkins.metadata[0].name

  create_namespace = false

  values = [
    file("${path.module}/values.yaml")
  ]

  timeout = 900

  wait = true

  depends_on = [
    kubernetes_namespace.jenkins
  ]
}