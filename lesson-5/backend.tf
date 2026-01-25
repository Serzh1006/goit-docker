terraform {
  backend "s3" {
    bucket         = "tfstate-680528875447-eu-central-1"
    key            = "lesson-5/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}