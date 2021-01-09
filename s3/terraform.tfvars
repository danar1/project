# s3 module set vars
bucket         = "project-tf-state-bucket"
acl            = "private"
versioning     = true
aws_region     = "us-east-1"
role_name      = "project-ec2-to-s3-iam-role"
s3_policy_name = "project-s3-policy"
tags = {
    Purpose    = "project"
    Owner      = "dana"
    }
s3_tags        = {
    Name = "project-tf-state-bucket"
    }
ec2_iam_role_tags = {
    Name = "project-ec2-to-s3-iam-role"
    }








