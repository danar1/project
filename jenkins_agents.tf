resource "aws_instance" "jenkins_agent" {
  count                       = var.jenkins_agent_count
  # ami                         = "ami-04d29b6f966df1537"
  ami                         = "ami-09216d64cce02bbb5"
  # my project Jenkins agent i used: ami-09216d64cce02bbb5
  instance_type               = var.instance_type
  subnet_id                   = module.vpc.private_subnets[count.index]
  associate_public_ip_address = false
  key_name                    = aws_key_pair.project_key.key_name
  iam_instance_profile        = aws_iam_instance_profile.instance_profile.name

  tags = merge(local.common_tags, map("Name", "Jenkins Agent"))

  # security_groups = ["default", aws_security_group.jenkins-sg.name]
  # security_groups = [aws_security_group.jenkins-sg.name]
  vpc_security_group_ids      = [aws_security_group.jenkins-agent-sg.id]
  depends_on                  = [module.vpc.nat_gw, module.eks.cluster_id]

  # connection {
  #   host = aws_instance.jenkins_agent.public_ip
  #   user = "ec2-user"
  #   private_key = file("project_key.pem")
  # }


  connection {
    bastion_host = aws_instance.bastion[count.index].public_ip
    host         = self.private_ip
    bastion_user = "ubuntu"
    user         = "ec2-user"
    private_key  = file(var.key_file)
  }

# this
#   provisioner "remote-exec" {
#     inline = [
#       "sudo yum update -y",
#       "sudo yum install docker git java-1.8.0 -y",
#       "sudo systemctl enable docker",
#       "sudo service docker start",
#       "sudo usermod -aG docker ec2-user",
#       "aws eks --region=${var.aws_region} update-kubeconfig --name ${local.cluster_name}",
#       "curl -LO https://storage.googleapis.com/kubernetes-release/release/v${var.kubectl_version}/bin/linux/amd64/kubectl",
#       "chmod +x ./kubectl",
#       "sudo mv ./kubectl /usr/local/bin/kubectl",
#       "sudo yum install python3 -y"
#     ]
#   }
# }

provisioner "remote-exec" {
    inline = [
      "aws eks --region=${var.aws_region} update-kubeconfig --name ${local.cluster_name}"
    ]
  }
}

resource "aws_security_group" "jenkins-agent-sg" {
  name = "jenkins-agent-sg"
  vpc_id = module.vpc.id
  description = "Allow Jenkins agent inbound traffic"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = [aws_security_group.jenkins-master-sg.id, aws_security_group.bastion-ssh.id]
  }

  egress {
    description = "Allow all outgoing traffic"
    from_port = 0
    to_port = 0
    // -1 means all
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  
  tags = {
    Name = "jenkins-agent-sg"
  }
}




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