##################################################################################
# DATA
##################################################################################

data "aws_ami" "ubuntu1804" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_instances" "consul-servers" {
  instance_tags = {
    Name = "consul-server"
  }
  depends_on = [aws_autoscaling_group.consul-asg]
}