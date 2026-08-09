terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.38"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}


module "vpc" {
  source = "./modules/vpc"

  project_name = var.project_name
  aws_region   = var.aws_region
}


module "ecr" {
  source = "./modules/ecr"

  project_name = var.project_name
}


module "eks" {

  source = "./modules/eks"

  project_name = var.project_name

  vpc_id     = module.vpc.vpc_id

  subnet_ids = module.vpc.private_subnet_ids

  depends_on = [

    module.vpc

  ]

}

module "jenkins" {
  source = "./modules/jenkins"

  project_name = var.project_name

  cluster_name = module.eks.cluster_name

  cluster_endpoint = module.eks.cluster_endpoint

  cluster_ca_certificate = module.eks.cluster_ca_certificate

  depends_on = [
    module.eks
  ]
}


module "rds" {
  source = "./modules/rds"

  project_name = var.project_name

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnet_ids

  database_password = var.database_password

  depends_on = [
    module.vpc
  ]
}