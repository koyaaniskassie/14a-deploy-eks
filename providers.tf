provider "aws" {
  region  = var.aws_region
  profile = terraform.workspace
}