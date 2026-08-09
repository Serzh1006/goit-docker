resource "kubernetes_namespace" "argocd" {
  metadata {
    name = var.namespace
  }
}


resource "helm_release" "argocd" {
  name = "argocd"

  repository = "https://argoproj.github.io/argo-helm"

  chart = "argo-cd"

  version = var.argo_cd_chart_version

  namespace = kubernetes_namespace.argocd.metadata[0].name

  create_namespace = false

  values = [
    file("${path.module}/values.yaml")
  ]

  timeout = 900

  wait = true

  depends_on = [
    kubernetes_namespace.argocd
  ]
}