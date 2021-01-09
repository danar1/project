##################################################################################
# DATA
##################################################################################

data "aws_availability_zones" "available" {}


data "aws_ami" "ubuntu-18" {
  most_recent = true
  owners      = [var.ubuntu_ami_owner]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}