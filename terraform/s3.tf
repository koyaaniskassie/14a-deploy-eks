module "s3" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.15.1"

  bucket = local.s3.bucket

  versioning = local.s3.versioning
}