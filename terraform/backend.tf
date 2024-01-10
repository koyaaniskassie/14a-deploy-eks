# terraform {
#   backend "s3" {
#     bucket         = "14a-sbx-tfbackend-tfstatefiles"
#     key            = "eks.tfstate"
#     dynamodb_table = "14a-sbx-tfstatelock"
#     region         = "eu-central-1"
#     profile        = "sandbox"
#   }
# }