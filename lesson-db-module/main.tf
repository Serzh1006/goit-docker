module "rds" {
  source = "./modules/rds"

  name                  = "myapp-db"
  use_aurora            = false
  aurora_instance_count = 2

  engine                     = "postgres"
  engine_version             = "17.2"
  parameter_group_family_rds = "postgres17"

  instance_class   = "db.t3.medium"
  allocated_storage = 20
  db_name           = "myapp"
  username          = "postgres"
  password          = "admin123AWS23"

  subnet_private_ids = [
    "subnet-123456",
    "subnet-654321"
  ]

  subnet_public_ids = [
    "subnet-111111",
    "subnet-222222"
  ]

  vpc_id = "vpc-123456"

  publicly_accessible     = true
  multi_az                = true
  backup_retention_period = 7
}
