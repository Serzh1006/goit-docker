data "aws_availability_zones" "available" {}

module "vpc" {
  source     = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
  azs        = data.aws_availability_zones.available.names
}

module "ecr" {
  source = "./modules/ecr"
  name   = "django-app"
}

module "eks" {
  source       = "./modules/eks"
  cluster_name = "dev-eks"
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.private_subnet_ids
}

module "irsa_jenkins" {
  source            = "./modules/irsa-jenkins"
  oidc_provider_arn = module.eks.oidc_provider_arn
  cluster_name      = module.eks.cluster_name
}

module "jenkins" {
  source       = "./modules/jenkins"
  role_arn     = module.irsa_jenkins.role_arn
  ecr_repo_url = module.ecr.repository_url
  depends_on   = [module.eks]
}

module "argo_cd" {
  source     = "./modules/argo_cd"
  depends_on = [module.eks]
}