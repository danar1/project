# Allocate the EC2 kibana instance
resource "aws_instance" "kibana" {
  ami           = data.aws_ami.ubuntu_logging.id
  instance_type = "t3.medium"
  subnet_id     = var.private_subnets[0]
  vpc_security_group_ids = [aws_security_group.logging_kibana.id, var.consul-security-group]
  key_name               = var.key_name
  depends_on             = [var.nat_gw_id]
  user_data              = file("${path.module}/kibana.sh.tmpl")
  iam_instance_profile {
    name = var.consul-role
  }
  tags = merge(var.tags, {"Name" = "kibana", "Consul" = "consul-agent"})
}

