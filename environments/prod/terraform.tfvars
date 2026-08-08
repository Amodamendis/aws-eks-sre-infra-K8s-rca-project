aws_region          = "ap-southeast-1"
aws_account_id      = "619891987476"
cluster_name        = "sre-agent-cluster"
vpc_cidr            = "10.0.0.0/16"
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
azs                 = ["ap-southeast-1a", "ap-southeast-1b"]
ecr_repositories    = ["chaos-bait-app", "gemini-sre-agent"]