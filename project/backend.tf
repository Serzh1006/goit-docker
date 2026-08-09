terraform {
  backend "s3" {
    bucket         = "django-eks-project-terraform-state"
    key            = "terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    dynamodb_table = "django-eks-project-terraform-lock"
  }
}