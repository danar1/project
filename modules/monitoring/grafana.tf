# Allocate the EC2 grafana instance
resource "aws_instance" "grafana" {
  ami           = data.aws_ami.ubuntu_monitor.id
  instance_type = "t2.micro"
  subnet_id     = var.private_subnets[0]
  vpc_security_group_ids = [aws_security_group.monitor_grafana.id, var.consul-security-group]
  key_name               = var.key_name
  depends_on             = [var.nat_gw_id, aws_instance.prometheus]
  iam_instance_profile {
    name = var.consul-role
  }
  tags = merge(var.tags, {"Name" = "grafana", "Consul" = "consul-agent"})

  connection {
    bastion_host = var.bastion_public_ips[0]
    host         = self.private_ip
    bastion_user = "ubuntu"
    user         = "ubuntu"
    private_key  = file(var.key_file)
  }

  # Todo - need to change this to only run grafana - i get error Error: stat monitoring_folders: no such file or directory
  # provisioner "file" {
  #     # source      = "./monitoring_folders"
  #     source      = "monitoring_folders"
  #     destination = "/home/ubuntu/monitoring_folders"
  #   }

  provisioner "file" {
      source      = var.monitoring_folder
      destination = "/home/ubuntu"
    }
  
  provisioner "remote-exec" {
    inline = ["sudo chmod 755 monitoring_folders/setup/inst_docker.sh",
              "sudo monitoring_folders/setup/inst_docker.sh",
              "cd monitoring_folders/compose",
              "sudo docker-compose -f docker-compose-grafana.yml up -d"]
  }

}