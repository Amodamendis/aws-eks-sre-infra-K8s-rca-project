resource "aws_eks_cluster" "main" {
  name     = var.cluster_name
  role_arn = var.cluster_role_arn
  version  = "1.30"

  vpc_config {
    subnet_ids             = var.subnet_ids
    endpoint_public_access = true
    security_group_ids     = [var.node_sg_id]
  }
}

resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.cluster_name}-node-group"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids

  ami_type       = "AL2_x86_64"
  instance_types = ["t3.medium"] # Cost-effective but enough RAM for Prometheus

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }
}