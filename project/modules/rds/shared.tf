resource "aws_security_group" "rds" {
  name        = "${var.project_name}-rds-sg"
  description = "Security group for PostgreSQL RDS"
  vpc_id      = var.vpc_id

  ingress {
    description = "PostgreSQL from VPC"
    protocol    = "tcp"
    from_port   = var.database_port
    to_port     = var.database_port
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    description = "Allow outbound traffic"
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-rds-sg"
  }
}

resource "aws_db_subnet_group" "main" {
  name = "${var.project_name}-db-subnet-group"

  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.project_name}-db-subnet-group"
  }
}