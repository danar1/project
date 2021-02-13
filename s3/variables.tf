# s3 module vars
variable "bucket" {
  type    = string
  # default = "project-ops-state-bucket"
}

variable "acl" {
  type    = string
  # default = "private"
}

variable "versioning" {
  type    = bool
}

variable "aws_region" {
  description = "AWS region"
}

variable "s3_to_ec2_role_name" {
  type    = string
  # default = "project-ops-ec2-to-s3-iam-role"
}

variable "s3_policy_name" {
  type    = string
  # default = "project-ops-s3-policy"
}

variable "tags" {
  description = "Common tags for the S3 bucket and role"
  type        = map(string)
}

variable "s3_tags" {
  description = "Additional tags for the S3 bucket"
  type        = map(string)
  # default     = {}
}

variable "s3_to_ec2_role_tags" {
  description = "A map of tags to add to all ec2 iam role"
  type        = map(string)
  # default     = {}
}