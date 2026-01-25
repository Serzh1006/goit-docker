## Lesson 5 – Terraform AWS Infrastructure

### Опис

Проєкт створює:

- S3 + DynamoDB для Terraform backend
- VPC з публічними та приватними підмережами
- ECR репозиторій

### Команди

terraform init  
terraform plan  
terraform apply  
terraform destroy

### Модулі

- s3-backend – збереження Terraform state
- vpc – мережева інфраструктура
- ecr – Docker image repository
