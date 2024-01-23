data "aws_iam_policy" "administrator_access" {
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

locals {
  oidc = module.eks.oidc_provider_arn
  lb_controller_policy = file("${path.module}/lb_controller_policy.json")
}


resource "aws_iam_role" "crossplane" {
  name = "crossplane"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Federated = "${local.oidc}"
        }
      }
    ]
  })

  tags = {
    terraform = "true"
  }
}

resource "aws_iam_role_policy_attachment" "administrator_access_for_crossplane" {
   role       = "${aws_iam_role.crossplane.name}"
   policy_arn = "${data.aws_iam_policy.administrator_access.arn}"
}



########### Role and policy required for ingress and load balancer integration

resource "aws_iam_policy" "lb_controller_policy" {
  name        = "lb_controller_policy"
  policy = local.lb_controller_policy
}

resource "aws_iam_role" "lb_controller" {
  name = "AWSLoadBalancerControllerIAMPolicy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Federated = "${local.oidc}"
        }
      }
    ]
  })

  tags = {
    terraform = "true"
  }
}

resource "aws_iam_role_policy_attachment" "lb_controller_for_eks" {
   role       = "${aws_iam_role.lb_controller.name}"
   policy_arn = "${resource.aws_iam_policy.lb_controller_policy.arn}"
}