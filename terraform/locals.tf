locals {
  general = merge(
    yamldecode(try(file("defaults/general.yaml"), "{}")),
    yamldecode(try(file("${terraform.workspace}/general.yaml"), "{}"))
  )
  s3 = merge(
    yamldecode(try(file("defaults/s3.yaml"), "{}")),
    yamldecode(try(file("${terraform.workspace}/s3.yaml"), "{}"))
  )
}
