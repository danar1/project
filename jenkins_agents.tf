resource "aws_instance" "jenkins_agent" {
  count                       = var.jenkins_agent_count
  ami                         = "ami-04d29b6f966df1537"
  instance_type               = var.instance_type
  subnet_id                   = module.vpc.private_subnets[count.index]
  associate_public_ip_address = false
  key_name                    = aws_key_pair.project_key.key_name

  tags = merge(local.common_tags, map("Name", "Jenkins Agent"))

  # security_groups = ["default", aws_security_group.jenkins-sg.name]
  # security_groups = [aws_security_group.jenkins-sg.name]
  vpc_security_group_ids      = [aws_security_group.jenkins-sg.id]
  depends_on                  = [module.vpc.nat_gw]

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

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install docker git java-1.8.0 -y",
      "sudo systemctl enable docker",
      "sudo service docker start",
      "sudo usermod -aG docker ec2-user"
    ]
  }
}