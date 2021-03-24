variable "kubernetes_version" {
  default = 1.18
  description = "kubernetes version"
}

variable "aws_region" {
  default = "us-east-1"
  description = "aws region"
}

locals {
  k8s_service_account_namespace = "default"
  k8s_service_account_name      = "opsschool-sa"
}