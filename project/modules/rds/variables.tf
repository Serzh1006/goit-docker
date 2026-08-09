variable "project_name" {
  description = "Project name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "Private subnet IDs"
  type        = list(string)
}

variable "database_name" {
  description = "Database name"
  type        = string
  default     = "django_db"
}

variable "database_username" {
  description = "Database username"
  type        = string
  default     = "django_user"
}

variable "database_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "database_port" {
  description = "PostgreSQL port"
  type        = number
  default     = 5432
}

variable "instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Allocated storage in GB"
  type        = number
  default     = 20
}