data "aws_eks_cluster" "cluster" {
  name  = module.eks.cluster_name
}

provider "kubernetes" {
  config_path = "~/.kube/config"
  config_context =  data.aws_eks_cluster.cluster.arn 
}

provider "aws" {
  region  = var.aws_region
  profile = terraform.workspace
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}