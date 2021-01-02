##################################################################################
# TERRAFORM
##################################################################################

terraform {
  required_version = "0.13.4"
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 2.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.11.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 1.2"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 2.1"
    }
    template = {
      source  = "hashicorp/template"
      version = "~> 2.1"
    }
  }
}