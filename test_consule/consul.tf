#################################################################################
# Consul + Ansible server
##################################################################################

module "consul" {
  source               = "../modules/consul/hw1/terraform" 
  region               = var.aws_region
  ubuntu_ami_owner     = var.ubuntu_ami_owner
  ansible_server_ami   = var.project_ubuntu_ami 
  consul_servers_count = 3
  consul_agent_count   = 0
  vpc_id               = var.vpc_id
  subnet_id            = var.subnet_id
  ingress_ports        = var.ingress_ports
  # port_22_security_groups = var.port_22_security_groups
  key_file            = var.key_file
  key_name            = aws_key_pair.project_key.key_name
}