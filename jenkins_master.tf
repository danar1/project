

# locals {
#   jenkins_default_name = "jenkins"
#   jenkins_home = "/home/ubuntu/jenkins_home"
#   jenkins_home_mount = "${local.jenkins_home}:/var/jenkins_home"
#   docker_sock_mount = "/var/run/docker.sock:/var/run/docker.sock"
#   java_opts = "JAVA_OPTS='-Djenkins.install.runSetupWizard=false'"
# }

# resource "aws_security_group" "jenkins" {
#   name = local.jenkins_default_name
#   vpc_id = aws_vpc.vpc.id
#   description = "Allow Jenkins inbound traffic"

#   ingress {
#     from_port = 443
#     to_port = 443
#     protocol = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port = 8080
#     to_port = 8080
#     protocol = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port = 22
#     to_port = 22
#     protocol = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     description = "Allow all outgoing traffic"
#     from_port = 0
#     to_port = 0
#     // -1 means all
#     protocol = "-1"
#     cidr_blocks = [
#       "0.0.0.0/0"
#     ]
#   }
  
#   tags = {
#     Name = local.jenkins_default_name
#   }
# }

resource "aws_security_group" "jenkins-sg" {
  name = "jenkins-sg"
  vpc_id = module.vpc.id
  description = "Allow Jenkins inbound traffic"

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # security_groups = [aws_security_group.jenkins-lb-sg.id]
  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # security_groups = [aws_security_group.jenkins-lb-sg.id]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = [aws_security_group.bastion-ssh.id]
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
    Name = "jenkins-sg"
  }
}


resource "aws_instance" "jenkins_server" {
  ami                         = "ami-07d0cf3af28718ef8"
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.project_key.key_name
  subnet_id                   = module.vpc.private_subnets[0]
  associate_public_ip_address = false

  tags = merge(local.common_tags, map("Name", "Jenkins Server"))

  # security_groups = ["default", aws_security_group.jenkins-sg.name]
  # security_groups = [aws_security_group.jenkins-sg.name]
  vpc_security_group_ids      = [aws_security_group.jenkins-sg.id]
  depends_on                  = [module.vpc.nat_gw]
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
  #   host = aws_instance.jenkins_server.public_ip
  #   user = "ubuntu"
  #   private_key = file("project_key.pem")
  # }

  
  
  connection {
    bastion_host = aws_instance.bastion[0].public_ip
    host         = self.private_ip
    user         = "ubuntu"
    # private_key  = file("project_key")
    private_key  = file(var.key_file)
    
  }



  # provisioner "remote-exec" {
  #   inline = [
  #     "sudo apt-get update -y",
  #     "sudo apt install docker.io -y",
  #     "sudo systemctl start docker",
  #     "sudo systemctl enable docker",
  #     "sudo usermod -aG docker ubuntu",
  #     "mkdir -p ${local.jenkins_home}",
  #     "sudo chown -R 1000:1000 ${local.jenkins_home}"
  #   ]
  # }
  # provisioner "remote-exec" {
  #   inline = [
  #     "sudo docker run -d --restart=always -p 8080:8080 -p 50000:50000 -v ${local.jenkins_home_mount} -v ${local.docker_sock_mount} --env ${local.java_opts} jenkins/jenkins"
  #   ]
  # }
 

# this
 provisioner "remote-exec" {
    inline = [
      "sudo touch dana",
      "sudo apt-get update -y",
      "sudo apt install docker.io -y",
      "sudo systemctl start docker",
      "sudo systemctl enable docker",
      "sudo usermod -aG docker ubuntu",
      "mkdir -p ${local.jenkins_home}",
      "sudo chown -R 1000:1000 ${local.jenkins_home}",
      "sudo docker run -d --restart=always -p 8080:8080 -p 50000:50000 -v ${local.jenkins_home_mount} -v ${local.docker_sock_mount} --env ${local.java_opts} jenkins/jenkins"

    ]
  }



}
