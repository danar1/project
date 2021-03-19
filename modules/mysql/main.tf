##################################################################################
# mysql instance
##################################################################################
resource "aws_instance" "mysql" {
  count                       = var.mysql_count
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = element(var.subnet_ids, count.index)
  associate_public_ip_address = false
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.mysql-sg.id, var.consul-security-group]
  depends_on                  = [var.nat_gw_id[count.index % count]]
  user_data                   = file("${path.module}/mysql.sh.tmpl")
  tags = merge(var.tags, {"Name" = "mysql-${count.index}", "Consul" = "consul-agent"})

  iam_instance_profile {
    name = var.consul-role
  }

  
  connection {
    bastion_host = var.bastion_public_ips[count.index % count]
    host         = self.private_ip
    bastion_user = "ubuntu"
    user         = "ubuntu"
    private_key  = file(var.key_file)
  }

}