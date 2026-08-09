resource "aws_ecr_repository" "django" {
  name = "${var.project_name}/django"

  image_scanning_configuration {
    scan_on_push = true
  }

  image_tag_mutability = "MUTABLE"

  tags = {
    Name = "${var.project_name}-django"
  }
}