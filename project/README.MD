# Jenkins + Argo CD + Terraform (AWS EKS, Helm, ECR)

Цей проєкт реалізує повний CI/CD пайплайн у Kubernetes (AWS EKS):

- Terraform створює інфраструктуру (VPC, EKS, ECR)
- Jenkins встановлюється через Helm
- Jenkins працює через Kubernetes Agent (Kaniko + Git)
- Jenkins pipeline:
  - збирає Docker image з Dockerfile
  - пушить image в ECR
  - оновлює image tag у values.yaml Helm-чарта
  - пушить зміни в main
- Argo CD встановлюється через Helm
- Argo CD Application автоматично синхронізує деплой після змін у Git

Регіон AWS: **eu-central-1**

## Вимоги

Встановлені локально:

- Terraform >= 1.5
- AWS CLI
- kubectl
- helm
- доступ до AWS акаунта

## Як застосувати Terraform

terraform init
Створення базової інфраструктури (VPC + EKS + ECR)
terraform apply -target=module.vpc -target=module.ecr -target=module.eks
Повне застосування (Jenkins + Argo CD + Application)
terraform apply

## Як перевірити Jenkins Job

Доступ до Jenkins
kubectl port-forward svc/jenkins 8080:8080 -n jenkins

## Запуск pipeline

    Відкрити Jenkins UI
    Запустити pipeline job кнопкою Build Now

Pipeline:
збирає Docker image через Kaniko
пушить image в ECR
оновлює values.yaml Helm-чарта
пушить зміни в main

## Як побачити результат в Argo CD

Доступ до Argo CD UI

kubectl port-forward svc/argocd-server -n argocd 8081:443

Перевірка деплою
В Argo CD UI знайти Application django-app
Після виконання Jenkins pipeline статус стане Synced / Healthy
В Kubernetes зʼявиться новий pod з новим image tag
kubectl get pods
kubectl describe deployment django-app

## Видалення інфраструктури

terraform destroy
