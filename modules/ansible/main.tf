##################################################################################
# Ansible instance
##################################################################################
resource "aws_instance" "ansible" {
  count                       = var.ansible_count
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = element(var.subnet_ids, count.index)
  associate_public_ip_address = false
  key_name                    = var.key_name
  iam_instance_profile        = aws_iam_instance_profile.instance_profile.name
  # vpc_security_group_ids      = var.ansible-sg # [aws_security_group.bastion-ssh.id]
  vpc_security_group_ids      = [aws_security_group.ansible-sg.id]
  tags = merge(var.tags, map("Name", "ansible-${count.index}"))

  
  connection {
    bastion_host = var.bastion_public_ips[count.index]
    host         = self.private_ip
    bastion_user = "ubuntu"
    user         = "ubuntu"
    private_key  = file(var.key_file)
  }

  provisioner "file" {
    source      = var.ansible_folder
    destination = "/home/ubuntu"
  }

  provisioner "file" {
    source      = var.key_file
    destination = "/home/ubuntu/.ssh"
  }
}

##################################################################################
# Role (ec2 iam), instance profile
##################################################################################

# EC2 IAM role
resource "aws_iam_role" "ec2-iam-role" {
  name = var.ansible_ec2_role_name
  tags = merge(var.tags, map("Name", var.ansible_ec2_role_name))

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
resource "aws_iam_role_policy" "ansible-ec2-full-access" {
  name = var.ansible_ec2_policy_name
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
    }
  ]
}
EOF

}

# Instance profile - Create instance profile with the ec2 iam role
resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.ansible_ec2_role_name}_instance_profile"
  role = aws_iam_role.ec2-iam-role.name
}
