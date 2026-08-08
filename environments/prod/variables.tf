variable "aws_region" { type = string }
variable "aws_account_id" { type = string }
variable "cluster_name" { type = string }
variable "vpc_cidr" { type = string }
variable "public_subnet_cidrs" { type = list(string) }
variable "azs" { type = list(string) }
variable "ecr_repositories" { type = list(string) }