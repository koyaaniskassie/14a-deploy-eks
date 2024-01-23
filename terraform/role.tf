data "aws_iam_policy" "administrator_access" {
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

locals {
  oidc = module.eks.oidc_provider_arn
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
      },
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