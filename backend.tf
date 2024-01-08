terraform {
  backend "s3" {
    bucket         = "a14-sbx-tfbackend-tfstatefiles"
    key            = "backend.tfstate"
    dynamodb_table = "14a-sbx-tfstatelock"
    region         = "eu-central-1"
    profile        = "sandbox"
  }
}