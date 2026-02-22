terraform {
  backend "s3" {
    bucket         = "my-eu-terraform-state-12345"
    key            = "project/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}