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
  role_name         = var.s3_to_ec2_role_name
  s3_policy_name    = var.s3_policy_name
  tags              = var.tags
  s3_tags           = var.s3_tags
  s3_to_ec2_role_tags = var.s3_to_ec2_role_tags
}