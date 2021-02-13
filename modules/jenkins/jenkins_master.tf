##################################################################################
# Jenkins master
##################################################################################
resource "aws_instance" "jenkins_master" {
  # ami                         = "ami-07d0cf3af28718ef8" 
  # ami                         = "ami-0130abd2105a5e1c6" 
  # ami                         = "ami-03c2702ee825ff2d5" 
  ami                         = "ami-0bc4b672a160308cd"
  # my project jenkins server AMI: ami-0130abd2105a5e1c6, ami-03c2702ee825ff2d5 (this is with k8s and two slaves, jenkins-master-img2, ami-0bc4b672a160308cd jenkins-master-img3)
  instance_type               = "t3.micro"
  key_name                    = var.key_name
  subnet_id                   = var.private_subnets[0]
  associate_public_ip_address = false

  tags = merge(var.tags, map("Name", "jenkins-master"))

  
  vpc_security_group_ids      = [aws_security_group.jenkins-master-sg.id]
  depends_on                  = [var.nat_gw_id]

  # user_data                   = <<EOF
  # #!/bin/bash
  # sudo apt-get update -y
  # sudo apt install docker.io -y
  # sudo systemctl start docker
  # sudo systemctl enable docker
  # sudo usermod -aG docker ubuntu
  # mkdir -p ${local.jenkins_home}
  # sudo chown -R 1000:1000 ${local.jenkins_home}
  # sudo docker run -d --restart=always -p 8080:8080 -p 50000:50000 -v ${local.jenkins_home_mount} -v ${local.docker_sock_mount} --env ${local.java_opts} jenkins/jenkins
  # EOF

  # connection {
  #   host = aws_instance.jenkins_master.public_ip
  #   user = "ubuntu"
  #   private_key = file("project_key.pem")
  # }

  
  
  connection {
    bastion_host = var.bastion_public_ips[0]
    host         = self.private_ip
    user         = "ubuntu"
    private_key  = file(var.key_file)
    
  }



# this
#  provisioner "remote-exec" {
#     inline = [
#       "sudo apt-get update -y",
#       "sudo apt install docker.io -y",
#       "sudo systemctl start docker",
#       "sudo systemctl enable docker",
#       "sudo usermod -aG docker ubuntu",
#       "mkdir -p ${local.jenkins_home}",
#       "sudo chown -R 1000:1000 ${local.jenkins_home}",
#       "sudo docker run -d --restart=always -p 8080:8080 -p 50000:50000 -v ${local.jenkins_home_mount} -v ${local.docker_sock_mount} --env ${local.java_opts} jenkins/jenkins"

#     ]
#   }



}






