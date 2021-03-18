# Allocate the EC2 elasticsearch instance
resource "aws_instance" "elasticsearch" {
  ami           = data.aws_ami.ubuntu_logging.id
  instance_type = "t3.medium"
  subnet_id     = var.private_subnets[0]
  vpc_security_group_ids = [aws_security_group.logging_elasticsearch.id, var.consul-security-group]
  key_name               = var.key_name
  depends_on             = [var.nat_gw_id]
  user_data              = file("${path.module}/elasticsearch.sh.tmpl")
  iam_instance_profile {
    name = var.consul-role
  }
  tags = merge(var.tags, {"Name" = "elasticsearch", "Consul" = "consul-agent"})
  
}





