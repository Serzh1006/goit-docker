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

resource "kubernetes_service_account" "jenkins" {

  metadata {

    name      = "jenkins"
    namespace = kubernetes_namespace.jenkins.metadata[0].name

    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.jenkins.arn
    }
  }
}

resource "kubernetes_service_account" "jenkins" {

  metadata {

    name = "jenkins"

    namespace = kubernetes_namespace.jenkins.metadata[0].name

    annotations = {
      "eks.amazonaws.com/role-arn" = var.jenkins_role_arn
    }
  }
}