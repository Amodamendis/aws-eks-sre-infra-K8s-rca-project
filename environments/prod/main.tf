terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region              = var.aws_region
  allowed_account_ids = [var.aws_account_id]
}

module "vpc" {
  source              = "../../modules/vpc"
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  azs                 = var.azs
  cluster_name        = var.cluster_name
}

module "iam-roles" {
  source       = "../../modules/iam-roles"
  cluster_name = var.cluster_name
}

module "security-groups" {
  source       = "../../modules/security-groups"
  vpc_id       = module.vpc.vpc_id
  cluster_name = var.cluster_name
}

module "eks" {
  source             = "../../modules/eks"
  cluster_name       = var.cluster_name
  subnet_ids         = module.vpc.public_subnet_ids
  cluster_role_arn   = module.iam-roles.cluster_role_arn
  node_role_arn      = module.iam-roles.node_role_arn
  node_sg_id         = module.security-groups.node_sg_id
}

module "ecr" {
  source       = "../../modules/ecr"
  repositories = var.ecr_repositories
}