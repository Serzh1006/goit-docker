
# Terraform RDS Модуль

Цей Terraform модуль дозволяє створювати **AWS RDS інстанс** або **Aurora Cluster** з єдиної конфігурації.

Модуль автоматично створює:
- DB Subnet Group
- Security Group
- Parameter Group
- RDS instance або Aurora Cluster (залежно від параметра `use_aurora`)

---

# Приклад використання модуля

```hcl
module "rds" {
  source = "./modules/rds"

  name       = "myapp-db"
  use_aurora = false

  # Налаштування RDS
  engine                     = "postgres"
  engine_version             = "17.2"
  parameter_group_family_rds = "postgres17"

  # Налаштування Aurora
  engine_cluster                = "aurora-postgresql"
  engine_version_cluster        = "15.3"
  parameter_group_family_aurora = "aurora-postgresql15"

  instance_class    = "db.t3.medium"
  allocated_storage = 20

  db_name  = "myapp"
  username = "postgres"
  password = "example-password"

  subnet_private_ids = ["subnet-123456", "subnet-654321"]
  subnet_public_ids  = ["subnet-111111", "subnet-222222"]

  vpc_id = "vpc-123456"

  publicly_accessible     = true
  multi_az                = true
  backup_retention_period = 7

  parameters = {
    max_connections = "200"
  }

  tags = {
    Environment = "dev"
    Project     = "myapp"
  }
}
```

---

# Як змінити тип бази даних

## Звичайний RDS

```hcl
use_aurora = false
engine     = "postgres"
```

Terraform створить ресурс:
- `aws_db_instance`

## Aurora

```hcl
use_aurora = true
engine_cluster = "aurora-postgresql"
```

Terraform створить:
- `aws_rds_cluster`
- `aws_rds_cluster_instance`

---

# Як змінити engine

```hcl
engine = "postgres"
engine_version = "17.2"
```

Приклад для MySQL:

```hcl
engine = "mysql"
engine_version = "8.0"
```

---

# Як змінити клас інстансу

```hcl
instance_class = "db.t3.micro"
instance_class = "db.t3.medium"
instance_class = "db.m6g.large"
```

---

# Опис змінних

| Змінна | Опис | Тип |
|------|------|------|
| name | Назва ресурсів БД | string |
| use_aurora | Перемикач Aurora / RDS | bool |
| engine | Engine для RDS | string |
| engine_version | Версія engine | string |
| engine_cluster | Engine для Aurora | string |
| engine_version_cluster | Версія Aurora | string |
| instance_class | Клас інстансу | string |
| allocated_storage | Розмір диску | number |
| db_name | Назва БД | string |
| username | Користувач | string |
| password | Пароль | string |
| subnet_private_ids | Приватні subnet | list(string) |
| subnet_public_ids | Публічні subnet | list(string) |
| vpc_id | ID VPC | string |
| publicly_accessible | Публічний доступ | bool |
| multi_az | Multi‑AZ | bool |
| backup_retention_period | Дні зберігання backup | number |
| parameters | Параметри БД | map(string) |
| tags | Теги | map(string) |

---

# Outputs

| Output | Опис |
|------|------|
| endpoint | Endpoint БД |
| port | Порт |
| security_group_id | ID security group |
