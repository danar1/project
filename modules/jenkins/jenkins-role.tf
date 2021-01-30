##################################################################################
# Role (ec2 iam), instance profile
##################################################################################

# EC2 IAM role
resource "aws_iam_role" "ec2-iam-role" {
  name = var.ec2_role_name
  tags = merge(local.common_tags, map("Name", "project-ec2-iam-role"))

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# Provides an IAM role inline policy 
resource "aws_iam_role_policy" "ec2-full-access" {
  name = var.ec2_policy_name
  role = aws_iam_role.ec2-iam-role.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "eks:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF

}

# Instance profile - Create instance profile with the ec2 iam role
resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.ec2_role_name}_instance_profile"
  role = aws_iam_role.ec2-iam-role.name
}