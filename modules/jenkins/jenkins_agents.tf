##################################################################################
# Jenkins agents
##################################################################################
resource "aws_instance" "jenkins_agent" {
  count                       = var.jenkins_agent_count
  # ami                         = "ami-04d29b6f966df1537"
  ami                         = "ami-09216d64cce02bbb5"
  # my project Jenkins agent i used: ami-09216d64cce02bbb5
  instance_type               = "t2.micro"
  subnet_id                   = element(var.private_subnets, count.index)
  associate_public_ip_address = false
  key_name                    = var.key_name
  iam_instance_profile        = aws_iam_instance_profile.instance_profile.name

  tags = merge(var.tags, map("Name", "jenkins-agent"))

  # security_groups = ["default", aws_security_group.jenkins-sg.name]
  # security_groups = [aws_security_group.jenkins-sg.name]
  vpc_security_group_ids      = [aws_security_group.jenkins-agent-sg.id]
  depends_on                  = [var.nat_gw, var.eks_cluster_id]

  # connection {
  #   host = aws_instance.jenkins_agent.public_ip
  #   user = "ec2-user"
  #   private_key = file("project_key.pem")
  # }


  connection {
    bastion_host = var.bastion_public_ips[count.index] # aws_instance.bastion[count.index].public_ip
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

# No need this, i will run this from my mac after deploy the env
# and get the kubeconfig file -> this will be uploaded to Jenkins master for the k8s plugin credentials
# provisioner "remote-exec" {
#     inline = [
#       "aws eks --region=${var.aws_region} update-kubeconfig --name ${local.cluster_name}"
#     ]
#   }
# }