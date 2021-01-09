##################################################################################
# S3
##################################################################################
# bucket, role, instance profile
module "s3" {
  source            = "../modules/s3"
  aws_region        = var.aws_region
  bucket            = var.bucket
  acl               = var.acl
  versioning        = var.versioning
  role_name         = var.role_name
  s3_policy_name    = var.s3_policy_name
  tags              = var.tags
  s3_tags           = var.s3_tags
  ec2_iam_role_tags = var.ec2_iam_role_tags
}