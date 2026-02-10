provider "aws" {
  region = "eu-central-1"
}

data "aws_vpc" "existing" {
  tags = {
    Name = "lesson-5-vpc"
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.existing.id]
  }
}



resource "aws_ecr_repository" "django" {
  name = "django-app"
}

module "eks" {
  source       = "./modules/eks"
  vpc_id       = data.aws_vpc.existing.id
  subnet_ids   = data.aws_subnets.public.ids
  cluster_name = "lesson-7-eks"
}