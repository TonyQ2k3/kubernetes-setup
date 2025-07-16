resource "aws_eks_cluster" "k8s-cluster" {
  name     = var.cluster_name
  role_arn = var.role_arn
  version  = "1.33"

  vpc_config {
    subnet_ids = var.subnet_ids
  }
}

resource "aws_eks_node_group" "k8s-node-group" {
  cluster_name    = aws_eks_cluster.k8s-cluster.name
  node_group_name = "${var.cluster_name}-node-group"
  node_role_arn   = var.role_arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = 3
    max_size     = 3
    min_size     = 3
  }

  update_config {
    max_unavailable = 1
  }

  instance_types = ["t3.medium"]

  depends_on = [aws_eks_cluster.k8s-cluster]
}

resource "aws_eks_addon" "coredns" {
  cluster_name  = aws_eks_cluster.k8s-cluster.name
  addon_name    = "coredns"
  addon_version = "v1.12.1-eksbuild.2"
  depends_on    = [aws_eks_cluster.k8s-cluster, aws_eks_node_group.k8s-node-group]
}

resource "aws_eks_addon" "kube-proxy" {
  cluster_name  = aws_eks_cluster.k8s-cluster.name
  addon_name    = "kube-proxy"
  addon_version = "v1.33.0-eksbuild.2"
  depends_on    = [aws_eks_cluster.k8s-cluster]
}

resource "aws_eks_addon" "vpc-cni" {
  cluster_name  = aws_eks_cluster.k8s-cluster.name
  addon_name    = "vpc-cni"
  addon_version = "v1.19.5-eksbuild.1"
  depends_on    = [aws_eks_cluster.k8s-cluster]
}

resource "aws_eks_addon" "eks-pod-identity-agent" {
  cluster_name  = aws_eks_cluster.k8s-cluster.name
  addon_name    = "eks-pod-identity-agent"
  addon_version = "v1.3.7-eksbuild.2"
  depends_on    = [aws_eks_cluster.k8s-cluster]
}