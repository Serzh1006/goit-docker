resource "aws_db_instance" "postgres" {
  identifier = "${var.project_name}-postgres"

  engine         = "postgres"
  engine_version = "17"

  instance_class = var.instance_class

  allocated_storage = var.allocated_storage
  storage_type      = "gp3"
  storage_encrypted = true

  db_name  = var.database_name
  username = var.database_username
  password = var.database_password
  port     = var.database_port

  db_subnet_group_name = aws_db_subnet_group.main.name

  vpc_security_group_ids = [
    aws_security_group.rds.id
  ]

  publicly_accessible = false

  multi_az = false

  backup_retention_period = 7

  backup_window = "03:00-04:00"

  maintenance_window = "sun:04:00-sun:05:00"

  skip_final_snapshot = true

  deletion_protection = false

  auto_minor_version_upgrade = true

  apply_immediately = true

  tags = {
    Name = "${var.project_name}-postgres"
  }
}