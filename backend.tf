terraform {
  backend "s3" {
    bucket = "project-tf-state-bucket"
    key    = "project/tf-state"
    region = var.aws_region
  }
}